import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Rastreo'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Avisos'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta'),
      ],
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
    );
  }
}
