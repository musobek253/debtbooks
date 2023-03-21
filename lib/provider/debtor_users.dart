import 'package:flutter/material.dart';
import 'package:qarzdaftar/db/db.dart';
import 'package:qarzdaftar/db/debtor_user_database.dart';

import '../model/debtor_user.dart';

class DebtorUsers with ChangeNotifier {

  List<DebtorUser> _debtorUsers = [];

  List<DebtorUser> get debtorUsers {
    return [..._debtorUsers];
  }

  String addDebtoruser(String name, String koment, int summ, DateTime dateTime,String phoneNumber) {
    DebtorUser debtorUser = DebtorUser(id: UniqueKey().toString(),
        name: name,
        koment: koment,
        summ: summ,
        dateTime: dateTime,
        phoneNumber: phoneNumber);
    // _debtorUsers.add(debtorUser);
    DatabaseRepository.instance.insert(debtorUser);
    notifyListeners();

    return debtorUser.id!;

  }

  Future<List<DebtorUser>> getdebtoruserdatabase() async {
    List<DebtorUser> list = await DatabaseRepository.instance.getList();
     _debtorUsers = list;
    notifyListeners();
    return _debtorUsers;
  }

  Future<void> deletedUsers(String id) async {
    await DatabaseRepository.instance.deleteUser(id);
    await DebtorUserDatabase.instance.deleteUser(id);
    notifyListeners();
  }

}
