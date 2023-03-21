import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/model/debtor_user_history.dart';

import '../provider/debtor_user_historys.dart';

class ExpenseHistory extends StatefulWidget {
  const ExpenseHistory({Key? key}) : super(key: key);

  @override
  State<ExpenseHistory> createState() => _ExpenseHistoryState();
}

class _ExpenseHistoryState extends State<ExpenseHistory> {
  late Future _historyFuture;

  Future gethistory() {
    return Provider.of<DebtorUserHistorys>(context, listen: false).getdebtorHistoryuserdatabase();
  }

  @override
  void initState() {
    _historyFuture = gethistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final debtorHistors =
    //     Provider.of<DebtorUserHistorys>(context, listen: false)
    //         .debtorUserHistorys;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Xarajatlar tarixi"),
      ),
      body: FutureBuilder(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error == null) {
              return Consumer<DebtorUserHistorys>(
                builder: (cnt, history, child) {
                  final historys = history.debtorUserHistorys;
                  return ListView.builder(
                    itemBuilder: (cnt, index) {
                      final debtorHistor = historys[index];

                      return ExpenseHistoryUi(
                        debtorUserHistory: debtorHistor,
                      );
                    },
                    itemCount: historys.length,
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Ma'lumot yoq"),
              );
            }
          }
        },
      ),
    );
  }
}

class ExpenseHistoryUi extends StatelessWidget {
  const ExpenseHistoryUi({Key? key, required this.debtorUserHistory})
      : super(key: key);
  final DebtorUserHistory debtorUserHistory;
  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        title: Text(
          debtorUserHistory.name!,
          style: const TextStyle(fontSize: 30),
        ),
        subtitle: Text(
            "${DateFormat("dd MMMM yyyy").format(debtorUserHistory.dateTime!)}, ${debtorUserHistory.koment}"),
        trailing: Text("${debtorUserHistory.summ}" ,style: TextStyle(color: debtorUserHistory.summ! > 0 ? Colors.green : Colors.red),),
      ),
    );
  }
}
