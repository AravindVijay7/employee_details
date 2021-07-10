import 'dart:io';

import 'package:employee_details/model/employee_data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'employeeDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Employee('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'username TEXT,'
          'email TEXT,'
          'profile_image TEXT'
          ')');
    });
  }

  isDataBaseCreated() => (_database != null) ? true : false;

  createEmployee(EmployeeData newEmployee) async {
    final db = await database;
    final res = await db.insert('Employee', newEmployee.toJson());

    return res;
  }

  Future<List<EmployeeData>> getAllEmployees() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EMPLOYEE");

    List<EmployeeData> list =
        res.isNotEmpty ? res.map((c) => EmployeeData.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<EmployeeData>> getSearchedEmployees(searchKey) async {
    final db = await database;
    final res = await db.rawQuery(
      "SELECT * FROM EMPLOYEE WHERE name = $searchKey OR email = $searchKey",
    );

    List<EmployeeData> list =
        res.isNotEmpty ? res.map((c) => EmployeeData.fromJson(c)).toList() : [];

    return list;
  }
}
