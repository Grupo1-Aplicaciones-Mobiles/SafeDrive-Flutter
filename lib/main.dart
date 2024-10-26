// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safedrive/feature/register_and_login/presentation/pages/login_page.dart';
import 'package:safedrive/feature/register_and_login/presentation/pages/register_page.dart';
import 'package:safedrive/feature/register_and_login/presentation/pages/upload_photo_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safedrive/features/vehicle/presentation/pages/vehicle_list_page.dart';
import 'package:safedrive/safedrive_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeDriveApp(), // Aquí invocamos SafeDriveApp de manera estándar
    );
  }
}
