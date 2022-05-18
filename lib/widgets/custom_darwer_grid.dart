// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/config/palette.dart';

class CustomDG extends StatefulWidget {
  final String name;
  final String Farmname;
  final String description;
  CustomDG({this.name, this.Farmname, this.description});
  @override
  _CustomDGState createState() => _CustomDGState();
}

class _CustomDGState extends State<CustomDG> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Owner:',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(height: 5.0),
        Text(
          widget.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        SizedBox(height: 10.0),
        Text(
          'Farm Name:',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(height: 5.0),
        Text(
          widget.Farmname,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        SizedBox(height: 10.0),
        Text(
          'Description:',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(height: 5.0),
        Text(
          widget.description,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ],
    );
  }
}
