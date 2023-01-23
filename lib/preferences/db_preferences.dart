import 'dart:io';

import 'package:examen_practic/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase dedicada a guardar los datos en la base de datos SQFLITE,
/// para asi tener persistencia

class DBPreferences {
  static Database? _database;

  static final DBPreferences db = DBPreferences._();

  DBPreferences._();

  Future<Database> get database async {
    if (_database == null) _database = await initDb();

    return _database!;
  }

  /// Para iniciar la base de datos
  Future<Database> initDb() async {
    // Obtenir es path
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'Despesa.db');

    // Creació de la BBDD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE Despesa(
          id INTEGER PRIMARY KEY,
          titol TEXT,
          quantitat FLOAT
        )
        ''');
      },
    );
  }

  // Amb JSON
  Future<int> insertScan(Despesa scan) async {
    final db = await database;

    final res = await db.insert('Despesa', scan.toMap());

    return res;
  }

  // Collir tots els camps
  Future<List<Despesa>> getAllScans() async {
    final db = await database;

    final res = await db.query('Despesa');

    return res.isNotEmpty ? res.map((e) => Despesa.fromMap(e)).toList() : [];
  }

  // Per borrar tots
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Despesa');

    return res;
  }

  // Per borrar per ID
  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('Despesa', where: 'id = ?', whereArgs: [id]);

    return res;
  }
}
