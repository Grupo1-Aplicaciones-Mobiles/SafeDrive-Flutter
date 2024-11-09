import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Endpoints base
final Uri signUpUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/authentication/sign-up');
final Uri signInUrl = Uri.parse(
    'https://safedrive-service-a94843fe8d53.herokuapp.com/api/v1/authentication/sign-in');

// Función para registrar un usuario
Future<String> registerUser(
    String name, String username, String password, String phoneNumber) async {
  try {
    final response = await http.post(
      signUpUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': name,
        'username': username,
        'password': password,
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 201) {
      return "Usuario registrado exitosamente.";
    } else {
      return "Error al registrar usuario: ${response.body}";
    }
  } catch (e) {
    return "Error de conexión: $e";
  }
}

// Función para iniciar sesión
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

      // Guardar el token en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      // Redirigir a la pantalla principal
      Navigator.pushReplacementNamed(context, '/home');

      return "Inicio de sesión exitoso.";
    } else {
      return "Error al iniciar sesión: ${response.body}";
    }
  } catch (e) {
    return "Error de conexión: $e";
  }
}

// Función para verificar si el usuario está logueado
Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('jwt_token');
}
