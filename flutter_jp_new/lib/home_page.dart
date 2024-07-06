import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'course_page.dart';
import 'glossary_page.dart';
import 'servicios/database.dart';
import 'profile_page.dart'; // Importa la página de perfil
import 'settings_page.dart'; // Importa la página de configuración

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  String _userName = "Juan Pablo"; // Nombre de usuario por defecto

  // Lista de imágenes para el carrusel
  final List<String> img = [
    'assets/img/course1.jpg',
    'assets/img/course2.jpg',
    'assets/img/course3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar los datos del usuario al iniciar la página
  }

  Future<void> _loadUserData() async {
    // Aquí debes obtener el email del usuario actual, por ejemplo desde Firebase Auth
    String userEmail = 'usuario@example.com'; 

    try {
      var userData = await _databaseHelper.getUserData(userEmail);

      setState(() {
        _userName = userData['nombre'] ?? "Juan Pablo";
      });
    } catch (e) {
      // Manejo de error al cargar los datos del usuario
      print('Error cargando datos del usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_userName),
              accountEmail: Text("valadez2711@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "JP",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal, // Cambiar el fondo a color teal
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.teal),
                    title: Text('Inicio'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.teal),
                    title: Text('Cursos'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CoursePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.teal),
                    title: Text('Glosario'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GlossaryPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.teal),
              title: Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Cursos Populares',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: img.map((item) => buildCarouselItem(item)).toList(),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF54AB95), Color(0xFF5AC375)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Text(
                      'Tus Cursos',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'Introducción a la Bolsa de Valores',
                    'Claudia Alves',
                    'Progreso: 60%',
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'Finanzas Personales',
                    'Avery Davis',
                    'Completado',
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'Análisis Financiero',
                    'Yael Amari',
                    'Progreso: 36%',
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'Economía para Todos',
                    'Shawn Garcia',
                    'Progreso: 15%',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarouselItem(String imagePath) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildCategoryItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    String progress,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  progress,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}