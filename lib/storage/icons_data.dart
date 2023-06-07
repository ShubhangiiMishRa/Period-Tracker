import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE icons(
    index INTEGER,
    url TEXT
    )
    """);
  }
  static Future<sql.Database> db() async{
    return sql.openDatabase(
        'healthApp.db',
        version: 1,
        onCreate: (sql.Database database, int version) async {
          await createTables(database);
        }
    );
  }
  // add icon to the db
  static Future<int> createIcons(String url, int index) async{
    final db = await SQLHelper.db();
    final data = {'index': index, 'url' : url};
    final id = await db.insert('icons', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //get multiple icons
  static Future<List<Map<String, dynamic>>> getIcons() async{
    final db = await SQLHelper.db();
    return db.query('icons', orderBy: 'index');
  }

  //get a single icon
  static Future<List<Map<String, dynamic>>> getIcon(int index) async{
    final db = await SQLHelper.db();
    return db.query('icons', where: 'index = ?', whereArgs: [index], limit:1);
  }
}