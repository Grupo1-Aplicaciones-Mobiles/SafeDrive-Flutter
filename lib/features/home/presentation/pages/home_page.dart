// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  final LatLng _center =
      const LatLng(37.7749, -122.4194); // Coordenadas de San Francisco

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Ocultar la barra de app
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset('assets/img/SafeDrive_Logo.png',
                      height: 70), // Reemplaza con la ruta de tu logo
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenido de nuevo',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '{Name}', // Reemplaza con el nombre del usuario
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Mapa de Google
            Container(
              height: 170,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 12.0,
                ),
              ),
            ),
            // Sección de Vehículos
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vehículos:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {}, // Añadir acción para ver todos
                    child: Text('Ver Todos'),
                  ),
                ],
              ),
            ),
            Container(
              height: 110,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  VehicleCard(
                      image: 'assets/img/SafeDrive_Logo.png',
                      name:
                          'McLaren Angga'), // Reemplaza con la ruta de tu imagen
                  VehicleCard(
                      image: 'assets/img/SafeDrive_Logo.png',
                      name: 'BMW Mayuko'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType
            .fixed, // Asegura que se muestre correctamente en todos los dispositivos
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.gps_fixed), label: 'Rastreo'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Avisos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Cuenta'),
        ],
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String image;
  final String name;

  VehicleCard({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Image.asset(image,
              height: 80,
              fit: BoxFit.cover), // Reemplaza con la ruta de tu imagen
          SizedBox(height: 8),
          Text(name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
