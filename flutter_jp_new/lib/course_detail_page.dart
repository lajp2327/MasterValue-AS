import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'video_player_page.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseName;
  final String courseImage;

  CourseDetailPage({required this.courseName, required this.courseImage});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final List<String> modules = [
    'Introducción',
    'Conceptos Básicos',
    'Avanzados',
    'Prácticas',
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  void _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource('audio/Podcast.mp3'));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del curso
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.courseImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            
            // Nombre del curso
            Text(
              widget.courseName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            
            // Descripción del curso
            Text(
              'Descripción del curso',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            
            // Módulos del curso
            _buildSectionTitle('Módulos del Curso:'),
            _buildModuleList(),
            SizedBox(height: 20),
            
            // Material del curso
            _buildSectionTitle('Material del Curso:'),
            _buildMaterialList(),
            SizedBox(height: 20),
            
            // Botón para ver video
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Ver Video'),
            ),
            SizedBox(height: 20),
            
            // Reproductor de audio
            _buildAudioPlayer(),
            SizedBox(height: 20),
            
            // Progreso del curso
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Text(
              'Progreso: 60%',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            
            // Insignias
            _buildSectionTitle('Insignias:'),
            _buildBadges(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
    );
  }

  Widget _buildModuleList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: modules.map((module) => Text('• $module')).toList(),
    );
  }

  Widget _buildMaterialList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1. Material de Texto'),
        Text('2. PDFs'),
        Text('3. Videos'),
      ],
    );
  }

  Widget _buildAudioPlayer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Reproductor de Audio:'),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.teal),
              onPressed: _playPauseAudio,
            ),
            SizedBox(width: 10),
            Text(
              '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
        SizedBox(height: 10),
        Slider(
          value: _position.inSeconds.toDouble(),
          max: _duration.inSeconds.toDouble(),
          onChanged: (value) async {
            await _audioPlayer.seek(Duration(seconds: value.toInt()));
          },
          activeColor: Colors.teal,
          inactiveColor: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildBadges() {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.grey),
        Icon(Icons.star, color: Colors.grey),
      ],
    );
  }
}