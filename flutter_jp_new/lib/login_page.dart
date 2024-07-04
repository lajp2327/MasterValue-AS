import 'package:flutter/material.dart';
import 'servicios/database.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  String _errorMessage = '';
  bool _isButtonPressed = false;

  void _login() async {
    setState(() {
      _errorMessage = '';
      _isButtonPressed = true;
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    bool isAuthenticated = await _dbHelper.authenticateUser(username, password);

    if (isAuthenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  void _goToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF54AB95), Color(0xFF5AC375)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               SizedBox(height: 20),
               Text(
                 'Master Value',
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontSize: 36,
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                 ),
               ),

               SizedBox(height: 20),
               Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10),
                    ),
                  ],
                ),
               child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset('assets/img/logoo.jpeg',
                  height: 100,),
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  'Bienvenido!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Padding(padding: const
                EdgeInsets.symmetric(horizontal:20.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(padding: const
                EdgeInsets.symmetric(horizontal:20.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _errorMessage.isEmpty ? null : _errorMessage,
                  ),
                  obscureText: true,
                  ),
                ),
                SizedBox(height: 20),
                AnimatedOpacity(opacity: _isButtonPressed ? 0.5 : 1.0, duration: Duration(milliseconds: 200),
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('Iniciar Sesión',
                    style: TextStyle(
                      color: Colors.white, // Asegura que el color del texto sea blanco
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _goToRegisterPage,
                  child: Text('¿No tienes cuenta aún?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
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
}