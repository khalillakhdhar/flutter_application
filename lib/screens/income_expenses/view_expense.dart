// ignore_for_file: unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/screens/drawer.dart';
import 'package:flutter_application/widgets/custom_app_bar2.dart';
import 'package:flutter_application/widgets/custom_card_money.dart';

class ViewExpense extends StatefulWidget {
  @override
  _ViewExpenseState createState() => _ViewExpenseState();
}

class _ViewExpenseState extends State<ViewExpense> {
  DatabaseReference _expenseRef;
  DateTime date;
  double i = 0;
  @override
  void initState() {
    date = DateTime.now();
    String ndate = DateFormat('yyyy-MM-dd').format(date).toString();
    final FirebaseDatabase database = FirebaseDatabase();
    _expenseRef = database
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Expense')
        .child(ndate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar2(Icons.arrow_back_ios, () {
        Navigator.pop(context);
      }, 'View Expenses'),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextField(
                        onChanged: (value) => {},
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          contentPadding: const EdgeInsets.only(top: 15.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: new FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: _expenseRef,
                      itemBuilder: (
                        BuildContext context,
                        DataSnapshot snapshot,
                        Animation<double> animation,
                        int index,
                      ) {
                        var json = snapshot.value;
                        Map<dynamic, dynamic> result = json;
                        Map<String, dynamic> data = Map<String, dynamic>();

                        for (dynamic type in result.keys) {
                          data[type.toString()] = result[type];
                          if (data["Amount"] != null) {
                            i = i + int.parse(data["Amount"]) / 3;
                            print(i);
                          }
                        }
                        return CustomCardMoney(
                          title: data["Title"],
                          amount: data["Amount"],
                          date: data["Date"],
                          detail: data["Details"],
                          imagePath:
                              'assets/images/cash_flow_tranfer_finance-512.png',
                          sum: i,
                          func2: () =>
                              {_expenseRef.child(snapshot.key).remove()},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
