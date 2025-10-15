import 'app_colors.dart';
import 'main_colors.dart';

class DarkColors extends MainColors{
  AppColors darkTheme() {
    return AppColors(
      whiteColor: whiteColor,
      blackColor: blackColor,
    );
  }
}