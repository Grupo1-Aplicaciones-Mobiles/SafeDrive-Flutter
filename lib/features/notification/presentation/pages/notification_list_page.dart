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
      body: _notifications.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return NotificationListItem(
                  notificationModel: _notifications[index],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
        child: const Icon(Icons.close),
      ),
    );
  }
}
