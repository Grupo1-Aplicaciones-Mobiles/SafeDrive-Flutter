import 'package:flutter/material.dart';
import 'package:safedrive/features/notification/presentation/pages/notification_list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: NotificationListPage(),
      ),
    );
  }
}
