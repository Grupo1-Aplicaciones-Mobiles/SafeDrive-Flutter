import 'package:flutter/material.dart';
import '../widgets/profile_avatar.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileAvatar(), // Usando el widget de avatar de perfil
            SizedBox(height: 16),
            Text('Name:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nombre del usuario',
              ),
              enabled: false,
            ),
            SizedBox(height: 16),
            Text('Email:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Correo del usuario',
              ),
              enabled: false,
            ),
            SizedBox(height: 16),
            Text('Phone Number:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Número de teléfono del usuario',
              ),
              enabled: false,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text('Actualizar Información'),
            ),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurple,
              ),
              child: Text('Cerrar Sesión'),
            ),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                // Logica para borrar cuenta
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text('Borrar Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
