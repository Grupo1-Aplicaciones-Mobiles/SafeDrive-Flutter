import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safedrive/core/app_constants.dart';
import 'package:safedrive/features/notification/data/remote/notification_model.dart';

class NotificationService {
  Future<List<NotificationModel>> getNotifications() async {
    try {
      String? token = await getToken();
      int? userId = await getUserId();

      if (token != null && userId != null) {
        final url = Uri.parse('${AppConstants.baseURL}/notifications/user/$userId');
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
        } else {
          print('Error ${response.statusCode}: ${response.reasonPhrase}');
        }
      } else {
        print('Token o userId no encontrados. Por favor, inicia sesión.');
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

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }
}
