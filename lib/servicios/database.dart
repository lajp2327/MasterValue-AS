import 'pacage:sqflite/sqflite.dart';

import 'pacage:path/path.dart';

//La clase database nos permite hacer una sola instancia de la case "DB" para todo el proyecto y así evitar 
//múltiples conexiones a la base de datos
class DatabaseHelper {
    static final DatabaseHelper _instance = DatabaseHelper._internal();
    factory DatabaseHelper() => _instance;
que es una función asincrónica y como se relaciona con wait
    static Database? _database;

    DatabaseHelper._internal();

    Future<Database> get database async {
        if (_database != null) {
            return _database!;
        }
        _database = await initDB();
        return _database!;
    }

    Future<Database> _initDatabase() async {

        String path = join(await getDatabasePath()