// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

// Endpoint base
final Uri baseUrl =
    Uri.parse('https://671bc4d72c842d92c3813d71.mockapi.io/api/v1/users');

// Función para registrar un usuario
Future<String> registerUser(
    String username, String email, String mobile, String password) async {
  try {
    // Verificar si el usuario ya existe
    final existingUsersResponse = await http.get(baseUrl);
    if (existingUsersResponse.statusCode == 200) {
      final List<dynamic> users = json.decode(existingUsersResponse.body);
      final userExists = users.any(
          (user) => user['username'] == username || user['email'] == email);
      if (userExists) {
        return "El usuario o email ya están en uso.";
      }
    }

    // Registrar nuevo usuario
    final response = await http.post(
      baseUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": username,
        "email": email,
        "mobile_number": mobile,
        "password": password
      }),
    );

    if (response.statusCode == 201) {
      return "Usuario registrado exitosamente";
    } else {
      return "Error en el registro. Intente nuevamente.";
    }
  } catch (e) {
    print("Error en el registro: $e");
    return "Error al registrar. Verifique la conexión.";
  }
}

// Función para iniciar sesión
Future<String> loginUser(String username, String password) async {
  try {
    final response = await http.get(baseUrl);

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);

      // Validación de usuario y contraseña
      final user = users.firstWhere(
        (user) => user['username'] == username && user['password'] == password,
        orElse: () => null,
      );

      // Verificación de usuario nulo
      if (user != null) {
        return "Login exitoso";
      } else {
        return "Usuario o contraseña incorrectos";
      }
    } else {
      return "Error en la petición. Intente nuevamente.";
    }
  } catch (e) {
    print("Error en el login: $e");
    return "Error en el login. Verifique la conexión.";
  }
}
