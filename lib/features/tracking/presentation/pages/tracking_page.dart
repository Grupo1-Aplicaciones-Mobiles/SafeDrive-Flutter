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

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    VehicleService vehicleService = VehicleService();
    List<VehicleModel> vehicleList = await vehicleService.getVehicles();
    setState((){
      vehicles = vehicleList;
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rastrear'),
      ),
      body: Column(
        children: [
          // Mapa
          Expanded(
            child: GoogleMap(
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(-12.200674, -77.00322),
                zoom: 15,
              ),
            ),
          ),
          // Sleccion y detalles
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selecciona un vehiculo:', style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<VehicleModel>(
                  value: selectedVehicle,
                  hint: Text('Selecciona vehiculo'),
                  onChanged: (VehicleModel? newValue) {
                    setState(() {
                      selectedVehicle = newValue;
                    });
                  },
                  items: vehicles.map<DropdownMenuItem<VehicleModel>>((VehicleModel vehicle) {
                    return DropdownMenuItem<VehicleModel>(
                      value: vehicle,
                      child: Text(vehicle.marca + ' - ' + vehicle.modelo),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text("Ubicación: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(selectedVehicle != null ? "Latitud: ... Longitud: ..." : "Seleccione un vehículo"),
                SizedBox(height: 10),
                Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(selectedVehicle != null ? "Activo" : "Seleccione un vehículo"),
                SizedBox(height: 10),
                Text("Distancia (Km):", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(selectedVehicle != null ? "0.0" : "Seleccione un vehículo"),
              ],
            ),
          )
        ]
      )
    );
  }
}