// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safedrive/login_screen.dart';
import 'package:safedrive/register_screen.dart';
import 'package:safedrive/upload_photo_screen.dart';
// import 'package:getwidget/getwidget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeDrive Login',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // Se definen las rutas de la aplicación
        '/': (context) => LoginPage(), // Ruta inicial
        '/register': (context) => RegisterPage(),
        '/upload_photo': (context) => UploadPhotoPage(),
      },
    );
  }
}
