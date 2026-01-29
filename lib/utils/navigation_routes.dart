import 'package:flutter/material.dart';
import '../features/presentation/views/modules/widgets/test.dart';
import '../features/presentation/views/scan/qr_scan_view.dart';
import '../features/presentation/views/splash/splash_view.dart';
import '../features/presentation/views/home/home_view.dart';
import '../features/presentation/views/login/login_view.dart';
import '../features/presentation/views/scan/scan_preview_view.dart';
import '../features/presentation/views/forgot_password/phone_view.dart';
import '../features/presentation/views/forgot_password/otp_view.dart';
import '../features/presentation/views/forgot_password/create_password_view.dart';
import '../features/presentation/views/forgot_password/password_success_view.dart';
import '../features/presentation/views/profile/profile_view.dart';
import '../features/presentation/views/profile/edit_profile_view.dart';
import '../features/presentation/views/settings/settings_view.dart';
import '../features/presentation/views/terms/terms_view.dart';
import '../features/presentation/views/modules/modules_view.dart';
import '../features/presentation/views/materials/materials_view.dart';
import '../features/presentation/views/lessons/lessons_view.dart';
import '../features/presentation/views/lessons/supervised_learning_pdf_view.dart';
import '../features/presentation/views/final_test/final_test_score_view.dart';
import '../features/presentation/views/final_test/final_test_story_view.dart';
import '../features/presentation/views/final_test/final_test_upload_view.dart';
import '../features/presentation/views/welcome/welcome_view.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kLoginView = "kLoginView";
  static const String kHomeView = "kHomeView";
  static const String kWelcomeView = "kWelcomeView";
  static const String kScanView = "kScanView";
  static const String kPhoneView = "kPhoneView";
  static const String kOtpView = "kOtpView";
  static const String kCreatePasswordView = "kCreatePasswordView";
  static const String kPasswordSuccessView = "kPasswordSuccessView";
  static const String kProfileView = "kProfileView";
  static const String kEditProfileView = "kEditProfileView";
  static const String kSettingsView = "kSettingsView";
  static const String kTermsView = "kTermsView";
  static const String kModulesView = "kModulesView";
  static const String kMaterialsView = "kMaterialsView";
  static const String kLessonsView = "kLessonsView";
  static const String kSupervisedLearningPdfView = "kSupervisedLearningPdfView";
  static const String kFinalTestScoreView = "kFinalTestScoreView";
  static const String kFinalTestStoryView = "kFinalTestStoryView";
  static const String kFinalTestUploadView = "kFinalTestUploadView";
  static const String kQRScanView = "kQRScanView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return MaterialPageRoute(
          builder: (_) => SplashView(),
          settings: RouteSettings(name: Routes.kSplashView),
        );
      case Routes.kWelcomeView:
        return MaterialPageRoute(
          builder: (_) => const WelcomeView(),
          settings: const RouteSettings(name: Routes.kWelcomeView),
        );
      case Routes.kLoginView:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          settings: const RouteSettings(name: Routes.kLoginView),
        );
      case Routes.kScanView:
        return MaterialPageRoute(
          builder: (_) => const ScanPreviewView(),
          settings: const RouteSettings(name: Routes.kScanView),
        );
      case Routes.kPhoneView:
        return MaterialPageRoute(
          builder: (_) => const PhoneView(),
          settings: const RouteSettings(name: Routes.kPhoneView),
        );
      case Routes.kOtpView:
        return MaterialPageRoute(
          builder: (_) => const OtpView(),
          settings: const RouteSettings(name: Routes.kOtpView),
        );
      case Routes.kCreatePasswordView:
        return MaterialPageRoute(
          builder: (_) => const CreatePasswordView(),
          settings: const RouteSettings(name: Routes.kCreatePasswordView),
        );
      case Routes.kPasswordSuccessView:
        return MaterialPageRoute(
          builder: (_) => const PasswordSuccessView(),
          settings: const RouteSettings(name: Routes.kPasswordSuccessView),
        );
      case Routes.kHomeView:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
          settings: const RouteSettings(name: Routes.kHomeView),
        );
      case Routes.kProfileView:
        return MaterialPageRoute(
          builder: (_) => const ProfileView(),
          settings: const RouteSettings(name: Routes.kProfileView),
        );
      case Routes.kEditProfileView:
        return MaterialPageRoute(
          builder: (_) => const EditProfileView(),
          settings: const RouteSettings(name: Routes.kEditProfileView),
        );
      case Routes.kSettingsView:
        return MaterialPageRoute(
          builder: (_) => const SettingsView(),
          settings: const RouteSettings(name: Routes.kSettingsView),
        );
      case Routes.kTermsView:
        return MaterialPageRoute(
          builder: (_) => const TermsView(),
          settings: const RouteSettings(name: Routes.kTermsView),
        );
      case Routes.kModulesView:
        return MaterialPageRoute(
          builder: (_) => const ModulesView(),
          settings: const RouteSettings(name: Routes.kModulesView),
        );
      case Routes.kMaterialsView:
        return MaterialPageRoute(
          builder: (_) => const MaterialsView(),
          settings: const RouteSettings(name: Routes.kMaterialsView),
        );
      case Routes.kLessonsView:
        return MaterialPageRoute(
          builder: (_) => const LessonsView(),
          settings: const RouteSettings(name: Routes.kLessonsView),
        );
      case Routes.kSupervisedLearningPdfView:
        return MaterialPageRoute(
          builder: (_) => const SupervisedLearningPdfView(),
          settings: const RouteSettings(name: Routes.kSupervisedLearningPdfView),
        );
      case Routes.kFinalTestScoreView:
        return MaterialPageRoute(
          builder: (_) =>  FinalTestScoreView(
            testItem: settings.arguments as TestItem,
          ),
          settings: const RouteSettings(name: Routes.kFinalTestScoreView),
        );
      case Routes.kFinalTestStoryView:
        return MaterialPageRoute(
          builder: (_) => const FinalTestStoryView(),
          settings: const RouteSettings(name: Routes.kFinalTestStoryView),
        );
      case Routes.kFinalTestUploadView:
        return MaterialPageRoute(
          builder: (_) => const FinalTestUploadView(),
          settings: const RouteSettings(name: Routes.kFinalTestUploadView),
        );
      case Routes.kQRScanView:
        return MaterialPageRoute(
          builder: (_) => const QRScanView(),
          settings: const RouteSettings(name: Routes.kQRScanView),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Invalid Route"))),
        );
    }
  }
}
