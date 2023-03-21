
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qarzdaftar/model/debtor_user_history.dart';
import 'package:sqflite/sqflite.dart';
import '../dbconst.dart';
import '../model/debtor_user.dart';

class DatabaseRepository {
  final _databaseName = 'debtorUser1';
  final _databaseVersion = 1;

  static final DatabaseRepository instance = DatabaseRepository();


  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await openDb();
      return _database!;
    }
  }
  Future openDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return
      await openDatabase(path,version: _databaseVersion, onOpen: (db) async {
    }, onCreate: await _createDatabase);
  }


  Future _createDatabase(Database db ,int version)async{
     await db.execute(DbConst.debtor_users);


  }

   Future<DebtorUser> insert(DebtorUser debtorUser) async{
      await database.then((value) => value.insert(debtorUsertable, debtorUser.toMap()));
     return debtorUser;
  }
  Future<List<DebtorUser>> getList() async {
    final db = await database;
    List<Map<String,Object?>> rezalt =  await db.query(debtorUsertable);
     List<DebtorUser> list = rezalt.map((debetorUser) => DebtorUser.fromMap(debetorUser)).toList();
     return list;
  }
  Future<void> updateUsers(DebtorUser debtorUser) async {
    final db = await database;
    db.update('users', debtorUser.toMap(),
        where: "id=?", whereArgs: [debtorUser.id]);
  }

  Future<void> deleteUser(String id) async {
    final db = await database;
    await db.delete('deb_user', where: 'id=?', whereArgs: [id]);
  }



}
