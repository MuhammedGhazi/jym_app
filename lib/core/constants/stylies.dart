import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jym_app/features/presentations/home_page/manag/cubits/cubit/theme_cubit.dart';

class Stylies {
  static TextStyle subHeadingStyle() {
    return GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: ThemeCubit().isDartMode ? Colors.grey[400] : Colors.grey,
    );
  }

  static TextStyle headingStyle() {
    return GoogleFonts.lato(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }
}
