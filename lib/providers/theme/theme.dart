import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.orange[800],
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.orange[800],
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    fontFamily: GoogleFonts.robotoFlex().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.orange[100],
      // selectedItemColor: Colors.orange[800].withOpacity(0.7),
      // unselectedItemColor: Colors.orange[800].withOpacity(0.32),
      showUnselectedLabels: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: IconThemeData(
        color: Colors.orange[800],
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.black26,
      onPrimary: Colors.black26,
      secondary: Colors.orange,
    ),
    cardTheme: CardTheme(
      color: Colors.grey[800],
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    fontFamily: GoogleFonts.robotoFlex().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[800],
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
    ),
  );
}