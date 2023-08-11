import 'package:flutter/material.dart';
import 'package:jym_app/core/constants/constants.dart';

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryColor: primaryClr,
  );
  static final dark = ThemeData(
    backgroundColor: darkHeaderClr,
    brightness: Brightness.dark,
    primaryColor: darkGreyClr,
  );
}
