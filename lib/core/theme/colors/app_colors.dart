import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? whiteColor;
  final Color? blackColor;

  const AppColors({required this.whiteColor, required this.blackColor});

  @override
  ThemeExtension<AppColors> copyWith({Color? whiteColor, Color? blackColor}) {
    return AppColors(
      whiteColor: whiteColor ?? this.whiteColor,
      blackColor: blackColor ?? this.blackColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      blackColor: Color.lerp(blackColor, other.blackColor, t),
    );
  }
}
