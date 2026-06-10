import 'dart:io';
import 'package:practise_sqflite/contactmodal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class Dbhelper {

  Dbhelper._();

  static Dbhelper instance = Dbhelper._();
  static Database? _db;

  static final String tableName = 'contactTable';
  static final String idColumn = 'id';
  static final String nameColumn = 'name';
  static final String emailColumn = 'email';
  static final String phoneColumn = 'phone';

  Future<Database> getDB() async{
    return _db ?? await initDB();
  }

  Future<Database> initDB() async{
    Directory dir = await getApplicationDocumentsDirectory(); 
    String path = join(dir.path,'contact.db');
    return await openDatabase(path, version: 1,onCreate: (db, version) {
      db.execute('''

           CREATE TABLE $tableName(
            $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameColumn TEXT,
            $emailColumn TEXT,
            $phoneColumn INTEGER
           )
        ''');
    },);
  }

  Future<int> insertData(ContactModal modal) async{
    Database db = await getDB();
    return await db.insert(tableName, modal.toMap());
  }

  Future<int> updateData(ContactModal modal) async{
    Database db = await getDB();
    return await db.update(tableName, modal.toMap(), where: '$idColumn = ?', whereArgs: [modal.id]);
  }

  Future<int> deleteData(ContactModal modal) async{
    Database db = await getDB();
    return await db.delete(tableName, where: '$idColumn = ?', whereArgs: [modal.id]);
  }

  Future<List<ContactModal>> getData() async{
    Database db = await getDB();
    final rows = await db.query(tableName);
    return rows.map((c)=> ContactModal.fromMap(c)).toList();
  }

}