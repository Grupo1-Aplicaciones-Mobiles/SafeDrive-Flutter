import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safedrive/features/vehicle/presentation/pages/vehicle_list_page.dart';
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
      home: Scaffold(
        body: VehicleListPage(),
      ),
    );
  }
}
