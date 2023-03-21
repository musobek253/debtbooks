import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/debtor_user_history.dart';

class DebtorUserHistoryUi extends StatelessWidget {
  const DebtorUserHistoryUi({Key? key, required this.debtorUserHistory})
      : super(key: key);
  final DebtorUserHistory debtorUserHistory;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          debtorUserHistory.summ !> 0 ? Colors.green : Colors.red,
        ),
        title: Text("${debtorUserHistory.summ}"),
        subtitle: Text(
            DateFormat("dd.MM.yyyy, hh:mm").format(debtorUserHistory.dateTime!)),
        trailing: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${debtorUserHistory.summ}"),
            PopupMenuButton(
              position:  PopupMenuPosition.under,
              itemBuilder: (BuildContext contex) => [
                const PopupMenuItem(
                  value: 'search',
                  child: Text('Search'),
                ),
                const PopupMenuItem(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem(
                  value: 'help',
                  child: Text('Help'),
                ),
              ],
              onSelected: (selectedValue) {
                switch (selectedValue) {
                  case 'search':
                  // Perform action for search
                    break;
                  case 'settings':
                  // Perform action for settings
                    break;
                  case 'help':
                  // Perform action for help
                    break;
                }
              },
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
    );
  }
}
