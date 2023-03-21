import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/model/debtor_user.dart';
import 'package:qarzdaftar/provider/debtor_user_historys.dart';
import 'package:qarzdaftar/screen/debtor_user_history_screens.dart';

class AddHistoryUserModal extends StatefulWidget {
  const AddHistoryUserModal({Key? key, required this.debtorUser})
      : super(key: key);
  final DebtorUser debtorUser;
  @override
  State<AddHistoryUserModal> createState() => _AddHistoryUserModalState();
}

late TextEditingController sumTextController;
late TextEditingController komentController;
DateTime? selectedDateTime ;

int rt = 0;

class _AddHistoryUserModalState extends State<AddHistoryUserModal> {
  Future<DateTime?> showDate() =>
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100));


  Future<TimeOfDay?> showTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: selectedDateTime!.hour, minute: selectedDateTime!.minute));

  Future showDateTime() async {
    DateTime? date = await showDate();
    if (date == null) return;
    TimeOfDay? time = await showTime();
    if (time == null) return;
    final datetime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      selectedDateTime = datetime;
    });
  }
@override
  void initState() {
    sumTextController = TextEditingController();
    komentController = TextEditingController();
    selectedDateTime  = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var historyUsers = Provider.of<DebtorUserHistorys>(context);
    var summ = historyUsers.summdebuserH(widget.debtorUser.id!);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom + 16
                : 102),
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              "Userni O'zgartirish",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  widget.debtorUser.name!,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "$summ",
                  style: TextStyle(
                      color: summ > 0 ? Colors.green : Colors.red,
                      fontSize: 18),
                )
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.calculate_rounded,
                    size: 40,
                  ),
                  color: Colors.purpleAccent,
                  style: const ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 5),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                        label: const Text("summani kiriting"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: sumTextController,
                      onChanged: (value) {
                        setState(() {
                          rt = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ),
                TextButton(
                  onPressed: ()=> showDateTime(),
                  child: selectedDateTime!=null?
                      Text(DateFormat("dd/MM/yyyy").format(selectedDateTime!)):Text("Kuni tanlang"),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Komentariy kiriting",
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                ),
              ),
              keyboardType: TextInputType.text,
              controller: komentController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    if (sumTextController == null || komentController == null) {
                      return;
                    }
                    historyUsers.addDebtorUserHistory(
                        widget.debtorUser.id!,
                        widget.debtorUser.name!,
                        komentController.text,
                        int.parse("-${sumTextController.text}"),
                        selectedDateTime!);
                    Navigator.of(context).pop();
                    sumTextController.clear();
                    komentController.clear();
                  },
                  child: const Text(
                    "Berish",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (sumTextController == null || komentController == null) {
                      return;
                    }
                    historyUsers.addDebtorUserHistory(
                        widget.debtorUser.id!,
                        widget.debtorUser.name!,
                        komentController.text,
                        int.parse(sumTextController.text),
                        selectedDateTime!);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Olish",
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                summ + rt > 0
                    ? Text(
                        "+${summ + rt} ",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      )
                    : Text("${summ + rt}",
                        style:
                            const TextStyle(color: Colors.red, fontSize: 15)),
                const Icon(Icons.arrow_back),
                const Text("yoki"),
                const Icon(Icons.arrow_forward_outlined),
                summ - rt > 0
                    ? Text(
                        "+${summ - rt}",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 15),
                      )
                    : Text("${summ - rt}",
                        style:
                            const TextStyle(color: Colors.red, fontSize: 15)),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        DebtorUserHistoryScreens.routname,
                        arguments: widget.debtorUser);
                  },
                  child: const Text(
                    "Xarajatlar tarixi",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
