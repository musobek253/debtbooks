import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarzdaftar/provider/debtor_user_historys.dart';
import 'package:qarzdaftar/provider/debtor_users.dart';
import 'package:qarzdaftar/screen/debtor_user_history_screens.dart';
import 'package:qarzdaftar/screen/home_screen.dart';

import 'screen/add_debtor_user_screen.dart';
import 'screen/debtor_user_screens.dart';
import 'screen/expense_history.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DebtorUsers>(create: (context) => DebtorUsers()),
        ChangeNotifierProvider<DebtorUserHistorys>(create: (context) => DebtorUserHistorys()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'AnandaBlackPersonalUseRegular',
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          DebtorUserHistoryScreens.routname: (cnt)=>const DebtorUserHistoryScreens(),
        },
        home: Mainpages(),
      ),
    );
  }
}

class Mainpages extends StatefulWidget {
  const Mainpages({Key? key}) : super(key: key);

  @override
  State<Mainpages> createState() => _MainpagesState();
}

class _MainpagesState extends State<Mainpages> {
  int _selectedIndex = 0;
  final screens = [
    HomeScreen(),
     DebtorUserScreens(),
     ExpenseHistory(),
     AddDebtorUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,

        // fixedColor: Colors.red,
        items:  const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: "Kontaklar",
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "xarajatlar"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "qo'shish"),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.blue[800],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
