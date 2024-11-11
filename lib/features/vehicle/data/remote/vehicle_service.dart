import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:safedrive/core/app_constants.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleService {
  Future<List<VehicleModel>> getVehicles() async {
    try {
      final url =
          Uri.parse('${AppConstants.vehiclesUrl}${AppConstants.vehicles}');
      http.Response response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> json = jsonDecode(response.body);
        return json.map((map) => VehicleModel.fromJson(map)).toList();
      String? token = await getToken();

      if (token != null) {
        final url = Uri.parse('${AppConstants.baseURL}/vehicles');
        http.Response response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == HttpStatus.ok) {
          List<dynamic> json = jsonDecode(response.body);
          return json.map((map) => VehicleModel.fromJson(map)).toList();
        } else if (response.statusCode == HttpStatus.unauthorized) {
          print('Error 401: No autorizado');
        }
      } else {
        print('Token no encontrado. Por favor, inicia sesión.');
      }
    } catch (e) {
      print('Error fetching vehicles: $e');
    }
    return [];
  }

  Future<bool> postVehicle(VehicleModel vehicle) async {
    try {
      final url =
          Uri.parse('${AppConstants.vehiclesUrl}${AppConstants.vehicles}');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(vehicle.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response.statusCode == HttpStatus.created;
    } catch (e) {
      print('Error posting vehicle: $e');
      return false;
    }
      
      String? token = await getToken();

      if (token != null) {
        print('Token: $token');
        

        final url = Uri.parse('${AppConstants.baseURL}/vehicles');
        print('URL: $url');

        
        final requestBody = jsonEncode(vehicle.toJson());
        print('Request body: $requestBody');

        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: requestBody,
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        return response.statusCode == HttpStatus.created;
      } else {
        print('Token no encontrado. Por favor, inicia sesión.');
      }
    } catch (e) {
      print('Error posting vehicle: $e');
    }
    return false;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
