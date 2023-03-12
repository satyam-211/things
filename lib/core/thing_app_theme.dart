import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThingAppTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      textTheme: ThingAppTextTheme.textTheme,
    );
  }
}

class ThingAppTextTheme {
  static get textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.sono(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.sono(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.sono(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.sono(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );
  }
}
