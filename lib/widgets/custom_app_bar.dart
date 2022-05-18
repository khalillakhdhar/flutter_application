// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String screenTitle;
  CustomAppBar(this.screenTitle);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.secondaryColor,
      elevation: 0.0,
      title: Text(screenTitle),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
