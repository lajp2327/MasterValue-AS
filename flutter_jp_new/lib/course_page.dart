import 'package:flutter/material.dart';
import 'course_detail_page.dart';

// Enum para las categorías de cursos
enum CourseCategory {
  All,
  Beginner,
  Intermediate,
  Advanced,
  // Puedes agregar más categorías según sea necesario
}

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

// Widget para mostrar el progreso de un curso
class CourseProgressWidget extends StatelessWidget {
  final Map<String, dynamic> course;

  CourseProgressWidget({required this.course});

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.0; // valor predeterminado

    // Verificar el tipo de 'progress' y asignar el valor apropiado
    if (course['progress'] != null) {
      if (course['progress'] is int) {
        progressValue = (course['progress'] as int).toDouble();
      } else if (course['progress'] is double) {
        progressValue = course['progress'] as double;
      } else {
        // Manejar otros tipos o valores inesperados aquí si es necesario
      }
    }

    // Devolver un CircularProgressIndicator con el valor de progreso
    return CircularProgressIndicator(
      value: progressValue,
      backgroundColor: Colors.grey[200],
    );
  }
}

class _CoursePageState extends State<CoursePage> {
  final List<Map<String, dynamic>> courses = [
    {
      'name': 'Finanzas Personales',
      'instructor': 'Carlos López',
      'progress': 0.60,
      'icon': Icons.monetization_on_rounded,
      'color': Colors.orange,
      'level': 'Intermediate',
      'image': 'assets/img/course1.jpg'
    },
    {
      'name': 'Inversiones y Bolsa de Valores',
      'instructor': 'María González',
      'progress': 1.00,
      'icon': Icons.trending_up,
      'color': Colors.green,
      'level': 'Advanced',
      'image': 'assets/img/course2.jpg'
    },
    {
      'name': 'Contabilidad Básica',
      'instructor': 'Ana Rodríguez',
      'progress': 0.36,
      'icon': Icons.account_balance,
      'color': Colors.blue,
      'level': 'Beginner',
      'image': 'assets/img/course3.jpg'
    },
    // Agrega más cursos según sea necesario
  ];

  String _searchText = '';
  CourseCategory _selectedCategory = CourseCategory.All;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Función para filtrar cursos según la categoría y el texto de búsqueda
  List<Map<String, dynamic>> getFilteredCourses() {
    return courses.where((course) {
      final levelMatches = _selectedCategory == CourseCategory.All ||
          course['level']
              .toString()
              .toLowerCase() ==
              _selectedCategory.toString().split('.').last.toLowerCase();
      final nameMatches = course['name']
          .toString()
          .toLowerCase()
          .contains(_searchText.toLowerCase());
      return levelMatches && nameMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCourses = getFilteredCourses();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tus Cursos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Campo de búsqueda
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Buscar Cursos',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Dropdown para seleccionar la categoría de cursos
                DropdownButton<CourseCategory>(
                  value: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  items: CourseCategory.values.map((category) {
                    return DropdownMenuItem<CourseCategory>(
                      value: category,
                      child: Text(category.toString().split('.').last),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailPage(
                          courseName: course['name'].toString(),
                          courseImage: course['image'].toString(),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: course['name'].toString(),
                            child: Image.asset(
                              course['image'].toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course['name'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Instructor: ${course['instructor']}',
                                style: TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              // Indicador de progreso lineal

                              Text(
                                '${((course['progress'] is int)
                                        ? (course['progress'] as int).toDouble()
                                        : (course['progress'] is double)
                                            ? course['progress'] as double
                                            : 0.0) * 100} % completado',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}