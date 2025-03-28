import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // _database = await _initDatabase();
    return _database!;
  }

  // Future<Database> _initDatabase() async {
  //   String path = join(await getDatabasesPath(), 'menu_database.db');
  //   return await openDatabase(
  //     path,
  //     version: 2,  // ✅ DB 버전을 증가시켜야 기존 DB를 삭제하고 다시 생성함
  //     onCreate: (db, version) async {
  //       await db.execute(
  //         'CREATE TABLE menu (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT UNIQUE, category TEXT)',
  //       );
  //
  //       await db.execute(
  //         'CREATE TABLE selected_menu (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, selected_at TEXT)',
  //       );
  //
  //       await _insertInitialMenus(db);
  //     },
  //     onUpgrade: (db, oldVersion, newVersion) async {
  //       if (oldVersion < 2) {
  //         await db.execute(
  //           'CREATE TABLE IF NOT EXISTS selected_menu (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, selected_at TEXT)',
  //         );
  //       }
  //     },
  //   );
  // }


  // ✅ 최초 1회 실행되는 데이터 삽입 로직
  // Future<void> _insertInitialMenus(Database db) async {
  //   List<Map<String, dynamic>> existingMenus = await db.query('menu');
  //   if (existingMenus.isNotEmpty) return; // 이미 데이터가 있으면 추가 X
  //
  //   Batch batch = db.batch();
  //   for (var menu in menus) {
  //     batch.insert('menu', menu, conflictAlgorithm: ConflictAlgorithm.ignore);
  //   }
  //   await batch.commit();
  // }
}
