// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:safedrive/register_screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15),
                Image.asset('assets/img/SafeDrive_Logo.png',
                    height: 120), // Imagen del logo SafeDrive
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
                _buildTextField('Username', false),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Lógica para recuperar contraseña
                    },
                    child: Text(
                      'Forgot Username?',
                      style: TextStyle(color: Color(0XFF454B60)),
                    ),
                  ),
                ),
                _buildTextField('Password', false),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Lógica para recuperar contraseña
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0XFF454B60)),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para iniciar sesión
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20), // Increased font size
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
                    _buildSocialButton('Google', 'assets/img/google_logo.jpg'),
                    SizedBox(width: 20),
                    _buildSocialButton('Facebook', 'assets/img/facebook.png'),
                  ],
                ),

                TextButton(
                  onPressed: () {
                    // Lógica para dirigir a la siguiente pantalla
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
    );
  }

  Widget _buildTextField(String labelText, bool obscureText) {
    return TextField(
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
    );
  }

  Widget _buildSocialButton(String label, String asset) {
    return OutlinedButton.icon(
      onPressed: () {
        // Lógica para iniciar sesión con redes sociales
      },
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
