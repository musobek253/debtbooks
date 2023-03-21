import 'package:flutter/material.dart';
import 'package:qarzdaftar/model/debtor_user_history.dart';

import '../db/db.dart';
import '../db/debtor_user_database.dart';

class DebtorUserHistorys with ChangeNotifier {
  List<DebtorUserHistory> _debtoruserHistorys = [];
  List<DebtorUserHistory> _debtoruserHistorysId = [];

  List<DebtorUserHistory> get debtorUserHistorys => [..._debtoruserHistorys];
  List<DebtorUserHistory> get debtorUserHistorysId => [..._debtoruserHistorysId];

  void addDebtorUserHistory(String debtorUserId, String name, String koment,
      int summ, DateTime dateTime) {
    DebtorUserHistory newDebtorUser = DebtorUserHistory(
        id: UniqueKey().toString(),
        koment: koment,
        dateTime: dateTime,
        name: name,
        summ: summ,
        debtorUserId: debtorUserId);
    DebtorUserDatabase.instance.inserthistory(newDebtorUser);
    notifyListeners();
  }

  List<DebtorUserHistory> selectrday(DateTime dateTime) {
    return _debtoruserHistorys
        .where((element) => element.dateTime!.day == dateTime.day)
        .toList();
  }

  int Summkirim(DateTime dateTime) {
    int summ = 0;
    _debtoruserHistorys.forEach((element) {
      if (element.dateTime!.day == dateTime.day) {
        if (element.summ! > 0) {
          summ += element.summ!;
        }
      }
    });
    return summ;

  }

  int sumChiqim(DateTime dateTime) {
    int summ = 0;
    _debtoruserHistorys.forEach((element) {
      if (element.dateTime!.day == dateTime.day) {
        if (element.summ! < 0) {
          summ += element.summ!;
        }
      }
    });
    return summ;
  }

  List<DebtorUserHistory> getDebtorUsers(String debtorUserId) {
    return _debtoruserHistorys
        .where((element) => element.debtorUserId == debtorUserId)
        .toList();
  }

  int summDeb() {
    return _debtoruserHistorysId.fold(0, (previousValue, element) => element.summ! +previousValue);
  }

  int summdebuserH(String id){
    return getDebtorUsers(id).fold(0, (previousValue, element) => element.summ! +previousValue);
  }

  // Future<int> summDebs(String id){
  //   return DebtorUserDatabase.instance.sumDebtorUser(id);
  // }


  int sumdebuser(){
    return _debtoruserHistorysId.fold(0, (previousValue, element) => element.summ! > 0 ? previousValue + element.summ! : previousValue);
  }

  int sumKirim() {
    return _debtoruserHistorys.fold(
        0,
        (previousValue, element) =>
            element.summ! > 0 ? previousValue + element.summ! : previousValue);
  }

  int sumchiqim() {
    return _debtoruserHistorys.fold(
        0,
        (previousValue, element) =>
            element.summ! < 0 ? previousValue + element.summ! : previousValue);
  }

  int ummuiy() {
    return sumKirim() + sumchiqim();
  }

  Future<void> getdebtorHistoryuserdatabase() async {
    List<DebtorUserHistory> list =
        await DebtorUserDatabase.instance.getHistoryList();
    _debtoruserHistorys = list;
    notifyListeners();
  }

  Future<void> getDebtorUser(String id) async {
    List<DebtorUserHistory> list =
        await DebtorUserDatabase.instance.getAllContactsByCategory(id);
    _debtoruserHistorysId = list;
    notifyListeners();


  }
}
