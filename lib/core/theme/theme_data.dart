import 'package:flutter/material.dart';
import '../../utils/app_constants.dart';
import '../../utils/enums.dart';
import 'colors/app_colors.dart';
import 'colors/dark_colors.dart';
import 'colors/light_colors.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;


ThemeData getAppTheme(ThemeType themeType) {
  AppColors colors;
  switch (themeType) {
    case ThemeType.LIGHT:
      colors = LightColors().lightTheme() ;
      break;
    case ThemeType.DARK:
      colors = DarkColors().darkTheme();
      break;
    default:
      colors = LightColors().lightTheme() ;
  }

  return ThemeData(
    fontFamily: AppConstants.kFontFamily,
    useMaterial3: false,
    extensions: <ThemeExtension<AppColors>>[
      colors
    ],
    scaffoldBackgroundColor: themeType == ThemeType.DARK 
        ? const Color(0xFF1A1A1A) 
        : Colors.white,
    primaryColor: const Color(0xFF2979FF),
    appBarTheme: AppBarTheme(
      backgroundColor: themeType == ThemeType.DARK 
          ? const Color(0xFF1A1A1A) 
          : Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: themeType == ThemeType.DARK ? Colors.white : Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: themeType == ThemeType.DARK ? Colors.white : Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}