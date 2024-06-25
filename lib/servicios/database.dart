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
        String path = join(await getDatabasesPath(), 'eco_radar.db');

        return await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) async {
                await db.execute('''
          CREATE TABLE estados (
            id_estado INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre_estado TEXT,
            nombre_municipio TEXT
          )
        ''');

                await db.execute('''
          CREATE TABLE direcciones (
            id_direccion INTEGER PRIMARY KEY AUTOINCREMENT,
            id_estado INTEGER,
            nombre_colonia TEXT,
            nombre_calle TEXT,
            cp INTEGER,
            num_exterior INTEGER,
            num_interior INTEGER,
            FOREIGN KEY (id_estado) REFERENCES estados (id_estado)
          )
        ''');

                await db.execute('''
          CREATE TABLE materiales (
            id_materiales INTEGER PRIMARY KEY AUTOINCREMENT,
            material TEXT
          )
        ''');

                await db.execute('''
          CREATE TABLE horarios (
            id_horarios INTEGER PRIMARY KEY AUTOINCREMENT,
            horario TEXT
          )
        ''');

                await db.execute('''
          CREATE TABLE users (
            id_user INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            apellido_p TEXT,
            apellido_m TEXT,
            email TEXT,
            telefono INTEGER,
            id_direccion INTEGER NOT NULL,
            FOREIGN KEY (id_direccion) REFERENCES direcciones (id_direccion)
          )
        ''');

                await db.execute('''
          CREATE TABLE recycling_centers (
            idrecyclingcenter INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre_rc TEXT,
            materiales TEXT,
            id_direccion INTEGER NOT NULL,
            id_horarios INTEGER NOT NULL,
            FOREIGN KEY (id_direccion) REFERENCES direcciones (id_direccion),
            FOREIGN KEY (id_horarios) REFERENCES horarios (id_horarios)
          )
        ''');
            },
        );
    }
}
