import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/debtor_user_historys.dart';
import '../provider/debtor_users.dart';
import '../widget/add_debtor_user_modal.dart';

class AddDebtorUser extends StatelessWidget {
  const AddDebtorUser({Key? key}) : super(key: key);
  static const routName = "/umumiyxarajatlar";

  @override
  Widget build(BuildContext context) {
    var debtorUsers = Provider.of<DebtorUsers>(context);
    var debtoruserHistorys = Provider.of<DebtorUserHistorys>(context);
    void showModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (cnt) {
          return AddDebtorUserModal();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        isDismissible: false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Umumiy xarajatlar"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                height: 80,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Kirim",
                          style: TextStyle(fontSize: 30, color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 100,
                top: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                     const CircleAvatar(
                      backgroundColor: Colors.green,
                      // minRadius: 7.0,
                      radius: 15,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text("${debtoruserHistorys.sumKirim()} so'm",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                height: 80,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Chiqim",
                          style: TextStyle(fontSize: 30, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 100,
                top: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                     const CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      // minRadius: 7.0,
                      radius: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${debtoruserHistorys.sumchiqim()} so'm",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                height: 80,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Ummumiy miqdor",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 100,
                top: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                     const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      // minRadius: 7.0,
                      radius: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${debtoruserHistorys.ummuiy()} so'm",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
