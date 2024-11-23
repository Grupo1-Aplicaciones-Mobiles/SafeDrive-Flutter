import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_service.dart';
import 'package:safedrive/core/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? mapController;
  List<VehicleModel> vehicles = [];
  VehicleModel? selectedVehicle;
  LatLng? vehicleLocation;
  Set<Marker> markers = {};
  LatLng? userLocation;
  String trackingMessage = "";

  @override
  void initState() {
    super.initState();
    fetchUserLocation();
    fetchVehicles();
  }

  Future<void> fetchUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId != null) {
      final response = await http.get(
        Uri.parse('${AppConstants.baseURL}/users/$userId/coordinates'),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('jwt_token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latitude = data['latitude'] ?? -12.186313;
        final longitude = data['longitude'] ?? -77.009879;

        setState(() {
          userLocation = LatLng(latitude, longitude);
        });

        print("Ubicación del usuario: Lat: $latitude, Lon: $longitude");

        if (mapController != null && userLocation != null) {
          mapController?.animateCamera(CameraUpdate.newLatLng(userLocation!));

          markers.add(
            Marker(
              markerId: MarkerId('user_location'),
              position: userLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              infoWindow: InfoWindow(
                title: 'Tu ubicación',
                snippet: 'Ubicación actual del usuario',
              ),
            ),
          );
        }
      } else {
        print('Error al obtener la ubicación del usuario: ${response.body}');
      }
    }
  }

  Future<void> fetchVehicles() async {
    VehicleService vehicleService = VehicleService();
    List<VehicleModel> vehicleList = await vehicleService.getVehicles();
    setState(() {
      vehicles = vehicleList;
    });
  }

  Future<LatLng> fetchVehicleLocation(int vehicleId) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('${AppConstants.baseURL}/vehicles/$vehicleId/coordinates'),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('jwt_token')}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final latitude = data['latitude'] ?? -12.182494;
      final longitude = data['longitude'] ?? -77.000117;

      return LatLng(latitude, longitude);
    } else {
      print('Error al obtener la ubicación del vehículo: ${response.body}');
      return LatLng(-12.182494, -77.000117);
    }
  }

  Future<void> fetchTrackingDistance(int vehicleId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId != null) {
      final response = await http.get(
        Uri.parse('${AppConstants.baseURL}/tracking/distance?userId=$userId&vehicleId=$vehicleId'),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('jwt_token')}',
        },
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            trackingMessage = response.body; // La respuesta es un string con el mensaje
          });

          // Guardar la notificación en SharedPreferences
          await prefs.setString('vehicle_notification', response.body);

          print("Mensaje de seguimiento guardado: $trackingMessage");
        }
      } else {
        print('Error al obtener la distancia: ${response.body}');
      }
    }
  }

  double calculateDistance(LatLng start, LatLng end) {
    const double radiusEarth = 6371;
    double dLat = _degreesToRadians(end.latitude - start.latitude);
    double dLon = _degreesToRadians(end.longitude - start.longitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) *
            cos(_degreesToRadians(end.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radiusEarth * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void onVehicleSelected(VehicleModel vehicle) async {
    if (vehicle.id != null) {
      LatLng fetchedLocation = await fetchVehicleLocation(vehicle.id!);
      setState(() {
        selectedVehicle = vehicle;
        vehicleLocation = fetchedLocation;

        fetchTrackingDistance(vehicle.id!);

        mapController?.animateCamera(CameraUpdate.newLatLng(fetchedLocation));
        markers.removeWhere((marker) => marker.markerId.value != 'user_location');
        markers.add(
          Marker(
            markerId: MarkerId(vehicle.placa),
            position: fetchedLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(
              title: "${vehicle.marca} ${vehicle.modelo}",
              snippet: "Placa: ${vehicle.placa}",
            ),


          ),
        );
      });
    } else {
      print("El ID del vehículo es nulo. No se puede obtener su ubicación.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rastrear'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) => mapController = controller,
              initialCameraPosition: CameraPosition(

                target: userLocation ?? LatLng(0, 0),
                zoom: 15,
              ),
              markers: markers,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Selecciona un vehículo:', style: TextStyle(fontWeight: FontWeight.bold)),

                DropdownButton<VehicleModel>(
                  value: selectedVehicle,
                  hint: Text('Selecciona vehículo'),
                  onChanged: (VehicleModel? newValue) {
                    if (newValue != null) onVehicleSelected(newValue);
                  },
                  items: vehicles.map<DropdownMenuItem<VehicleModel>>(
                      (VehicleModel vehicle) {
                    return DropdownMenuItem<VehicleModel>(
                      value: vehicle,
                      child: Text('${vehicle.marca} - ${vehicle.modelo}'),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                Text("Ubicación:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(vehicleLocation != null
                    ? "Lat: ${vehicleLocation!.latitude.toStringAsFixed(6)}, Lon: ${vehicleLocation!.longitude.toStringAsFixed(6)}"
                    : "Seleccione un vehículo"),
                SizedBox(height: 10),
                Text("Distancia y tiempo estimado:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(trackingMessage.isNotEmpty
                    ? trackingMessage
                    : "Seleccione un vehículo para ver los detalles"),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
