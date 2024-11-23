import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final Uri signUpUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/authentication/sign-up');
final Uri signInUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/authentication/sign-in');

final Uri updateUserDetailsUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/users/update/details');

final Uri updateUserImageUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/users/update/image');

Future<String> registerUser(
    String name, String username, String password, String phoneNumber) async {
  final requestData = {
    'name': name,
    'username': username,
    'password': password,
    'phoneNumber': phoneNumber,
    'roles': ['ROLE_ADMIN']
  };

  final headers = {"Content-Type": "application/json"};

  print('Datos de registro: ${json.encode(requestData)}');
  print('Encabezados: $headers');
  print('URL de registro: $signUpUrl');

  try {
    final response = await http.post(
      signUpUrl,
      headers: headers,
      body: json.encode(requestData),
    );

    if (response.statusCode == 201) {
      return "Usuario registrado exitosamente.";
    } else {
      if (response.body.isNotEmpty) {
        final errorResponse = json.decode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Error desconocido';
        print('Error al registrar usuario: $errorMessage');
        return "Error al registrar usuario: $errorMessage";
      } else {
        print(
            'Error al registrar usuario: Código de estado ${response.statusCode}');
        return "Error al registrar usuario: Código de estado ${response.statusCode}";
      }
    }
  } catch (e) {
    print('Error de conexión: $e');
    return "Error de conexión: $e";
  }
}

Future<String> loginUser(
    String username, String password, BuildContext context) async {
  try {
    final response = await http.post(
      signInUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];
      final userId = data['id'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      await prefs.setInt('userId', userId);
      await prefs.setString('user_id', userId.toString());


      Navigator.pushReplacementNamed(context, '/home');

      print('Token: $token');
      print('UserId: $userId');
      return "Inicio de sesión exitoso.";
    } else {
      print('Error al iniciar sesión: ${response.body}');
      return "Error al iniciar sesión: ${response.body}";
    }
  } catch (e) {
    print('Error de conexión: $e');
    return "Error de conexión: $e";
  }
}

Future<String> updateUserDetails(
    String userId, String name, String username, String phoneNumber) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    return "Token no encontrado. Por favor, inicia sesión.";
  }

  final requestData = {
    'userId': userId,
    'name': name,
    'username': username,
    'phoneNumber': phoneNumber,
  };

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  try {
    final response = await http.put(
      updateUserDetailsUrl,
      headers: headers,
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      return "Datos actualizados exitosamente.";
    } else {
      print('Error al actualizar datos: ${requestData}');
      return "Error al actualizar datos: ${response.body}";
    }
  } catch (e) {
    return "Error de conexión: $e";
  }
}

Future<String> updateUserImage(String userId, String imageUrl) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');

  if (token == null) {
    return "Token no encontrado. Por favor, inicia sesión.";
  }

  final requestData = {
    'userId': userId,
    'imageUrl': imageUrl,
  };

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  try {
    final response = await http.put(
      updateUserImageUrl,
      headers: headers,
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      return "Imagen actualizada exitosamente.";
    } else {
      return "Error al actualizar imagen: ${response.body}";
    }
  } catch (e) {
    return "Error de conexión: $e";
  }
}

Future<Map<String, String>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('user_id');
  final token = prefs.getString('jwt_token');

  if (userId == null || token == null) {
    throw Exception('User ID or token not found');
  }

  final url = Uri.parse(
      'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/users/$userId');
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return {
      'username': data['username'],
      'phoneNumber': data['phoneNumber'],
    };
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('jwt_token');
}
