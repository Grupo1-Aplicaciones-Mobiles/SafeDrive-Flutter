import 'package:flutter/material.dart';
import 'package:safedrive/features/notification/data/remote/notification_model.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Puedes personalizar esto
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
        title: Text(notificationModel.message),
        subtitle: Text(notificationModel.dateTime.toString()),
      ),
    );
  }
}
