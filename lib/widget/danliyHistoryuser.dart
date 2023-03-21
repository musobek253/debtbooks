import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/debtor_user_history.dart';

class DenliyHistoryUserUi extends StatelessWidget {
  const DenliyHistoryUserUi({Key? key, required this.debHistoryList}) : super(key: key);
  final List<DebtorUserHistory> debHistoryList ;
  @override
  Widget build(BuildContext context) {
    // print(debHistoryList);
    return LayoutBuilder(
      builder: (BuildContext, constraints) {
        return Container(
          child: ListView.builder(itemBuilder: (context ,index){
          final debuserhistory = debHistoryList[index];
            return Card(
              child: ListTile(
                leading:  CircleAvatar(
                  backgroundColor: debuserhistory.summ!<0? Colors.red:Colors.green,
                  radius: 15,
                ),

                title: Text(debuserhistory.name!),
                subtitle: Text(DateFormat("dd/MM/yyyy hh:mm").format(debuserhistory.dateTime!)),
                trailing: Text("${debuserhistory.summ}"),
              ),
            );
          },
          itemCount: debHistoryList.length,
          ),
        );
      },
    );
  }
}
