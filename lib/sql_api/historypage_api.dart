import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nexus/globalVariable.dart';
import 'package:nexus/models/history_page_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class HistoryPageApi {
  static String tableName = "history_page";
  static RxList<HistoryPageModel> historyPageModel =
  RxList<HistoryPageModel>.empty(growable: true);

  static RxList<List<HistoryPageModel>> savedHistoryDataModel =
  RxList<List<HistoryPageModel>>.empty(growable: true);

  // static Rx<HistoryPageModel> historyModel = HistoryPageModel().obs;

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image_path TEXT,
        image_path_svg TEXT,
        title TEXT,
        category TEXT,
        date TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('$tableName.db', version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
        });
  }

  /// Create
  static Future<int> createItem(
      String imagePath,    String imagePathSvg, String title, String category,String dateTime) async {
    final db = await HistoryPageApi.db();
    final data = {
      'image_path': imagePath,
      'image_path_svg': imagePathSvg,
      'title': title,
      'category': category,
      'date': dateTime
    };
    final id = await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    getItems();
    return id;
  }

  /// Read a single data by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await HistoryPageApi.db();
    return db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  /// Read a single data by date
  static Future<List<Map<String, dynamic>>> getItemByDateTime(String dateTime) async {
    final db = await HistoryPageApi.db();
    customPrint("getItemByDateTime dateTime  :: $dateTime");


    customPrint("getItemByDateTime data  :: ${db.query(tableName, where: "date = ?", whereArgs: [dateTime])}");
    final receivedData = await HistoryPageApi.getItems();
    customPrint("getItemByDateTime receivedData :: ${jsonEncode(receivedData)}");
    final List<Map<String, dynamic>> data = await db.query(tableName, where: "date = ?", whereArgs: ['%$dateTime%']);
    customPrint("getItemByDateTime data  :: $data");
    customPrint("getItemByDateTime length  :: ${data.length}");

    // customPrint("getItemByDateTime data  :: ${db.query(tableName, where: "date = ?", whereArgs: [dateTime])}");
    return db.query(tableName, where: "date = ?", whereArgs: [dateTime]);
  }
  // /// read a specific value
  // static Future<String> getItem(DateTime createdAt) async {
  //   final db = await HistoryPageApi.db();
  //   return db.query(tableName, where: "id = ?", whereArgs: [createdAt], limit: 1).toString();
  // }
  // static Future<String> getIcon(String imagePath) async {
  //   final db = await HistoryPageApi.db();
  //   return db.query(tableName, where: "id = ?", whereArgs: [imagePath], limit: 1).toString();
  // }

  /// Read all data
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await HistoryPageApi.db();
    final data = await db.query(tableName, orderBy: "id");
    historyPageModel((historyPageModelFromJson(jsonEncode(data))));
    // customPrint("new data :: $data");
    return data;
  }

  // //get a single icon
  // static Future<List<Map<String, dynamic>>> getIcon(int index) async {
  //   final db = await SQLHelper.db();
  //   return db.query('icons', where: 'index = ?', whereArgs: [index], limit: 1);
  // }

  /// Delete
  static Future<void> deleteItem(int id) async {
    final db = await HistoryPageApi.db();
    try {
      await db.delete(tableName, where: "id = ?", whereArgs: [id]);
      getItems();
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
  /// Delete
  static Future<void> deleteItemByDate(String dateTime) async {
    final db = await HistoryPageApi.db();
    try {
      await db.delete(tableName, where: "date = ?", whereArgs: [dateTime]);
      getItems();
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  /// Delete All
  static Future<void> deleteAllItem() async {
    final db = await HistoryPageApi.db();
    try {
      await db.delete(tableName);
      getItems();
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
