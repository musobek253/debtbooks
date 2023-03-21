import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/provider/debtor_user_historys.dart';
import 'package:qarzdaftar/widget/daily_income.dart';
import '../widget/Homescreendatui.dart';
import '../widget/danliyHistoryuser.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectdateTime = DateTime.now();
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    Text('Index 0: Home'),
    Text('Index 1: Profile'),
    Text('Index 2: Settings'),
    Text('Index 3: About'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(selectdateTime);
    final appbar = AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      title: const Text("Qarz Daftar"),
    );
    var preferredSize = appbar.preferredSize.height;
    var top = MediaQuery.of(context).padding.top;
    final heightM = MediaQuery.of(context).size.height - preferredSize - top;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          height: heightM,
          decoration: BoxDecoration(color: Color.fromRGBO(233, 236, 242, 1)),
          child: Column(
            children: [
              Container(
                height: heightM * 0.065,
                child: HomeScreenDayUi(
                    showDateTime: showDateTime, selectdateTime: selectdateTime),
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: heightM * 0.1507,
                child: Consumer<DebtorUserHistorys>(
                    builder: (cnt, history, child) {
                  final debUserHistoryDen = history.selectrday(selectdateTime);
                  final debUsersumKirim = history.Summkirim(selectdateTime);
                  final debUsersumchiqim = history.sumChiqim(selectdateTime);
                  return DailyIncome(
                    selectdate: selectdateTime,
                    nextday: nextday,
                    preday: preday,
                    summa: debUsersumKirim,
                    chiqimsumma: debUsersumchiqim,
                  );
                }),
              ),
              Expanded(
                child: Container(
                  height: heightM * 0.784,
                  child: FutureBuilder(
                    future: Provider.of<DebtorUserHistorys>(context, listen: false)
                        .getdebtorHistoryuserdatabase(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.error == null) {
                          return Consumer<DebtorUserHistorys>(
                              builder: (cnt, histor, child) {
                            return DenliyHistoryUserUi(
                              debHistoryList: histor.selectrday(selectdateTime),
                            );
                          });
                        }
                        return const Center(
                          child: Text("bugunga xarajatlar yoq"),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void nextday() {
    if (selectdateTime.year == DateTime.now().year &&
        selectdateTime.month == DateTime.now().month &&
        selectdateTime.day == DateTime.now().day) {
      return;
    }
    setState(() {
      selectdateTime = DateTime(
          selectdateTime.year, selectdateTime.month, selectdateTime.day + 1);
    });
  }

  void preday() {
    if (selectdateTime.year == 2023 &&
        selectdateTime.month == 1 &&
        selectdateTime.day == 01) {
      return;
    }
    setState(() {
      selectdateTime = DateTime(
          selectdateTime.year, selectdateTime.month, selectdateTime.day - 1);
    });
  }

  Future<DateTime?> showDate() => showDatePicker(
      context: context,
      initialDate: selectdateTime,
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
}
