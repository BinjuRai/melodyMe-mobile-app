import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.lightBlue,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Playfair_Display',

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Color(0x222740),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: 'Bagel_Fat_One',
        fontSize: 14,
        color: const Color.fromARGB(255, 11, 27, 42),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
