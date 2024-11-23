import 'package:flutter/material.dart';
import 'package:safedrive/features/notification/data/remote/notification_model.dart';
import 'package:safedrive/features/notification/data/remote/notification_service.dart';
import 'package:safedrive/features/notification/presentation/widgets/notification_list_item.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  List<NotificationModel> _notifications = [];

  Future<void> _loadData() async {
    List<NotificationModel> notifications = await NotificationService().getNotifications();
    setState(() {
      // Ordenar las notificaciones por fecha
      notifications.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      _notifications = notifications;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avisos y Notificaciones:'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: NotificationService().getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay notificaciones.'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return NotificationListItem(
                  notificationModel: snapshot.data![index],
                );
              },
            );
          } else {
            return const Center(child: Text('Algo salió mal.'));
          }
        },
      ),
    );
  }
}
