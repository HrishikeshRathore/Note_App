import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/product.dart';
class DatabaseNote{

  static Future<Database> databaseNotes() async {
    return openDatabase(

  join(await getDatabasesPath(), 'note_database.db'),

  onCreate: (db, version) async {

  return await db.execute(
  "CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, description TEXT, date TEXT, archive INTEGER)",
  );
  },
  version: 1);
  }


  static Future<void> insertNote(Product product) async{
    final db = await DatabaseNote.databaseNotes();

    await db.insert(
      'notes',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  static Future<List<Map<String, dynamic>>> getNotes() async {
    // Get a reference to the database.
    final db = await DatabaseNote.databaseNotes();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return maps;

  }

  static Future<void> updateNote(Product product) async{
    final db = await DatabaseNote.databaseNotes();

    await db.update(
      'notes',
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
  }

  static Future<void> deleteNote(String id) async{
    final db = await DatabaseNote.databaseNotes();

    await db.delete(
      'notes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}