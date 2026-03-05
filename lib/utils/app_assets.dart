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
      return 'assets/light/$path';
    }
  }

  // Base path for PNG images
  static String get kPNGImagePath => themeType("png/");


  // Base path for SVG images
  static String get kSVGImagePath => themeType("svg/");



  static String get appLogo => '${kPNGImagePath}logo$kPngType';
  static String get successIcon => '${kPNGImagePath}success_icon$kPngType';
  static String get failedIcon => '${kPNGImagePath}failed_icon$kPngType';
  static String get profilePicture => '${kPNGImagePath}profile_pic$kPngType';
  static String get thinkingBoy => '${kPNGImagePath}thinking_boy$kPngType';
  static String get machineLearning => '${kPNGImagePath}machine_learning$kPngType';
  static String get explore => '${kPNGImagePath}explore$kPngType';
  static String get trophyIcon => '${kPNGImagePath}trophy_icon$kPngType';
  static String get iconCalenderBlue => '${kPNGImagePath}ic_calendar_blue$kPngType';
  static String get iconQuestionsOutlined => '${kPNGImagePath}ic_questions_outline$kPngType';
  static String get iconCrossRedOutline => '${kPNGImagePath}ic_cross_red_outline$kPngType';
  static String get iconCheckGreenOutline => '${kPNGImagePath}ic_check_green_outline$kPngType';
  static String get iconChartFill => '${kPNGImagePath}ic_chart_fill$kPngType';
  static String get iconMortarboardGold => '${kPNGImagePath}ic_mortarboard_gold$kPngType';
  static String get iconFolderOpenFill => '${kPNGImagePath}ic_folder_open_fill$kPngType';
  static String get iconCameraFill => '${kPNGImagePath}ic_camera_fill$kPngType';
  static String get iconUploadFileFill => '${kPNGImagePath}ic_upload_file_fill$kPngType';
  static String get iconSearchFill => '${kPNGImagePath}ic_search_fill$kPngType';
  static String get iconInfoFill => '${kPNGImagePath}ic_Info_fill$kPngType';
  static String get iconBellWhite => '${kPNGImagePath}ic_bell_white$kPngType';
  static String get iconNotificationBell => '${kPNGImagePath}ic_notification_bell$kPngType';
  static String get iconScanWhite => '${kPNGImagePath}ic_scan_white$kPngType';
  static String get iconBell => '${kPNGImagePath}ic_bell$kPngType';
  static String get iconSetting => '${kPNGImagePath}ic_setting$kPngType';
  static String get iconUser => '${kPNGImagePath}ic_user$kPngType';
  static String get iconResult => '${kPNGImagePath}ic_result$kPngType';
  static String get iconPoll => '${kPNGImagePath}ic_poll$kPngType';
  static String get iconAnnouncement => '${kPNGImagePath}ic_announcement$kPngType';
  static String get iconScan => '${kPNGImagePath}ic_scan$kPngType';
  static String get iconTest => '${kPNGImagePath}ic_test$kPngType';
  static String get iconUsers => '${kPNGImagePath}ic_users$kPngType';
  static String get iconUploads => '${kPNGImagePath}ic_uploads$kPngType';




}
