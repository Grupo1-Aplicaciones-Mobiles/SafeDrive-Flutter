// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_import, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safedrive/feature/register_and_login/data/remote/user_service.dart';
import 'dart:convert';
import 'package:safedrive/feature/register_and_login/presentation/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15),
                  Image.asset('assets/img/SafeDrive_Logo.png', height: 120),
                  SizedBox(height: 5),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Ingrese su usuario y contraseña para logearse',
                    style: TextStyle(fontSize: 19, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  _buildTextField('Username', false, usernameController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Username?',
                        style: TextStyle(color: Color(0XFF454B60)),
                      ),
                    ),
                  ),
                  _buildTextField('Password', true, passwordController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Color(0XFF454B60)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final username = usernameController.text;
                      final password = passwordController.text;

                      if (_formKey.currentState!.validate()) {
                        final loginMessage =
                            await loginUser(username, password);
                        // Mostrar un mensaje en pantalla según el resultado
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(loginMessage)),
                        );

                        // Si el login es exitoso, redirige al usuario
                        if (loginMessage == "Login exitoso") {
                          Navigator.pushReplacementNamed(context,
                              '/home'); // Redirigir a la pantalla de inicio
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      backgroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Or log in with',
                    style: TextStyle(fontSize: 16, color: Color(0XFF454B60)),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildSocialButton(
                          'Google', 'assets/img/google_logo.jpg'),
                      SizedBox(width: 20),
                      _buildSocialButton('Facebook', 'assets/img/facebook.png'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String labelText, bool obscureText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Color(0xFFDCD9FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildSocialButton(String label, String asset) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(asset, height: 24),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
