import 'enums.dart';

const String kSVGType = '.svg';
const String kPngType = '.png';
const String kWebpType = '.webp';
const String kAniType = '.json';


class AppAssets {
  static ThemeType _themeType = ThemeType.SYSTEM;

  void setTheme(ThemeType? themeType) {
    _themeType = themeType ?? ThemeType.SYSTEM;
  }

  static String themeType(String path) {
    switch (_themeType) {
      case ThemeType.LIGHT:
        return 'assets/light/$path';
      case ThemeType.DARK:
        return 'assets/dark/$path';
      case ThemeType.SYSTEM:
      default:
        return 'assets/light/$path';
    }
  }

  // Base path for PNG images
  static String get kPNGImagePath => themeType("png/");


  // Base path for SVG images
  static String get kSVGImagePath => themeType("svg/");



  static String get appLogo => '${kPNGImagePath}logo$kPngType';

}