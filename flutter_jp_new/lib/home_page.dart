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
    'assets/img/course1.jpeg',
    'assets/img/course2.jpeg',
    'assets/img/course3.jpeg',
    'assets/img/course4.jpeg',
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
        title: Text('HomePage'),
      ),
      drawer: Drawer(
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
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Courses'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoursePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Glossary'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome $_userName!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'Credit and Debit',
                    'Claudia Alves',
                    'Progres: 60%',
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'Offers',
                    'Avery Davis',
                    'Completed',
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'Analysis',
                    'Yael Amari',
                    'Progres: 36%',
                  ),
                  buildCategoryItem(
                    context,
                    Icons.monetization_on_rounded,
                    'You Got This',
                    'Shawn Garcia',
                    'Progres: 15%',
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
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
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
                    fontFamily: 'Readex Pro',
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