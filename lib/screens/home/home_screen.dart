// ignore_for_file: prefer_const_constructors, unnecessary_this, unnecessary_new, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/screens/drawer.dart';
import 'package:flutter_application/widgets/custom_app_bar.dart';
import 'package:flutter_application/widgets/stats_grid.dart';
import 'package:flutter_application/screens/income_expenses/view_expense.dart';
import 'package:flutter_application/screens/income_expenses/view_income.dart';
import 'package:flutter_application/screens/Contact/contact_screen.dart';
import 'package:flutter_application/screens/Employer/Employer_screen.dart';
import 'package:flutter_application/screens/Activity/activity_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home page"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /* new Text("hello"),
            new Text("good morning"),
            new Text("good job"),
            */
            new MyCard(
              destination: ViewIncome(),
              title: new Text(
                "Manage incomes ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.blue),
              ),
              icon: new Icon(Icons.paid, size: 40),
              texte: new Text("your gains and incomes"),
            ),
            new MyCard(
              destination: ViewExpense(),
              title: new Text(
                "manage expenses",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.blue),
              ),
              icon: new Icon(
                Icons.attach_money,
                size: 40,
                color: Colors.red,
              ),
              texte: new Text("your salaries and daily expenses"),
            ),
            new MyCard(
              destination: ActivityScreen(),
              title: new Text(
                "activity",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.blue),
              ),
              icon: new Icon(
                Icons.check_circle,
                size: 40,
                color: Colors.blue,
              ),
              texte: new Text("your daily and working activities"),
            ),
            new MyCard(
              destination: EmployerScreen(),
              title: new Text(
                "Employees",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.blue),
              ),
              icon: new Icon(
                Icons.person,
                size: 40,
                color: Colors.blue,
              ),
              texte: new Text("your employees list and contacts"),
            ),
            new MyCard(
              destination: contactScreen(),
              title: new Text(
                "Contacts",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.blue),
              ),
              icon: new Icon(
                Icons.person_add_alt_1_rounded,
                size: 40,
                color: Colors.blue,
              ),
              texte: new Text("your freinds mates and contacts"),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  MyCard({this.title, this.icon, this.texte, this.destination});
  final Widget icon;
  final Widget title;
  final Widget destination;

  final Widget texte;
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.only(bottom: 20.0),
        child: new Card(
          child: new InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => destination));
            },
            child: new Container(
              padding: EdgeInsets.all(15.0),
              child: new Column(
                children: <Widget>[this.icon, this.title, this.texte],
              ),
            ),
          ),
        ));
  }
}

class MyInfo extends StatelessWidget {
  MyInfo({this.title, this.url, this.texte});
  final Widget url;
  final Widget title;

  final Widget texte;
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(bottom: 20.0),
      child: new Card(
        child: new Container(
          padding: EdgeInsets.all(15.0),
          child: new Column(
            children: <Widget>[
              this.title,
              this.texte,
              this.url,
            ],
          ),
        ),
      ),
    );
  }
}
