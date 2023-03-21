import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/model/debtor_user.dart';
import 'package:qarzdaftar/model/debtor_user_history.dart';
import 'package:qarzdaftar/provider/debtor_user_historys.dart';

class DebtorUserHistoryScreens extends StatefulWidget {
  const DebtorUserHistoryScreens({Key? key}) : super(key: key);
  static const String routname = "/debtoruserhistory";

  @override
  State<DebtorUserHistoryScreens> createState() =>
      _DebtorUserHistoryScreensState();
}

class _DebtorUserHistoryScreensState extends State<DebtorUserHistoryScreens> {
  late Future _historyFuture;

  @override
  Widget build(BuildContext context) {
    final debetorUser =
        ModalRoute.of(context)!.settings.arguments as DebtorUser;
    // final summ = Provider.of<DebtorUserHistorys>(context,listen: false).sumdebuser();
    // final debhs = Provider.of<DebtorUserHistorys>(context,listen: false).debtorUserHistorysId;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${debetorUser.name}ning xarajatlari",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<DebtorUserHistorys>(
              builder: (cnt, history, child) {
                final summ = history.summDeb();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$summ",
                      style: TextStyle(
                          color: summ > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<DebtorUserHistorys>(context, listen: false)
            .getDebtorUser(debetorUser.id!),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error == null) {
              return Consumer<DebtorUserHistorys>(
                  builder: (cnt, history, child) {
                final debtorUserHistorysId = history.debtorUserHistorysId;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final debtorUserHistory = debtorUserHistorysId[index];
                    return DebtorUserHistoryUi(
                        debtorUserHistory: debtorUserHistory);
                  },
                  itemCount: debtorUserHistorysId.length,
                );
              },
              );
            }
            return const Center(child: Text("Ma'lumot yoq"),);
          }
        },
      ),
    );
  }
}

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
              debtorUserHistory.summ! > 0 ? Colors.green : Colors.red,
        ),
        title: Text("${debtorUserHistory.summ}"),
        subtitle: Text(DateFormat("dd.MM.yyyy, hh:mm")
            .format(debtorUserHistory.dateTime!)),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${debtorUserHistory.summ}"),
            PopupMenuButton(
              position: PopupMenuPosition.under,
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
