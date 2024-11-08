// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safedrive/features/home/presentation/pages/home_page.dart';
import 'package:safedrive/features/tracking/presentation/pages/tracking_page.dart';
import 'package:safedrive/features/vehicle/presentation/pages/vehicle_list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
