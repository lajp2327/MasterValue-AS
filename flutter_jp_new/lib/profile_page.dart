import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'servicios/database.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  ProfilePage({required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _description = 'Añade una descripción breve...';
  File? _profileImage;
  String _name = 'Nombre Desconocido';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    var userData = await DatabaseHelper().getUserData(widget.email);
    
    if (userData.isNotEmpty) {
      setState(() {
        _description = userData['descripcion'] ?? _description;
        _name = '${userData['nombre']} ${userData['apellido_p']} ${userData['apellido_m']}';
        if (userData['imagePath'] != null) {
          _profileImage = File(userData['imagePath']);
        }
      });
    }
  }

  void _editDescription() {
    final descriptionController = TextEditingController(text: _description);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Editar Descripción'),
        content: TextField(
          controller: descriptionController,
          decoration: InputDecoration(labelText: 'Descripción'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: Text('Guardar'),
            onPressed: () async {
              setState(() {
                _description = descriptionController.text.isNotEmpty
                    ? descriptionController.text
                    : 'Añade una descripción breve...';
              });
              Navigator.of(ctx).pop();
              await DatabaseHelper().updateProfile({
                'descripcion': _description,
                'email': widget.email,
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await DatabaseHelper().updateProfile({
        'imagePath': pickedFile.path,
        'email': widget.email,
      });
    }
  }

  void _showImageSourceSelection() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Seleccionar imagen'),
        actions: [
          TextButton(
            onPressed: () {
              _pickImage(ImageSource.camera);
              Navigator.of(ctx).pop();
            },
            child: Text('Tomar foto'),
          ),
          TextButton(
            onPressed: () {
              _pickImage(ImageSource.gallery);
              Navigator.of(ctx).pop();
            },
            child: Text('Elegir de la galería'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _editName() {
    final nameController = TextEditingController(text: _name);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Editar Nombre'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Nombre Completo'),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: Text('Guardar'),
            onPressed: () async {
              setState(() {
                _name = nameController.text.isNotEmpty ? nameController.text : 'Nombre Desconocido';
              });
              Navigator.of(ctx).pop();
              await DatabaseHelper().updateProfile({
                'nombre': _name.split(' ')[0],
                'apellido_p': _name.split(' ')[1],
                'apellido_m': _name.split(' ').length > 2 ? _name.split(' ')[2] : '',
                'email': widget.email,
              });
            },
          ),
        ],
      ),
    );
  }

  // Nueva función para mostrar las opciones de edición
  void _showEditOptions() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Editar Perfil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Editar Nombre'),
              onTap: () {
                Navigator.of(ctx).pop(); // Cerrar el diálogo actual
                _editName(); // Abrir el editor de nombre
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Editar Descripción'),
              onTap: () {
                Navigator.of(ctx).pop(); // Cerrar el diálogo actual
                _editDescription(); // Abrir el editor de descripción
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Cambiar Imagen de Perfil'),
              onTap: () {
                Navigator.of(ctx).pop(); // Cerrar el diálogo actual
                _showImageSourceSelection(); // Seleccionar nueva imagen
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

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
            GestureDetector(
              onTap: _showImageSourceSelection,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : AssetImage('assets/img/profile_picture.png') as ImageProvider,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _editName,
              child: Text(
                '$_name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _editDescription,
              child: Text(
                _description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showEditOptions, // Asignar la nueva función al botón
              child: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}