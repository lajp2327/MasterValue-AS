import 'package:flutter/material.dart';
import 'video_player_page.dart';

class CourseDetailPage extends StatelessWidget {
  final String courseName;

  CourseDetailPage({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Material del Curso:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    builder: (context) => VideoPlayerPage(videoUrl: 'assets/video/sample_video.mp4'),
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
          ],
        ),
      ),
    );
  }
}