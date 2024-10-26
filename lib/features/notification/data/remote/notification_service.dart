import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:safedrive/core/app_constants.dart';
import 'package:safedrive/features/notification/data/remote/notification_model.dart';

class NotificationService {
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final url = Uri.parse(
          '${AppConstants.notificationsUrl}${AppConstants.notifications}');
      http.Response response = await http.get(url);

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> json = jsonDecode(response.body);
        return json.map((map) => NotificationModel.fromJson(map)).toList();
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }
}
