import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingrese todos los campos';
        _isButtonPressed = false;
      });
      return;
    }

    bool isAuthenticated = await _dbHelper.authenticateUser(username, password);

    if (isAuthenticated) {
      try {
        String userEmail = await _dbHelper.getUserEmail(username);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(email: userEmail),
          ),
        );
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al obtener el email del usuario';
          _isButtonPressed = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Nombre de usuario o contraseña incorrectos';
        _isButtonPressed = false;
      });
    }
  }

  void _goToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void _signInWithGoogle() async {
    // Simulación de inicio de sesión con Google (abrir URL en navegador)
    const url = 'https://accounts.google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _signInWithFacebook() async {
    // Simulación de inicio de sesión con Facebook (abrir URL en navegador)
    const url = 'https://facebook.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(159, 84, 171, 149), Color(0xFF5AC375)],
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
                    child: Image.asset(
                      'assets/img/logoo.jpg',
                      height: 100,
                    ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                AnimatedOpacity(
                  opacity: _isButtonPressed ? 0.5 : 1.0,
                  duration: Duration(milliseconds: 200),
                  child: ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        color: Colors.white,
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
                  child: Text(
                    '¿No tienes cuenta aún?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signInWithGoogle,
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _signInWithFacebook,
                  child: Text(
                    'Sign in with Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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