import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/presentations/home_page/manag/cubits/them_cubit/theme_cubit.dart';

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

  static TextStyle titleStyle() {
    return GoogleFonts.lato(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle subTitleStyle() {
    return GoogleFonts.lato(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }
}
