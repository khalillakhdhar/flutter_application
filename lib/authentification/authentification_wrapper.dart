import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/screens/navigator.dart';
import 'package:flutter_application/screens/splash/welcome_page.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return BottomNavBar();
    } else {
      return WelcomePage();
    }
  }
}
