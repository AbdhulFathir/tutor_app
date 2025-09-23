import 'package:flutter/material.dart';
import 'enums.dart';

class AppTheme {
  ThemeData themeData;
  ThemeType themeType;
  AppTheme({
    required this.themeData,
    required this.themeType,
  });
}

// final List<AppTheme> themes = [
//   AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),
//   AppTheme(themeData: getAppTheme(ThemeType.DARK), themeType: ThemeType.DARK),
// ];