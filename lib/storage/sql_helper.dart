// import 'package:sqflite/sqflite.dart' as sql;
//
// class SQLHelper{
//   static Future<void> createTables(sql.Database database) async{
//     await database.execute("""CREATE TABLE user(
//     name TEXT NOT NULL,
//     email TEXT,
//     phoneNumber INTEGER,
//     age INTEGER,
//     active TEXT,
//     firstDay TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
//     lastDay TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
//     flowDays INTEGER
//     )
//     """);
//   }
//   static Future<sql.Database> db() async{
//         return sql.openDatabase(
//           'healthApp.db',
//           version: 1,
//           onCreate: (sql.Database database, int version) async {
//             await createTables(database);
//           }
//         );
//   }
//   static Future<int> createUser(String name) async{
//     final db = await SQLHelper.db();
//     final data = {'name': name};
//     final id = await db.insert('user', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }
//   static Future<List<Map<String, dynamic>>> getUsers() async{
//     final db = await SQLHelper.db();
//     return db.query('users', orderBy: 'name');
//   }
// }