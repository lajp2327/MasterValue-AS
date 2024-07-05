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
    String path = join(await getDatabasesPath(), 'master_value.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id_user INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password VARCHAR,
        nombre TEXT,
        apellido_p TEXT,
        apellido_m TEXT,
        fecha_nacimiento TEXT
      )
    ''');
  }

  Future<int> insertarUsuario(String email, String password, String nombre, String apellidoP, String apellidoM, String fechaNacimiento) async {
    var db = await database;
    return await db.insert(
      'users',
      {
        'email': email,
        'password': password,
        'nombre': nombre,
        'apellido_p': apellidoP,
        'apellido_m': apellidoM,
        'fecha_nacimiento': fechaNacimiento,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> authenticateUser(String email, String password) async {
    var db = await database;
    var result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>> getUserData(String email) async {
    var db = await database;
    var result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : {};
  }
}