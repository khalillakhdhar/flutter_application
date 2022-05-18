// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/screens/drawer.dart';
import 'package:flutter_application/widgets/custom_app_bar.dart';
import 'package:flutter_application/widgets/custom_card_E.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'add_Employer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class EmployerScreen extends StatefulWidget {
  @override
  _EmployerScreenState createState() => _EmployerScreenState();
}

class _EmployerScreenState extends State<EmployerScreen> {
  DatabaseReference _EmployerRef;
  DatabaseReference _expenseRef;
  DateTime date;
  DateTime today;
  String salary;
  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase();
    print(FirebaseAuth.instance.currentUser.uid);
    _EmployerRef = database
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Employer');
    _expenseRef = database
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Expense');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar('Employer'),
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
                    // ignore: unnecessary_new
                    child: new FirebaseAnimatedList(
                      shrinkWrap: true,
                      query: _EmployerRef,
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
                        }
                        return CustomCardE(
                          name: data["Name"],
                          phoneNumber: data["Phone_Number"],
                          paydate: data["Pay_Date"],
                          salary: data["Salary"],
                          imagePath:
                              'assets/images/baby_child_children_boy-512.png',
                          func1: () => {
                            UrlLauncher.launch('tel:${data["Phone_Number"]}')
                          },
                          func2: () => {
                            UrlLauncher.launch('sms:${data["Phone_Number"]}')
                          },
                          func3: () => {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Renew Salary",
                              desc:
                                  "Are you sure you want to update Employer's salary?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Renew",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    date = DateTime.parse(
                                        snapshot.value.toString());
                                    today = DateTime.now();
                                    salary = snapshot.value.toString();
                                    _EmployerRef.child(snapshot.key)
                                        .child('Pay_Date')
                                        .set(DateFormat('yyyy-MM-dd')
                                            .format(
                                              date.add(
                                                Duration(days: 30),
                                              ),
                                            )
                                            .toString());
                                    _expenseRef
                                        .child(
                                          DateFormat('yyyy-MM-dd')
                                              .format(today),
                                        )
                                        .push()
                                        .set(
                                      {
                                        'Title':
                                            '${snapshot.value.toString()}\'s Employer Fee',
                                        'Amount': salary,
                                        'Date': DateFormat('yyyy-MM-dd').format(
                                          date.add(
                                            Duration(days: 30),
                                          ),
                                        ),
                                        'Details':
                                            'Name: ${snapshot.value.toString()}\nID: ${snapshot.key}\nEmployer\'s Monthly Fee',
                                      },
                                    );
                                    Navigator.pop(context);
                                  },
                                  color: Color.fromRGBO(0, 179, 134, 1.0),
                                ),
                                DialogButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.red,
                                )
                              ],
                            ).show(),
                          },
                          func4: () =>
                              {_EmployerRef.child(snapshot.key).remove()},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: FlatButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTrainers(),
                    ),
                  ),
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Text(
                      'Add Employer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
