import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/model/debtor_user.dart';
import 'package:qarzdaftar/widget/add_history_user_Modal.dart';

import '../provider/debtor_users.dart';

class DebtorUserInfo extends StatefulWidget {
  const DebtorUserInfo({Key? key, required this.debtorUser, required this.summ})
      : super(key: key);
  final DebtorUser debtorUser;
  final int summ;

  @override
  State<DebtorUserInfo> createState() => _DebtorUserInfoState();
}

class _DebtorUserInfoState extends State<DebtorUserInfo> {
  void showmodalechange(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (cnt) {
        return AddHistoryUserModal(debtorUser: widget.debtorUser);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
    ).then((value) {
      if (value == null) {
        setState(() {
          value = null;
        });
      }
    });
  }

  void _notifyUserAboutDelete(BuildContext context, Function() removeItem) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Ishonchingiz komilmi?'),
          content: const Text(' bu xaridor o\'chmoqda!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'BEKOR QILISH',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                removeItem();
                Navigator.of(context).pop();

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('O\'CHIRISH'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.debtorUser.id),
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          ElevatedButton(
            onPressed: () => _notifyUserAboutDelete(
              context,
              () =>Provider.of<DebtorUsers>(context,listen: false).deletedUsers(widget.debtorUser.id!),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 20,
              ),
            ),
            child: const Text(
              'O\'chirish',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      child: Card(
        // margin: EdgeInsets.all(),
        child: ListTile(
          onTap: () {
            showmodalechange(context);
          },
          leading: CircleAvatar(
            backgroundColor:
                widget.debtorUser.summ! < 0 ? Colors.red : Colors.green,
          ),
          title: Text(widget.debtorUser.name!),
          subtitle: Text("${widget.debtorUser.phoneNumber!}"),
          trailing: Text("${widget.summ}"),
        ),
      ),
    );
  }
}
