import 'package:qarzdaftar/model/debtor_user.dart';
import 'package:qarzdaftar/model/debtor_user_history.dart';

class DbConst {
  static const String debtor_users = ''' CREATE TABLE deb_user(${DebtorUserFildes.columnid} TEXT PRIMARY KEY,${DebtorUserFildes.columnname} TEXT, ${DebtorUserFildes.columnphoneNumber} TEXT,${DebtorUserFildes.columnsumm} INTEGER ,${DebtorUserFildes.columnkoment} TEXT, ${DebtorUserFildes.columnDatetime} INTEGER) ''';
  static const String historyusers = ''' CREATE TABLE history_user(${DebtorHistoryUserFildes.columnid} TEXT PRIMARY KEY,${DebtorHistoryUserFildes.columnname} TEXT, ${DebtorHistoryUserFildes.columnsumm} INTEGER ,${DebtorHistoryUserFildes.columnkoment} TEXT, ${DebtorHistoryUserFildes.columnDatetime} INTEGER, ${DebtorHistoryUserFildes.columndebtorUserId} TEXT )''';
}