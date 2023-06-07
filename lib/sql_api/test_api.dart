// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:nexus/model/book_list_model.dart';
// // import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//
// class BookNameApi {
//   static RxList<BookListModel> bookListModel =
//   RxList<BookListModel>.empty(growable: true);
//   static String tableName = "book_name";
//
//   static Future<void> createTables(Database database) async {
//     await database.execute("""CREATE TABLE $tableName(
//         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//         name TEXT,
//         standard TEXT,
//         medium TEXT,
//         author TEXT,
//         createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
//       )
//       """);
//   }
//
//   static Future<Database> db() async {
//     sqfliteFfiInit();
//     var databaseFactory = databaseFactoryFfi;
//     return databaseFactory.openDatabase(
//       '$tableName.db',
//       options: OpenDatabaseOptions(
//         version: 1,
//         onCreate: (Database database, int version) async {
//           await createTables(database);
//         },
//       ),
//     );
//   }
//
//   /// Create
//   static Future<int> createItem(
//       String name, String standard, String medium) async {
//     final db = await BookNameApi.db();
//
//     final data = {'name': name, 'standard': standard, 'medium': medium};
//     final id = await db.insert(tableName, data,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     getItems();
//     return id;
//   }
//
//   /// Read all data
//   static Future<List<Map<String, dynamic>>> getItems() async {
//     final db = await BookNameApi.db();
//     final data = await db.query(tableName, orderBy: "id");
//     bookListModel((bookListModelFromJson(jsonEncode(data))));
//     return data;
//   }
//
//   /// Read a single data by id
//   static Future<List<Map<String, dynamic>>> getItem(int id) async {
//     final db = await BookNameApi.db();
//     return db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
//   }
//
//   /// Update an item by id
//   static Future<int> updateItem(
//       int id, String name, String standard, String medium) async {
//     final db = await BookNameApi.db();
//
//     final data = {
//       'name': name,
//       'standard': standard,
//       'medium': medium,
//       'createdAt': DateTime.now().toString()
//     };
//
//     final result =
//     await db.update(tableName, data, where: "id = ?", whereArgs: [id]);
//     getItems();
//     return result;
//   }
//
//   /// Delete
//   static Future<void> deleteItem(int id) async {
//     final db = await BookNameApi.db();
//     try {
//       await db.delete(tableName, where: "id = ?", whereArgs: [id]);
//       getItems();
//     } catch (err) {
//       debugPrint("Something went wrong when deleting an item: $err");
//     }
//   }
// }
