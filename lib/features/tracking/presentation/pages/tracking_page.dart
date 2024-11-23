import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_service.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? mapController;
  List<VehicleModel> vehicles = [];
  VehicleModel? selectedVehicle;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    VehicleService vehicleService = VehicleService();
    List<VehicleModel> vehicleList = await vehicleService.getVehicles();
    setState(() {
      vehicles = vehicleList;
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void moveCameraToVehicleLocation(VehicleModel vehicle) {
    final LatLng vehiclePosition = LatLng(vehicle.latitude, vehicle.longitude);

    // Mueve la cámara a la ubicación del vehículo
    mapController?.animateCamera(CameraUpdate.newLatLng(vehiclePosition));

    // Actualiza el marcador en el mapa
    setState(() {
      markers = {
        Marker(
          markerId: MarkerId(vehicle.placa), // Usa la placa como ID único
          position: vehiclePosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            // Mostrar información del vehículo al precionar el marcador
            title: "${vehicle.marca} ${vehicle.modelo}",
            snippet: "Placa: ${vehicle.placa}",
          ),
        ),
      };
    });
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
          // Mapa
          Expanded(
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(-12.200674,
                    -77.00322), // Pronto se pondrá la ubicacion del usuario
                zoom: 15,
              ),
              markers: markers,
            ),
          ),
          // Selección y detalles
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selecciona un vehiculo:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<VehicleModel>(
                  value: selectedVehicle,
                  hint: Text('Selecciona vehiculo'),
                  onChanged: (VehicleModel? newValue) {
                    setState(() {
                      selectedVehicle = newValue;
                    });
                    if (newValue != null) {
                      moveCameraToVehicleLocation(newValue);
                    }
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
                Text("Ubicación: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(selectedVehicle != null
                    ? "Lat: ${selectedVehicle!.latitude}, Lon: ${selectedVehicle!.longitude}"
                    : "Seleccione un vehículo"),
                SizedBox(height: 10),
                Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(selectedVehicle != null
                    ? "Activo"
                    : "Seleccione un vehículo"),
                SizedBox(height: 10),
                Text("Distancia (Km):",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    selectedVehicle != null ? "0.0" : "Seleccione un vehículo"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
