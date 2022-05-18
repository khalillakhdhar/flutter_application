// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/widgets/custom_app_bar2.dart';
import 'package:flutter_application/widgets/make_input.dart';

class Addcontact extends StatefulWidget {
  @override
  _AddcontactState createState() => _AddcontactState();
}

class _AddcontactState extends State<Addcontact> {
  final referenceDatabase = FirebaseDatabase.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController regdateController = TextEditingController()
    ..text = 'Please select a Registration Date.';
  final TextEditingController wtController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar2(Icons.arrow_back_ios, () {
        Navigator.pop(context);
      }, 'Add Contact'),
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
                        label: 'Name',
                        obscureText: false,
                        controllerID: nameController,
                      ),
                      MakeInput(
                        label: 'Address',
                        obscureText: false,
                        controllerID: addressController,
                      ),
                      MakeInput(
                        label: 'Phone Number',
                        obscureText: false,
                        controllerID: phoneController,
                      ),
                      MakeInput(
                        label: 'Work type',
                        obscureText: false,
                        controllerID: wtController,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registration Date',
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
                            controller: regdateController,
                            enabled: false,
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
                                  regdateController.text =
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
                  ref
                      .child(auth.currentUser.uid)
                      .child('Contact')
                      .child(phoneController.text)
                      .set(
                    {
                      'Name': nameController.text,
                      'Address': addressController.text,
                      'Phone_Number': phoneController.text,
                      'Reg_Date': regdateController.text,
                      'Work_Type': wtController.text,
                    },
                  ).asStream(),
                  nameController.clear(),
                  addressController.clear(),
                  phoneController.clear(),
                  regdateController.clear(),
                  wtController.clear(),
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
