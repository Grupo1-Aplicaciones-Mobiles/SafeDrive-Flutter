import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:safedrive/core/app_constants.dart';
import 'package:safedrive/features/vehicle/data/remote/vehicle_model.dart';

class VehicleService {
  Future<List<VehicleModel>> getVehicles() async {
    try {
      final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.vehicles}');
      http.Response response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> json = jsonDecode(response.body);
        return json.map((map) => VehicleModel.fromJson(map)).toList();
      }
    } catch (e) {
      print('Error fetching vehicles: $e');
    }
    return [];
  }

  Future<bool> postVehicle(VehicleModel vehicle) async {
    try {
      final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.vehicles}');
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
  }
}
