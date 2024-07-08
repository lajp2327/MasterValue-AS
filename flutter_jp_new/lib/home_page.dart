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
              accountEmail: Text("mastervalue@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "MV",
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
            _buildCoursesSection(), // Integrar la nueva sección de cursos
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

  Widget _buildCoursesSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tus Cursos',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Colors.teal[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildCourseCard(
            'Finanzas Personales',
            'Carlos López',
            0.60, // 60% de progreso
            Icons.monetization_on_rounded,
            Colors.orange,
          ),
          _buildCourseCard(
            'Inversiones y Bolsa de Valores',
            'María González',
            0.83, // Curso completado
            Icons.trending_up,
            Colors.green,
          ),
          _buildCourseCard(
            'Contabilidad Básica',
            'Ana Rodríguez',
            0.36, // 36% de progreso
            Icons.account_balance,
            Colors.blue,
          ),
          _buildCourseCard(
            'Planeación Financiera',
            'José Martínez',
            0.15, // 15% de progreso
            Icons.bar_chart,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(String title, String subtitle, double progress, IconData icon, Color iconColor) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, color: iconColor),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.teal[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      color: Colors.teal[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: iconColor,
                    minHeight: 5,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}% completado',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: Colors.teal[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}