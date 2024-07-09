import 'package:flutter/material.dart';
import 'video_player_page.dart';

class CourseDetailPage extends StatelessWidget {
  final String courseName;
  final String courseImage;

  CourseDetailPage({required this.courseName, required this.courseImage});

  final List<String> modules = [
    'Introducción',
    'Conceptos Básicos',
    'Avanzados',
    'Prácticas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(courseImage, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(
              courseName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Descripción del curso',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Módulos del Curso:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            for (String module in modules) Text('• $module'),
            SizedBox(height: 20),
            Text(
              'Material del Curso:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('1. Material de Texto'),
            Text('2. PDFs'),
            Text('3. Videos'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoPlayerPage(videoUrl: 'assets/video/sample_video.mp4'),
                  ),
                );
              },
              child: Text('Ver Video'),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Text('Progreso: 60%'),
            SizedBox(height: 20),
            Text(
              'Insignias:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.grey),
                Icon(Icons.star, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}