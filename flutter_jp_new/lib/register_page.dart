import 'package:flutter/material.dart';
import 'complete_profile_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  void _register() {
    setState(() {
      _errorMessage = '';
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Las contraseñas no coinciden';
      });
      return;
    }

    // Navegar a la siguiente pantalla para completar el perfil
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompleteProfilePage(email: email, password: password),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text('Regístrate'),
        backgroundColor: Color.fromARGB(159, 0, 0, 0),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [Color.fromARGB(159, 84, 171, 149), Color(0xFF5AC375)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Siguiente'),
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
    );
  }
}