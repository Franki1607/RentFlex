import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      color: appBarColor,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: primaryColor,
    ),
    cardTheme: CardTheme(
      color: cardColor,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    fontFamily: GoogleFonts.robotoFlex().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: primaryColor.withOpacity(0.32),
      showUnselectedLabels: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      color: appBarColor,
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      onPrimary: Colors.black,
      secondary: primaryColor,
    ),
    cardTheme: CardTheme(
      color: cardColor,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    fontFamily: GoogleFonts.robotoFlex().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
    ),
  );
}
