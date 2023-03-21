import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/provider/debtor_user_historys.dart';
import 'package:qarzdaftar/provider/debtor_users.dart';

import '../widget/debtor_user_info.dart';

class DebtorUserScreens extends StatefulWidget {
  const DebtorUserScreens({Key? key}) : super(key: key);
  static const String routName = "/xaridorlar";

  @override
  State<DebtorUserScreens> createState() => _DebtorUserScreensState();
}

class _DebtorUserScreensState extends State<DebtorUserScreens> {
  late Future _debUserFuture;
  Future getdebUser() {
    return Provider.of<DebtorUsers>(context, listen: false)
        .getdebtoruserdatabase();
  }

  @override
  void initState() {
    _debUserFuture = getdebUser();
    super.initState();
  }

  Future<void> refresh() async {
    await Provider.of<DebtorUserHistorys>(context, listen: false)
        .getdebtorHistoryuserdatabase();
  }

  @override
  Widget build(BuildContext context) {
    // final debtorUsers = Provider.of<DebtorUsers>(context).debtorUsers;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Xaridorlar Ro'yxati"),
      ),
      body: FutureBuilder(
        future: _debUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error == null) {
              return Consumer<DebtorUsers>(
                builder: (cnt, debtorUsers, child) {
                  final debtorUsers2 = debtorUsers.debtorUsers;
                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                      itemBuilder: (cnt, index) {
                        final debtoruser = debtorUsers2[index];
                        final summDebtorUser =
                            Provider.of<DebtorUserHistorys>(context)
                                .summdebuserH(debtoruser.id!);
                        print(debtoruser.dateTime);

                        return DebtorUserInfo(
                          debtorUser: debtoruser,
                          summ: summDebtorUser,
                        );
                      },
                      itemCount: debtorUsers2.length,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Malumot mavjud emas"),
              );
            }
          }
        },
      ),
    );
  }
}
