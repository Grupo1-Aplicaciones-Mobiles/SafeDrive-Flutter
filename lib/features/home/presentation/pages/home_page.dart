// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safedrive/features/home/data/tip_model.dart';
import 'package:safedrive/features/home/data/tip_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safedrive/feature/register_and_login/data/remote/user_service.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_service.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  List<TipAuto> tips = [];
  List<VehicleModel> _vehicles = [];
  String? _username;

  final LatLng _center =
      const LatLng(37.7749, -122.4194); // Coordenadas de San Francisco

  @override
  void initState() {
    super.initState();
    fetchTipsData();
    _loadUserData();
    _loadVehicles();
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

  Future<void> _loadUserData() async {
    try {
      final userData = await getUserData();
      setState(() {
        _username = userData['username'];
      });
    } catch (e) {
      print('Error al cargar los datos del usuario: $e');
    }
  }

  Future<void> _loadVehicles() async {
    try {
      final vehicles = await VehicleService().getVehicles();
      setState(() {
        _vehicles = vehicles;
      });
    } catch (e) {
      print('Error al cargar los vehículos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Ocultar la barra de app
        backgroundColor: Colors.deepPurple,

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
                        'Bienvenido(a) de nuevo',

                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _username ??
                            'Cargando...', // Muestra el nombre del usuario
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
            Container
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = _vehicles[index];
                  return VehicleCard(
                      image: vehicle.imageUri, name: vehicle.marca);
                },
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
          Image.network(image,
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

