// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safedrive/features/home/data/tip_model.dart';
import 'package:safedrive/features/home/data/tip_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  int _selectedIndex = 0;
  List<TipAuto> tips = [];

  final LatLng _center =
      const LatLng(37.7749, -122.4194); // Coordenadas de San Francisco

  @override
  void initState() {
    super.initState();
    fetchTipsData();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> fetchTipsData() async {
    try {
      List<TipAuto> fetchedTips = await fetchTips();
      setState(() {
        tips = fetchedTips;
      });
    } catch (e) {
      print('Error fetching tips: $e');
    }
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                onTap: (LatLng position) {
                  Navigator.pushNamed(context, '/tracking');
                },
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
              color: Colors.white,
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
                  VehicleCard(
                      image: 'assets/img/SafeDrive_Logo.png',
                      name: 'BMW Mayuko'),
                  VehicleCard(
                      image: 'assets/img/SafeDrive_Logo.png',
                      name: 'BMW Mayuko'),
                ],
              ),
            ),
            // Sección de Noticias y Tips
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Noticias Y Tips:',
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
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width - 32,
                    margin: EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            tips[index].imagen,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 1,
                          child: Text(
                            tips[index].contenido,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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

class TipCard extends StatelessWidget {
  final String image;
  final String content;

  TipCard({required this.image, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Image.network(image,
              height: 100,
              fit: BoxFit.cover), // Reemplaza con la ruta de tu imagen
          SizedBox(height: 8),
          Text(content,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}
