import 'package:flutter/material.dart';

class CustomCardM extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String regdate;
  final String imagePath;
  final Function func1;
  final Function func2;
  final Function func3;
  final Function func4;
  CustomCardM(
      {this.name,
      this.phoneNumber,
      this.regdate,
      this.imagePath,
      this.func1,
      this.func2,
      this.func3,
      this.func4});
  @override
  _CustomCardMState createState() => _CustomCardMState();
}

class _CustomCardMState extends State<CustomCardM> {
  DateTime date;
  Color timeColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      color: Colors.grey[350],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Image.asset(
                  widget.imagePath,
                  width: 64.0,
                ),
              ),
              Column(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text(
                    widget.phoneNumber,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                ],
              ),
              Flexible(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  tooltip: 'More Details',
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          Divider(color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.teal,
                    ),
                    tooltip: 'Call',
                    onPressed: widget.func1,
                  ),
                  Text(
                    'Call',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.teal,
                    ),
                    tooltip: 'Message ',
                    onPressed: widget.func2,
                  ),
                  Text(
                    'Message',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    tooltip: 'Delete ',
                    onPressed: widget.func4,
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
