import 'package:flutter/material.dart';
import 'home_page.dart';
import 'course_page.dart';
import 'glossary_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'complete_profile_page.dart';
import 'servicios/database.dart'; // Importa el archivo de base de datos

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper db = DatabaseHelper();
  await db.database; // Inicializa la base de datos

  runApp(MasterValueApp());
}

class MasterValueApp extends StatelessWidget {
  static const Color myColor = Color(0xFF54AB95); // Color en formato ARGB
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Value',
      theme: ThemeData(
        primarySwatch: Colors.green, // Define el tono primario, por ejemplo verde
        primaryColor: myColor, // Usa el color personalizado como primaryColor
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/register': (context) => RegisterPage(),
        '/completeProfile': (context) => CompleteProfilePage(email: '', password: '',),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CoursePage(),
    GlossaryPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Value', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Glossary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}