import 'package:flutter/material.dart';
import 'package:safedrive/features/vehicle/presentation/pages/add_vehicle_page.dart';
import 'package:safedrive/features/vehicle/presentation/pages/vehicle_list_page.dart';

class SafeDriveApp extends StatefulWidget {
  const SafeDriveApp({Key? key}) : super(key: key);

  @override
  _SafeDriveAppState createState() => _SafeDriveAppState();
}

class _SafeDriveAppState extends State<SafeDriveApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    VehicleListPage(), // Página de lista de vehículos
    AddVehiclePage(), // Página para agregar vehículos
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
