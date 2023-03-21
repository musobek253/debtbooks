import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/provider/debtor_user_historys.dart';

import '../provider/debtor_users.dart';

class AddDebtorUserModal extends StatefulWidget {
  AddDebtorUserModal({Key? key,}) : super(key: key);


  @override
  State<AddDebtorUserModal> createState() => _AddDebtorUserModalState();
}


class _AddDebtorUserModalState extends State<AddDebtorUserModal> {
    DateTime selectdateTime = DateTime.now();
    late TextEditingController sumTextController;
    late TextEditingController nameTextController;
    late TextEditingController komentController;
    late TextEditingController phoneController;
@override
  void initState() {
  nameTextController = TextEditingController();
  sumTextController = TextEditingController();
  komentController = TextEditingController();
  phoneController = TextEditingController();
    super.initState();
  }
    @override
    void dispose() {
      sumTextController.dispose();
      komentController.dispose();
      phoneController.dispose();
      nameTextController.dispose();
      super.dispose();
    }


  Future<DateTime?> showDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> showTime() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: selectdateTime.hour, minute: selectdateTime.minute));

  Future showDateTime() async {
    DateTime? date = await showDate();
    if (date == null) return;
    TimeOfDay? time = await showTime();
    if (time == null) return;
    final datetime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      selectdateTime = datetime;
    });
  }

  // void addUser(String name, String kament, String phoneNumber, DateTime dateTime,int summ){
  //   setState(() {
  //     var id = widget.debtorUsers.addDebtoruser(name, kament, summ, dateTime, phoneNumber);
  //     widget.debtorUserHistorys.addDebtorUserHistory(id, name, kament, summ, dateTime);
  //   });
  // }
  // void submintPulus(){
  //   addUser(nameTextController.text, komentController.text, phoneController.text, selectdateTime, int.parse("-${sumTextController.text}"));
  // }

  @override
  Widget build(BuildContext context) {
    var debtorUsers = Provider.of<DebtorUsers>(context);
    var debtoruserHistorys = Provider.of<DebtorUserHistorys>(context);

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
              "Yangi User Kiritish",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Ismini Kiriting",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
              ),
              controller: nameTextController,
              keyboardType: TextInputType.text,
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
                              BorderSide(color: Colors.grey, width: 1.5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: sumTextController,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDateTime();
                  },
                  child: selectdateTime != null
                      ? Text(
                          (DateFormat("dd MMMM yyyy ")
                              .format(selectdateTime)),
                          style: TextStyle(fontSize: 15))
                      : const Text("vaqtni tanlang",
                          style: TextStyle(fontSize: 15),
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Telfon Number kiriting",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: phoneController,
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Komentariy kiriting",
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
              ),
              keyboardType: TextInputType.text,
              controller: komentController,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Bekor qilish",
                    style: TextStyle(color: Colors.teal, fontSize: 25),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (nameTextController.text.isEmpty ||
                        sumTextController.text.isEmpty) {
                      return;
                    }
                    var id = debtorUsers.addDebtoruser(
                        nameTextController.text,
                        komentController.text,
                        int.parse("-${sumTextController.text}"),
                        selectdateTime,
                        phoneController.text);
                      debtoruserHistorys.addDebtorUserHistory(
                        id,
                        nameTextController.text,
                        komentController.text,
                          int.parse("-${sumTextController.text}"),
                        selectdateTime);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Berish",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (nameTextController.text.isEmpty ||
                        sumTextController.text.isEmpty) {
                      return;
                    }
                    var id = debtorUsers.addDebtoruser(
                        nameTextController.text,
                        komentController.text,
                        int.parse(sumTextController.text),
                        selectdateTime,
                        phoneController.text);
                    debtoruserHistorys.addDebtorUserHistory(
                        id,
                        nameTextController.text,
                        komentController.text,
                        int.parse(sumTextController.text),
                        selectdateTime);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Olish",
                    style: TextStyle(color: Colors.green, fontSize: 25),
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
