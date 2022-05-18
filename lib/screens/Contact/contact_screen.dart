// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/screens/drawer.dart';
import 'package:flutter_application/widgets/custom_app_bar.dart';
import 'package:flutter_application/widgets/custom_card_C.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'add_contact.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class contactScreen extends StatefulWidget {
  @override
  _contactScreenState createState() => _contactScreenState();
}

class _contactScreenState extends State<contactScreen> {
  DatabaseReference _ContactRef;
  DatabaseReference _incomeRef;
  DateTime date;
  DateTime today;
  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase();
    _ContactRef = database
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Contact');
    _incomeRef = database
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('Income');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar('Contact'),
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
                      query: _ContactRef,
                      itemBuilder: (
                        BuildContext context,
                        DataSnapshot snapshot,
                        Animation<double> animation,
                        int index,
                      ) {
                        var json = snapshot.value;
                        Map<dynamic, dynamic> result = json;
                        Map<String, dynamic> data = Map<String, dynamic>();
                        var i = "";
                        for (dynamic type in result.keys) {
                          data[type.toString()] = result[type];
                          i = data["Name"];
                          print(i);
                        }
                        return CustomCardM(
                          name: data["Name"],
                          phoneNumber: data["Phone_Number"],
                          regdate: data["Reg_Date"],
                          imagePath:
                              'assets/images/baby_child_children_boy-512.png',
                          func1: () => {
                            UrlLauncher.launch('tel:${data["Phone_Number"]}')
                          },
                          func2: () => {
                            UrlLauncher.launch('sms:${data["Phone_Number"]}')
                          },
                          func4: () =>
                              {_ContactRef.child(snapshot.key).remove()},
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
                      builder: (context) => Addcontact(),
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
                      'Add Contact',
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
