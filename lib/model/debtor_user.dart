import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

 const String debtorUsertable = 'deb_user';
class DebtorUserFildes {

  static const String columnid = 'id';
  static const String columnname = 'name';
  static const String columnkoment = 'koment';
  static const columnphoneNumber = 'phoneNumber';
  static const String columnsumm = 'summ';
  static const String columnDatetime = "datetime";
}
class DebtorUser{

  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? koment;
  final int? summ;
  final DateTime? dateTime;

  DebtorUser(  {required this.id ,required this.name, required this.koment, required this.summ, required this.dateTime, required this.phoneNumber});

  Map<String,dynamic> toMap()=>{
    DebtorUserFildes.columnid: id,
    DebtorUserFildes.columnname:name,
    DebtorUserFildes.columnkoment:koment,
    DebtorUserFildes.columnphoneNumber:phoneNumber,
    DebtorUserFildes.columnsumm: summ,
    DebtorUserFildes.columnDatetime :dateTime!.millisecondsSinceEpoch,
  };
  factory DebtorUser.fromMap(Map<String,dynamic> map)=> DebtorUser(
        id: map['id'],
        name: map['name'],
        koment: map['koment'],
        summ: map['summ'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(map['datetime'] as int),
        phoneNumber: map['phoneNumber']);

}

