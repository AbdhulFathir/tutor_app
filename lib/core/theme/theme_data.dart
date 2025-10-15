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
    scaffoldBackgroundColor:Colors.blueAccent,
    primaryColor: Colors.blue,
  );
}