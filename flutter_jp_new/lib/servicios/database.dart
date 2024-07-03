import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    String path = join(await getDatabasesPath(), 'eco_radar_new.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id_user INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        apellido_p TEXT,
        apellido_m TEXT,
        email TEXT,
        telefono INTEGER,
        password TEXT
      )
    ''');
  }

  Future<int> insertarUsuario(String nombre, String apellidoP, String apellidoM, String email, int telefono, String password) async {
    var db = await database;
    return await db.insert(
      'users',
      {
        'nombre': nombre,
        'apellido_p': apellidoP,
        'apellido_m': apellidoM,
        'email': email,
        'telefono': telefono,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> authenticateUser(String nombre, String password) async {
    var db = await database;
    var result = await db.query(
      'users',
      where: 'nombre = ? AND password = ?',
      whereArgs: [nombre, password],
    );
    return result.isNotEmpty;
  }
}