import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color surface;
  final Color text;
  final Color secondarySurface;
  final Color secondarySurfaceShadow;
  final Color secondarySurfaceBorder;
  final Color notificationBackgroundBlue;

  final Color secondaryText;
  final Color white;
  final Color testColor3;
  final Color testColor4;
  final Color testColor5;
  final Color testColor6;
  final Color testColor7;
  final Color testColor8;
  final Color testColor9;
  final Color testColor10;


  const AppColors({
    required this.surface,
    required this.text,
    required this.secondarySurface,
    required this.secondarySurfaceShadow,
    required this.secondarySurfaceBorder,
    required this.notificationBackgroundBlue,
    required this.secondaryText,
    required this.white,
    required this.testColor3,
    required this.testColor4,
    required this.testColor5,
    required this.testColor6,
    required this.testColor7,
    required this.testColor8,
    required this.testColor9,
    required this.testColor10,
  });

  @override
  AppColors copyWith({
    Color? surface,
    Color? text,
    Color? secondarySurface,
    Color? secondarySurfaceShadow,
    Color? secondarySurfaceBorder,
    Color? notificationBackgroundBlue,
    Color? secondaryText,
    Color? white,
    Color? testColor3,
    Color? testColor4,
    Color? testColor5,
    Color? testColor6,
    Color? testColor7,
    Color? testColor8,
    Color? testColor9,
    Color? testColor10,
  }) {
    return AppColors(
      surface: surface ?? this.surface,
      text: text ?? this.text,
      secondarySurface: text ?? this.secondarySurface,
      secondarySurfaceShadow: secondarySurfaceShadow ?? this.secondarySurfaceShadow,
      secondarySurfaceBorder: text ?? this.secondarySurfaceBorder,
      notificationBackgroundBlue: text ?? this.notificationBackgroundBlue,
      secondaryText: secondaryText ?? this.secondaryText,
      white: white ?? this.white,
      testColor3: testColor3 ?? this.testColor3,
      testColor4: testColor4 ?? this.testColor4,
      testColor5: testColor5 ?? this.testColor5,
      testColor6: testColor6 ?? this.testColor6,
      testColor7: testColor7 ?? this.testColor7,
      testColor8: testColor8 ?? this.testColor8,
      testColor9: testColor9 ?? this.testColor9,
      testColor10: testColor10 ?? this.testColor10,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      secondarySurface: Color.lerp(secondarySurface, other.secondarySurface, t)!,
      secondarySurfaceShadow: Color.lerp(secondarySurfaceShadow, other.secondarySurfaceShadow, t)!,
      secondarySurfaceBorder: Color.lerp(secondarySurfaceBorder, other.secondarySurfaceBorder, t)!,
      notificationBackgroundBlue: Color.lerp(notificationBackgroundBlue, other.notificationBackgroundBlue, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      white: Color.lerp(white, other.white, t)!,
      testColor3: Color.lerp(testColor3, other.testColor3, t)!,
      testColor4: Color.lerp(testColor4, other.testColor4, t)!,
      testColor5: Color.lerp(testColor5, other.testColor5, t)!,
      testColor6: Color.lerp(testColor6, other.testColor6, t)!,
      testColor7: Color.lerp(testColor7, other.testColor7, t)!,
      testColor8: Color.lerp(testColor8, other.testColor8, t)!,
      testColor9: Color.lerp(testColor9, other.testColor9, t)!,
      testColor10: Color.lerp(testColor10, other.testColor10, t)!,
    );
  }
}
