import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// La clase database nos permite hacer una sola instancia de la clase "DB" para todo el proyecto y así evitar
// múltiples conexiones a la base de datos
class DatabaseHelper {
    static final DatabaseHelper _instance = DatabaseHelper._internal();
    factory DatabaseHelper() => _instance;

    static Database? _database;

    DatabaseHelper._internal();

    Future<Database> get database async {
        if (_database != null) {
            return _database!;
        }
        _database = await _initDatabase();
        return _database!;
    }

    Future<Database> _initDatabase() async {
        String path = join(await getDatabasesPath(), 'master_value.db');

        return await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) {
                // Tablas de base de datos
                db.execute('''
          CREATE TABLE my_table (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
            },
        );
    }
}
