import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreenDayUi extends StatelessWidget {
  final Function showDateTime;
  final DateTime selectdateTime;
  const HomeScreenDayUi({
    Key? key,
    required this.selectdateTime,
    required this.showDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              showDateTime();
            },
            child: Text(
              DateFormat("MMMM, dd y EEEE,").format(selectdateTime),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
