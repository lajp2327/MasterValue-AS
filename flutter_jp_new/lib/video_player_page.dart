import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  VideoPlayerPage({required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  Future<List<Map<String, dynamic>>>? _recordsFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    // Inicializa la obtención de registros de la base de datos
    _recordsFuture = fetchAllRecords();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchAllRecords() async {
    // Ruta a la base de datos
    String path = join(await getDatabasesPath(), 'master_value.db');
    
    // Abre la base de datos
    Database db = await openDatabase(path);

    // Consulta para obtener todas las tablas en la base de datos
    List<Map<String, dynamic>> tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table";');
    
    // Lista para almacenar los registros
    List<Map<String, dynamic>> allRecords = [];

    // Imprime los registros de cada tabla
    for (var table in tables) {
      String tableName = table['name'];
      List<Map<String, dynamic>> records = await db.query(tableName);
      
      // Agrega los registros a la lista
      allRecords.add({'table': tableName, 'records': records});
    }

    // Cierra la base de datos
    await db.close();

    return allRecords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : CircularProgressIndicator(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _recordsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No records found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final tableData = snapshot.data![index];
                      final tableName = tableData['table'];
                      final records = tableData['records'] as List<Map<String, dynamic>>;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Table: $tableName',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...records.map((record) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Text(record.toString()),
                            );
                          }).toList(),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}