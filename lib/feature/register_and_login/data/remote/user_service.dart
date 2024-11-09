import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


final Uri signUpUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/authentication/sign-up');
final Uri signInUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/authentication/sign-in');


Future<String> registerUser(
    String name, String username, String password, String phoneNumber) async {
  final requestData = {
    'name': name,
    'username': username,
    'password': password,
    'phoneNumber': phoneNumber,
    'roles': ['ROLE_MEMBER']
  };

  final headers = {"Content-Type": "application/json"};

  // Imprimir los datos que se enviarán al servidor
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
        print('Error al registrar usuario: Código de estado ${response.statusCode}');
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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      
      Navigator.pushReplacementNamed(context, '/home');

      print('Response body: ${response.body}');
      return "Inicio de sesión exitoso.";
    } else {
      return "Error al iniciar sesión: ${response.body}";
    }
  } catch (e) {
    return "Error de conexión: $e";
  }
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('jwt_token');
}
