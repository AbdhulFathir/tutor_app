import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/core/theme/theme_data.dart';
import '../../utils/enums.dart';

class AppTheme {
  ThemeData themeData;
  ThemeType themeType;
  AppTheme({
    required this.themeData,
    required this.themeType,
  });
}

final List<AppTheme> themes = [
  AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),
  AppTheme(themeData: getAppTheme(ThemeType.DARK), themeType: ThemeType.DARK),
];

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> with WidgetsBindingObserver{
  late SharedPreferences _prefs;

  ThemeNotifier() : super(themes.first) {
    // Add WidgetsBindingObserver to listen to platform brightness changes
    WidgetsBinding.instance.addObserver(this);
    _loadThemePreference();
  }

  // Remove observer when the notifier is disposed of
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Override this method to listen for platform brightness changes
  @override
  Future<void> didChangePlatformBrightness() async {
    _prefs = await SharedPreferences.getInstance();
    if(!_prefs.containsKey('theme')){
      switchTheme(ThemeType.SYSTEM);
    }

  }

  void switchTheme(ThemeType themeType) {
    if (themeType == ThemeType.SYSTEM) {
      // Reset preferences and adapt to system theme
      _clearThemePreference();
      final brightness = PlatformDispatcher.instance.platformBrightness;
      state = themes.firstWhere(
            (theme) => theme.themeType == (brightness == Brightness.light ? ThemeType.LIGHT : ThemeType.DARK),
        orElse: () => AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),
      );
    } else {
      state = themes.firstWhere(
            (theme) => theme.themeType == themeType,
        orElse: () => AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),
      );
      _saveThemePreference(state);
    }
  }

  Future<void> _saveThemePreference(AppTheme theme) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('theme', theme.themeType.name);
  }

  Future<void> _clearThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('theme');
  }

  Future<void> _loadThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    final defaultTheme = PlatformDispatcher.instance.platformBrightness == Brightness.light
        ? ThemeType.LIGHT.name
        : ThemeType.DARK.name;

    final themeTypeString = _prefs.getString('theme') ?? defaultTheme;
    final themeType = ThemeType.values.firstWhere(
          (e) => e.name == themeTypeString,
      orElse: () => ThemeType.LIGHT,
    );
    state = themes.firstWhere(
          (theme) => theme.themeType == themeType,
      orElse: () => AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),
    );
  }
}