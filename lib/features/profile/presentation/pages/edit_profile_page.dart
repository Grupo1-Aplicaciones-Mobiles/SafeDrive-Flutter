import 'package:flutter/material.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileAvatar(showEditIcon: true), // Activamos el icono de edición
            SizedBox(height: 16),
            Text('New Name:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el nuevo nombre',
              ),
            ),
            SizedBox(height: 16),
            Text('New Email:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el nuevo correo electrónico',
              ),
            ),
            SizedBox(height: 16),
            Text('New Phone Number:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el nuevo número de teléfono',
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para guardar los cambios
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(), // Usando el widget de la barra de navegación
    );
  }
}
