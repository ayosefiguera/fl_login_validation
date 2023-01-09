import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.indigo;
  static const Color warningColor = Colors.amber;
  static final ThemeData appTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: primaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
        backgroundColor: primaryColor,
      ));
}
