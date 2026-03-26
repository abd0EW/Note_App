// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/User.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// // class DataBaseHelper {
// //   static final DataBaseHelper instance = DataBaseHelper._internal();

// //   DataBaseHelper._internal();

// //   Database? database;

// //   Future<Database?> get getdb async {
// //     if (database != null) {
// //       return database;
// //     } else {
// //       database = await initData();
// //       return database;
// //     }
// //   }

// //   Future<Database?> initData() async {
// //     String pathdb = await getDatabasesPath();
// //     String path = await join(pathdb, "mydataBase.db");
// //     Database database = await openDatabase(
// //    ersion) {
// //         db.execute('''
// //            CREATE TABLE "USERS"(
// //            "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
// //            "note" TEXT NOT   path,
// //       version: 2,
// //       onCreate: (db, v NULL

// //            )
// //          ''');
// //       },
// //     );
// //     return database;
// //   }

// //   // create->
// //   Future<int?> Adduser(User user) async {
// //     final data = await instance.getdb;
// //     return data!.insert("USERS", user.tomap());
// //   }

// //   // read-> or get ->
// //   Future<List<User>> getData() async {
// //     final db = await getdb;

// //     final result = await db!.query("USERS");

// //     return result.map((m) => User.formJson(m)).toList();
// //   }

// //   //Updata->

// //   Future upDate(int id, User user) async {
// //     final _Data = await getdb;
// //     return _Data!.update("USERS", user.tomap(), where: "id=?", whereArgs: [id]);
// //   }

// //   //Delete->

// //   Future delete(int id) async {
// //     final _Data = await getdb;
// //     return _Data!.delete("USERS", where: "id=?", whereArgs: [id]);
// //   }
// // }

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._internal();

//   DatabaseHelper._internal();
//   Database? database1;
//   Future get Data async {
//     if (database1 != null) {
//       return database1;
//     } else if (database1 == null) {
//       database1 = await initDatabase();
//       return database1;
//     }
//   }

//   Future<Database?> initDatabase() async {
//     String getPath = await getDatabasesPath();
//     String path = await join(getPath);
//     Database database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
// CREATE TABLE "USERS"(
// "email" TEXT NOT NULL , 
// "Password" TEXT NOT NULL , 
// "Id"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
// "postId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
// "name" TEXT NOT NULL , 
// "body"  TEXT NOT NULL 
// )
//       ''');
//       },
//     );
//     return database;
//   }

//   // create -> ADD
//   Future<int?> Add(User user) async {
//     final add = await instance.Data;
//     return add.insert("USERS", user.toJson());
//   }

//   // read-> or get ->
//   Future<List<User>> getData() async {
//     final db = await Data;

//     final result = await db!.query("USERS");

//     return result.map((m) => User.fromJson(m)).toList();
//   }

//   //Updata->

//   Future upDate(int id, User user) async {
//     final _Data = await Data;
//     return _Data!.update(
//       "USERS",
//       user.toJson(),
//       where: "id=?",
//       whereArgs: [id],
//     );
//   }

//   //Delete->

//   Future delete(int id) async {
//     final _Data = await Data;
//     return _Data!.delete("USERS", where: "id=?", whereArgs: [id]);
//   }

//   Future<User?> GetEmail(String email) async {
//     Database? database;
//     final res = await database!.query(
//       "USERS",
//       where: "email = ? ",
//       whereArgs: [email],
//     );

//     if (res.isEmpty)
//       return null;
//     else {
//       return User.fromJson(res as Map<String, dynamic>);
//     }
//   }
// }
