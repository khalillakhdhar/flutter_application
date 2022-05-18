import 'package:flutter/material.dart';
import 'package:flutter_application/config/palette.dart';

class CustomCardA extends StatefulWidget {
  final String Aname;
  final String category;
  final String Adate;
  final String imagePath;
  final Function func1;
  final Function func2;

  CustomCardA({
    this.Aname,
    this.category,
    this.Adate,
    this.imagePath,
    this.func1,
    this.func2,
  });
  @override
  _CustomCardAState createState() => _CustomCardAState();
}

class _CustomCardAState extends State<CustomCardA> {
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
                    widget.Aname,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text(
                    'Category: ${widget.category}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                  Text(
                    'Bought / Next Activity Date: \n${widget.Adate}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                ],
              ),
              Flexible(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  tooltip: 'Delete Activity',
                  onPressed: widget.func2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
