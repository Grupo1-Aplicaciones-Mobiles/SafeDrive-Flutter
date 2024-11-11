// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safedrive/features/tracking/presentation/pages/tracking_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:safedrive/feature/register_and_login/presentation/pages/login_page.dart';
import 'package:safedrive/feature/register_and_login/presentation/pages/register_page.dart';
import 'package:safedrive/features/notification/presentation/pages/notification_list_page.dart';
import 'package:safedrive/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:safedrive/features/profile/presentation/pages/profile_page.dart';
import 'package:safedrive/features/vehicle/presentation/pages/add_vehicle_page.dart';
import 'package:safedrive/features/vehicle/presentation/pages/vehicle_list_page.dart';
import 'package:safedrive/safedrive_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: TrackingPage(),

      title: 'SafeDrive App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Asegúrate de que la página de inicio sea LoginPage
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/vehicle_list': (context) => const VehicleListPage(),
        '/add_vehicle': (context) => const AddVehiclePage(),
        '/notifications': (context) => const NotificationListPage(),
        '/profile': (context) => const ProfilePage(),
        '/edit_profile': (context) => const EditProfilePage(),
        '/home': (context) =>
            const SafeDriveApp(), // Ruta para la barra de navegación
      },
    );
  }
}
