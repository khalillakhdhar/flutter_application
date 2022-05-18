// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/screens/home/home_screen.dart';
import 'package:flutter_application/screens/income_expenses/inc_exp_screen.dart';
import 'package:flutter_application/screens/Employer/Employer_screen.dart';
import 'Activity/activity_screen.dart';
import 'Contact/contact_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List _screens = [
    EmployerScreen(),
    contactScreen(),
    HomeScreen(),
    ActivityScreen(),
    IncExpScreen(),
  ];

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[50],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [
          Icons.person,
          Icons.group,
          Icons.home,
          Icons.add_circle,
          Icons.bar_chart,
        ]
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: _currentIndex == key
                          ? Colors.blue[600]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(value),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
