import 'package:camera_app/models/place.dart';
import "package:sqflite/sqflite.dart" as sql;
import "package:path/path.dart" as path;

class DBhelper {
  //Now create database object and return it to avoid boilerplate
  static Future<sql.Database> _database() async {
    final dbpath = await sql.getDatabasesPath();

    return await sql.openDatabase(path.join(dbpath, 'places'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE  placesTable (id Text PRIMARY KEY,title TEXT,image STRING ,lat TEXT,long TEXT,mapUrl TEXT,adress TEXT)');
    }, version: 1);
  }
  //declare & define a static method to input or create data base

  static Future<void> insert(String name, Map<String, Object> data) async {
    final newDb = await DBhelper._database();
    print('database opened');
    newDb.insert(name, data, conflictAlgorithm: sql.ConflictAlgorithm.fail);
     
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    
    var newDb = await DBhelper._database();
    return newDb.query(table);
  }
}
