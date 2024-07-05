import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'course_page.dart';
import 'glossary_page.dart';
import 'servicios/database.dart';

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
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Cursos Populares',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
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
              items: img.map((item) => _buildCarouselItem(item)).toList(),
            ),
            SizedBox(height: 20),
            _buildCoursesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Master Value"),
            accountEmail: Text("mastervalue@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "MV",
                style: TextStyle(fontSize: 40.0, color: Colors.teal),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/drawer_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
    );
  }

  Widget _buildCarouselItem(String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 5.0,
          ),
        ],
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