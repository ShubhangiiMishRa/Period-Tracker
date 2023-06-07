// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:nexus/models/history_page_model.dart';
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sqflite.dart';
//
// import '../models/signup_page_model.dart';
//
// class SignupApi{
//   static String tableName = "signup_page";
//   static RxList<SignupPageModel> signupPageModel = RxList<SignupPageModel>.empty(growable: true);
//   static Future<void> createTables(sql.Database database) async {
//     await database.execute("""CREATE TABLE $tableName(
//         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         name TEXT,
//         email TEXT,
//         phonenumber TEXT,
//         age TEXT,
//         sexualActivity TEXT,
//         firstdate TEXT,
//         daysInCycle TEXT,
//         periodFlowDay TEXT,
//         createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//       )
//       """);
//   }
//   static Future<sql.Database> db() async {
//     return sql.openDatabase('$tableName.db', version: 1,
//         onCreate: (sql.Database database, int version) async {
//           await createTables(database);
//         });
//   }
//   static Future<int> createItem(
//       String name, String email, String phonenumber,String age, String sexualActivity, String firstdate, String daysInCycle, String periodFlowDay) async {
//     final db = await SignupApi.db();
//     final data = {
//       'name': name,
//       'email': email,
//       'phonenumber': phonenumber,
//       'age': age,
//       'sexualActivity': sexualActivity,
//       'firstdate': firstdate,
//       'daysInCycle': daysInCycle,
//       'periodFlowDay': periodFlowDay,
//     };
//     final id = await db.insert(tableName, data,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     getItems();
//     return id;
//   }
//
//   /// Read a single data by id
//   static Future<List<Map<String, dynamic>>> getItem(int id) async {
//     final db = await SignupApi.db();
//     return db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
//   }
//
//   /// Read first date
//   static Future<List<Map<String, dynamic>>> getfirstdate(String firstDate) async {
//     final db = await SignupApi.db();
//     return db.query(tableName, where: "firstDate = ?", whereArgs: [firstDate], limit: 1);
//   }
//
//   /// Read days in cycle
//   static Future<List<Map<String, dynamic>>> getdaysincycle(String daysInCycle) async {
//     final db = await SignupApi.db();
//     return db.query(tableName, where: "daysInCycle = ?", whereArgs: [daysInCycle], limit: 1);
//   }
//
//   /// Read days in cycle
//   static Future<List<Map<String, dynamic>>> getperiodflow(String periodFlowDay) async {
//     final db = await SignupApi.db();
//     return db.query(tableName, where: "periodFlowDay = ?", whereArgs: [periodFlowDay], limit: 1);
//   }
//   /// Read all data
//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await SignupApi.db();
//     final data = await db.query(tableName, orderBy: "id");
//     signupPageModel((signupPageModelFromJson(jsonEncode(data))));
//     return data;
//   }
//
//   /// Delete
//   static Future<void> deleteItem(int id) async {
//     final db = await SignupApi.db();
//     try {
//       await db.delete(tableName, where: "id = ?", whereArgs: [id]);
//       // getItems();
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
//
//   /// Delete All
//   static Future<void> deleteAllItem() async {
//     final db = await SignupApi.db();
//     try {
//       await db.delete(tableName);
//       // getItems();
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
//
// }