import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/profile_picture.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Nombre: Juan Pablo Pérez Valadez',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
              'Estudiante de Ingeniería en Sistemas Computacionales',
              style: TextStyle(
                fontSize: 16, 
                color: Colors.grey,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Agrega la lógica para editar el perfil
              },
              child: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal),
              ),
          ],
        ),
      ),
    );
  }
}