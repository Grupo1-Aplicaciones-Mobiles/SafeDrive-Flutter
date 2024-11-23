import 'package:flutter/material.dart';
import 'package:safedrive/features/notification/data/remote/notification_model.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    final dateTime = notificationModel.dateTime;
    final formattedDate = '${_twoDigits(dateTime.day)}/${_twoDigits(dateTime.month)}/${dateTime.year % 100}';
    final formattedTime = '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
        title: Text(notificationModel.message),
        subtitle: Text('$formattedDate $formattedTime'),
      ),
    );
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
