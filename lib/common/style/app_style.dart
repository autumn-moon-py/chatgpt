import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData defaultThemeData = ThemeData(
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        toolbarHeight: 40,
        backgroundColor: Color.fromRGBO(68, 70, 84, 1),
        titleTextStyle: TextStyle(fontSize: 25, color: Colors.white),
        actionsIconTheme: IconThemeData(size: 30, color: Colors.white)),
  );
}
