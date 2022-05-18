// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/widgets/custom_app_bar2.dart';
import 'package:flutter_application/widgets/make_input.dart';

// ignore: use_key_in_widget_constructors
class Addactivity extends StatefulWidget {
  @override
  _AddactivityState createState() => _AddactivityState();
}

class _AddactivityState extends State<Addactivity> {
  final referenceDatabase = FirebaseDatabase.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController AnameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController AtermController = TextEditingController();
  final TextEditingController AdateController = TextEditingController()
    ..text = 'Please select a Date.';
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final ref = referenceDatabase.reference();
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar2(Icons.arrow_back_ios, () {
        Navigator.pop(context);
      }, 'Add Activity'),
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
                      child: Center(
                        child: Text(
                          'Enter Details',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MakeInput(
                        label: 'Activity Name',
                        obscureText: false,
                        controllerID: AnameController,
                      ),
                      MakeInput(
                        label: 'Category',
                        obscureText: false,
                        controllerID: categoryController,
                      ),
                      MakeInput(
                        label: 'Activity Terms',
                        obscureText: false,
                        controllerID: AtermController,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Activity Date Date',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: AdateController,
                            enabled: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 10.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Text('Pick a Date'),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2100),
                              ).then((_dateTime) {
                                setState(() {
                                  AdateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(_dateTime);
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                  ref.child(auth.currentUser.uid).child('activity').push().set(
                    {
                      "Activity Name": AnameController.text,
                      "Category": categoryController.text,
                      "Service_Terms": AtermController.text,
                      "Service_Date": AdateController.text,
                    },
                  ).asStream(),
                  AnameController.clear(),
                  categoryController.clear(),
                  AtermController.clear(),
                  AdateController.clear(),
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Text(
                      'Confirm Details',
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
