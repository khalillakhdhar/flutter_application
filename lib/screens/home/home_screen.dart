// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/screens/drawer.dart';
import 'package:flutter_application/widgets/custom_app_bar.dart';
import 'package:flutter_application/widgets/stats_grid.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Income {
  double Amount;
  String Date;
  String Details;
  String Title;
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference _expenseRef;
  DatabaseReference _incomeRef;
  DateTime date;
  double i = 0;
  double incomes = 0;
  @override
  void initState() {
    date = DateTime.now();
    String ndate = DateFormat('yyyy-MM-dd').format(date).toString();
    final FirebaseDatabase database = FirebaseDatabase();
    _expenseRef = database
        .ref()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Expense')
        .child(ndate);
    final FirebaseDatabase databaseincome = FirebaseDatabase();
    _incomeRef = databaseincome
        .ref()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Income')
        .child(ndate);
    calculatein();
    super.initState();
  }

  Future<void> calculatein() async {
    date = DateTime.now();
    String ndate = DateFormat('yyyy-MM-dd').format(date).toString();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Income')
        .child(ndate)
        .get();
    if (snapshot.exists) {
      //print(snapshot.value);
      List<Income> incomes = [];

      incomes.clear();
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        incomes.add(values);
      });
      for (var inc in incomes) {
        print(inc.Title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar('Dashboard'),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatsGrid('Income', '(somme)',
                        'assets/images/increase_presentation_Profit_growth-512.png'),
                    StatsGrid('Expense', '(somme)',
                        'assets/images/decrease_presentation_down_loss-512.png'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatsGrid('Contact', '',
                      'assets/images/family_tree_members_people-512.png'),
                  StatsGrid(
                      'Employers', '', 'assets/images/211731_contact_icon.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StatsGrid('Activities', '',
                      'assets/images/6593733_farm_machine_tractor_vehicle_icon.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
