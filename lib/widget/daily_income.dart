import 'package:flutter/material.dart';

class DailyIncome extends StatelessWidget {
  const DailyIncome(
      {Key? key,
      required this.selectdate,
      required this.nextday,
      required this.preday, required this.summa, required this.chiqimsumma})
      : super(key: key);
  final DateTime selectdate;
  final Function() nextday;
  final Function() preday;
  final int summa;
  final int chiqimsumma;

  @override
  Widget build(BuildContext context) {
    final isFirstdate = (selectdate.year == 2023 &&
        selectdate.month == 1 &&
        selectdate.day == 01);
    final islastdate = (selectdate.year == DateTime.now().year &&
        selectdate.month == DateTime.now().month &&
        selectdate.day == DateTime.now().day);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: isFirstdate ? Colors.grey : Colors.redAccent),
              borderRadius: BorderRadius.circular(30)),
          child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: preday,
              icon: Icon(Icons.arrow_left,
                  size: 40, color: isFirstdate ? Colors.grey : Colors.purple)),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          height: 80,
          width: 290,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.green,
                    minRadius: 7.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children:   [
                      const Text(
                        "Kirim",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "$summa",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.red,
                    minRadius: 7.0,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Chiqim",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 3,),
                      Text(
                        "$chiqimsumma",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: islastdate ? Colors.grey : Colors.redAccent),
              borderRadius: BorderRadius.circular(30)),
          child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: nextday,
              icon: Icon(Icons.arrow_right,
                  size: 40, color: islastdate ? Colors.grey : Colors.purple)),
        ),
      ],
    );
  }
}
