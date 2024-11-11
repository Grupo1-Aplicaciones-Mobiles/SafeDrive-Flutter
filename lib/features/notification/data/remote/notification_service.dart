import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:safedrive/core/app_constants.dart';
import 'package:safedrive/features/notification/data/remote/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  Future<List<NotificationModel>> getNotifications() async {
    try {
      String? token = await getToken();

      if (token != null) {
        final url = Uri.parse('${AppConstants.baseURL}/notifications');
        http.Response response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        print('Status: ${response.statusCode}');
        print('Body: ${response.body}');

        if (response.statusCode == HttpStatus.ok) {
          List<dynamic> json = jsonDecode(response.body);
          return json.map((map) => NotificationModel.fromJson(map)).toList();
        } else if (response.statusCode == HttpStatus.unauthorized) {
          print('Error 401: No autorizado');
        }
      } else {
        print('Token no encontrado. Por favor, inicia sesión.');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
