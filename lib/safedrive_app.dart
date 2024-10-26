import 'package:flutter/material.dart';
import 'package:safedrive/features/notification/presentation/pages/notification_list_page.dart';
import 'package:safedrive/features/vehicle/presentation/pages/vehicle_list_page.dart';
import 'package:safedrive/features/vehicle/presentation/pages/add_vehicle_page.dart';

class SafeDriveApp extends StatefulWidget {
  const SafeDriveApp({Key? key}) : super(key: key);

  @override
  _SafeDriveAppState createState() => _SafeDriveAppState();
}

class _SafeDriveAppState extends State<SafeDriveApp> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const VehicleListPage(), // Página de lista de vehículos
    const AddVehiclePage(), // Página para agregar vehículos
    const NotificationListPage(), // Página de notificaciones
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Vehicle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800], // Color del ítem seleccionado
        unselectedItemColor: Colors.black, // Color del ítem no seleccionado
        backgroundColor: const Color.fromARGB(
            255, 237, 137, 255), // Color de fondo de la barra de navegación
        onTap: _onItemTapped,
      ),
    );
  }
}
