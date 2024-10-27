import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {

  // SQLite database ka storage instance .
  Database? _dataBase;

  //Get Database  Method
  Future<Database> getDataBase() async {
    if (_dataBase != null) {
      return _dataBase!;
    }

    // Database Path
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "Education"); // Add .db extension

    // Open the Database
    _dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Education ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title TEXT, "
              "description TEXT, type TEXT)",
        );

        // Create Auth Table FOR LOGIN/SIGNUP
        await db.execute(
          'CREATE TABLE IF NOT EXISTS AUTH'
              '(id TEXT PRIMARY KEY, userName TEXT, userEmail TEXT,userPassword TEXT, islogin INEGER )',
        );
        log('AUTH TABLE CREATE');
      },

    );

    return _dataBase!;
  }
  // SignUp Method
  Future<int> signupNewUser(Map<String, dynamic> userData) async {
    final db = await getDataBase();
    return await db.insert("AUTH", userData);
  }
  // Insert Method
  Future<int> insertNewUser(Map<String, dynamic> data) async {
    final db = await getDataBase();
    final result = await db.insert("Education", data);
    return result;
  }

  // Show All Notes in ListView
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await getDataBase();
    return await db.query("Education");
  }

  // Update Method
  Future<int> update(Map<String, dynamic> data) async {
    final db = await getDataBase();
    return await db.update(
      "Education",
      data,
      where: "id = ?",
      whereArgs: [data['id']],
    );
  }

  // Delete Method
  Future<int> delete(int id) async {
    final db = await getDataBase();
    return await db.delete(
      "Education",
      where: "id = ?",
      whereArgs: [id],
    );
  }


}
