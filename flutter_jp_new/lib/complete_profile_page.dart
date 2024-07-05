import 'package:flutter/material.dart';
import 'package:master_value/login_page.dart';
import 'servicios/database.dart';

class CompleteProfilePage extends StatefulWidget {
  final String email;
  final String password;

  CompleteProfilePage({required this.email, required this.password});

  @override
  _CompleteProfilePageState createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoPController = TextEditingController();
  final TextEditingController _apellidoMController = TextEditingController();
  DateTime? _selectedDate;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  String _errorMessage = '';

  void _completeProfile() async {
    setState(() {
      _errorMessage = '';
    });

    String nombre = _nombreController.text;
    String apellidoP = _apellidoPController.text;
    String apellidoM = _apellidoMController.text;
    String fechaNacimiento = _selectedDate != null ? _selectedDate.toString() : '';

    await _dbHelper.insertarUsuario(widget.email, widget.password, nombre, apellidoP, apellidoM, fechaNacimiento);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()),
    );  // Regresa a la pantalla anterior o a la pantalla de inicio de sesión
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completa tu perfil'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Aquí puedes agregar la lógica para seleccionar la foto de perfil
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage('assets/img/profile_picture.png'), // Imagen de perfil por defecto
                ),
              ),
              SizedBox(height: 20),
              Text(
                '¿Cuál es tu nombre?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _apellidoPController,
                decoration: InputDecoration(
                  labelText: 'Apellido Paterno',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _apellidoMController,
                decoration: InputDecoration(
                  labelText: 'Apellido Materno',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context), // Abre el selector de fechas al hacer clic
                child: AbsorbPointer(
                  child: TextField(
                    controller: TextEditingController(text: _selectedDate?.toString() ?? ''),
                    decoration: InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _completeProfile,
                child: Text('Completar Perfil'),
              ),
              SizedBox(height: 10),
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}