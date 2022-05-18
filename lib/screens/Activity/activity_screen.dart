// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application/config/palette.dart';
import 'package:flutter_application/screens/drawer.dart';
import 'package:flutter_application/widgets/custom_app_bar.dart';
import 'package:flutter_application/widgets/custom_card_A.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'add_activity.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  DatabaseReference activity;
  DateTime date;
  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase();
    activity = database
        .reference()
        .child(FirebaseAuth.instance.currentUser.uid)
        .child('activity');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar('Activities'),
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
                      query: activity,
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

                        return CustomCardA(
                          Aname: data["Activity Name"],
                          category: data["Category"],
                          Adate: data["Service_Date"],
                          imagePath:
                              'assets/images/6593733_farm_machine_tractor_vehicle_icon.png',
                          func1: () => {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Renew Activity Date",
                              desc:
                                  "Are you sure you want to renew activity date?",
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
                                    activity
                                        .child(snapshot.key)
                                        .child('Activity_Date')
                                        .set(DateFormat('yyyy-MM-dd')
                                            .format(
                                              date.add(
                                                Duration(days: 120),
                                              ),
                                            )
                                            .toString());
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
                          func2: () => {activity.child(snapshot.key).remove()},
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
                      builder: (context) => Addactivity(),
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
                      'Add Activity',
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
