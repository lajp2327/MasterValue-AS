import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Cambiar Contraseña'),
            onTap: () {
              // Agrega la lógica para cambiar la contraseña
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Idioma'),
            onTap: () {
              // Agrega la lógica para cambiar el idioma
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificaciones'),
            onTap: () {
              // Agrega la lógica para cambiar las configuraciones de notificaciones
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Sobre la App'),
            onTap: () {
              // Agrega la lógica para mostrar información sobre la app
            },
          ),
        ],
      ),
    );
  }
}
