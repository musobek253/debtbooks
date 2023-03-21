
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qarzdaftar/model/debtor_user.dart';
import 'package:sqflite/sqflite.dart';

import '../dbconst.dart';
import '../model/debtor_user_history.dart';
import 'db.dart';

class DebtorUserDatabase {

  final _databaseName = 'debtorUser2';
  final _databaseVersion = 1;

  static final DebtorUserDatabase instance = DebtorUserDatabase();


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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return
      await openDatabase(path,version: _databaseVersion, onOpen: (db) async {
      }, onCreate: _createDatabase);
  }


  Future _createDatabase(Database db ,int version)async{

    await db.execute(DbConst.historyusers);

  }

  Future<DebtorUserHistory> inserthistory(DebtorUserHistory debtorUserHistory) async{
    final db = await database;
    await db.insert(historyUser, debtorUserHistory.toMap());
    return debtorUserHistory;
  }
  Future<List<DebtorUserHistory>> getHistoryList() async {
    final db = await database;
    List<Map<String, Object?>> rezalt = await db.query('history_user');
    List<DebtorUserHistory> list = rezalt.map((debetorUser) =>
        DebtorUserHistory.fromMap(debetorUser)).toList();
    return list;
  }
  Future<List<DebtorUserHistory>> getAllContactsByCategory(String debtorId) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db.query('history_user' , where: "userId=?", whereArgs: [debtorId]);
    List<DebtorUserHistory> debtorHistorys =
    allRows.map((debtorHistory) => DebtorUserHistory.fromMap(debtorHistory)).toList();
    return debtorHistorys;
  }
  
  Future<int> sumDebtorUser(String debtorId) async{
    final db = await database;
    int summ = (await db.rawQuery("SELECT SUM(summ) * FROM history_user WHERE history_user.userId = $debtorId ")) as int;
    return summ;
  }




  Future<void> deleteUser(String id) async {
    final db = await database;
    await db.delete('history_user', where: 'userid=?', whereArgs: [id]);
  }




}