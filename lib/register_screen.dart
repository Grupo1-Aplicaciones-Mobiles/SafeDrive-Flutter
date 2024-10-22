// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;

  // Controladores para los campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                  Image.asset('assets/img/SafeDrive_Logo.png',
                      height: 120), // Imagen del logo SafeDrive
                  SizedBox(height: 5),
                  Text(
                    'Registro',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Llene los siguientes campos de registro',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Name', _nameController, 'Please enter your name'),
                  SizedBox(height: 10),
                  _buildTextField('Email Address', _emailController,
                      'Please enter your email address'),
                  SizedBox(height: 10),
                  _buildTextField('Mobile Number', _mobileController,
                      'Please enter your mobile number'),
                  SizedBox(height: 10),
                  _buildPasswordField('Password', _passwordController,
                      'Must be 8 or more characters and contain at least 1 number or special character'),
                  SizedBox(height: 10),
                  _buildConfirmPasswordField('Confirm Password',
                      _confirmPasswordController, _passwordController),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Estoy de acuerdo con los términos y condiciones',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para dirigir a la siguiente pantalla
                      if (_formKey.currentState!.validate() && _agreeToTerms) {
                        Navigator.pushNamed(context, '/upload_photo');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 60.0),
                      backgroundColor: const Color(0xFF6C63FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 25,
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20), // Increased font size
                        textAlign: TextAlign.center,
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
      String labelText, TextEditingController controller, String errorMessage) {
    return TextFormField(
      controller: controller,
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
          return errorMessage;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(
      String labelText, TextEditingController controller, String errorMessage) {
    return TextFormField(
      controller: controller,
      obscureText: true,
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
        if (value == null ||
            value.isEmpty ||
            value.length < 8 ||
            !RegExp(r'[0-9]').hasMatch(value)) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField(
      String labelText,
      TextEditingController controller,
      TextEditingController originalPasswordController) {
    return TextFormField(
      controller: controller,
      obscureText: true,
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
        if (value == null || value != originalPasswordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}
