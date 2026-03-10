import 'package:flutter/material.dart';
import '../features/presentation/views/modules/widgets/test.dart';
import '../features/presentation/views/scan/qr_scan_view.dart';
import '../features/presentation/views/splash/splash_view.dart';
import '../features/presentation/views/tutor/placeholder/simple_placeholder_view.dart';
import '../features/presentation/views/tutor/qr/qr_view_only.dart';
import '../features/presentation/views/tutor/tutor_home_view.dart';
import '../features/presentation/views/tutor/students/add_student_view.dart';
import '../features/presentation/views/tutor/students/edit_student_view.dart';
import '../features/presentation/views/tutor/students/manage_students_view.dart';
import '../features/presentation/views/tutor/class_groups/edit_group_view.dart';
import '../features/presentation/views/tutor/class_groups/manage_class_groups_view.dart';
import '../features/presentation/views/tutor/tests/manage_tests_view.dart';
import '../features/presentation/views/tutor/tests/add_test_view.dart';
import '../features/presentation/views/tutor/tests/edit_test_view.dart';
import '../features/presentation/views/tutor/qr/qr_generate_view.dart';
import '../features/presentation/views/tutor/qr/qr_home_view.dart';
import '../features/presentation/views/tutor/materials/upload_materials_view.dart';
import '../features/presentation/views/tutor/lessons/manage_lessons_view.dart';
import '../features/presentation/views/tutor/lessons/manage_lesson_detail_view.dart';
import '../features/presentation/views/tutor/announcements/announcements_view.dart';
import '../features/presentation/views/tutor/polls/polls_view.dart';
import '../features/presentation/views/tutor/admins/manage_admins_view.dart';
import '../features/presentation/views/tutor/notifications/notifications_view.dart';
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

  // Tutor / Admin
  static const String kTutorHomeView = "kTutorHomeView";
  static const String kTutorUploadMaterialsView = "kTutorUploadMaterialsView";
  static const String kTutorManageLessonsView = "kTutorManageLessonsView";
  static const String kTutorManageLessonDetailView = "kTutorManageLessonDetailView";
  static const String kTutorManageStudentsView = "kTutorManageStudentsView";
  static const String kTutorAddStudentView = "kTutorAddStudentView";
  static const String kTutorEditStudentView = "kTutorEditStudentView";
  static const String kTutorManageClassGroupsView = "kTutorManageClassGroupsView";
  static const String kTutorEditGroupView = "kTutorEditGroupView";
  static const String kTutorUploadTestsView = "kTutorUploadTestsView";
  static const String kTutorAddTestView = "kTutorAddTestView";
  static const String kTutorEditTestView = "kTutorEditTestView";
  static const String kTutorQrHomeView = "kTutorQrHomeView";
  static const String kTutorQrGenerateView = "kTutorQrGenerateView";
  static const String kTutorQrViewOnly = "kTutorQrViewOnly";
  static const String kTutorAnnouncementsView = "kTutorAnnouncementsView";
  static const String kTutorPollsView = "kTutorPollsView";
  static const String kTutorResultsView = "kTutorResultsView";
  static const String kTutorManageAdminsView = "kTutorManageAdminsView";
  static const String kTutorNotificationsView = "kTutorNotificationsView";

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
          builder: (_) => const TutorHomeView(),
          settings: const RouteSettings(name: Routes.kHomeView),
        );
      case Routes.kTutorHomeView:
        return MaterialPageRoute(
          builder: (_) => const TutorHomeView(),
          settings: const RouteSettings(name: Routes.kTutorHomeView),
        );
      case Routes.kTutorUploadMaterialsView:
        return MaterialPageRoute(
          builder: (_) => const UploadMaterialsView(),
          settings: const RouteSettings(name: Routes.kTutorUploadMaterialsView),
        );
      case Routes.kTutorManageLessonsView:
        return MaterialPageRoute(
          builder: (_) => const ManageLessonsView(),
          settings: const RouteSettings(name: Routes.kTutorManageLessonsView),
        );
      case Routes.kTutorManageLessonDetailView:
        return MaterialPageRoute(
          builder: (_) => const ManageLessonDetailView(),
          settings: RouteSettings(
            name: Routes.kTutorManageLessonDetailView,
            arguments: settings.arguments,
          ),
        );
      case Routes.kTutorManageStudentsView:
        return MaterialPageRoute(
          builder: (_) => const ManageStudentsView(),
          settings: const RouteSettings(name: Routes.kTutorManageStudentsView),
        );
      case Routes.kTutorAddStudentView:
        return MaterialPageRoute(
          builder: (_) => const AddStudentView(),
          settings: const RouteSettings(name: Routes.kTutorAddStudentView),
        );
      case Routes.kTutorEditStudentView:
        return MaterialPageRoute(
          builder: (_) => const EditStudentView(),
          settings: RouteSettings(
            name: Routes.kTutorEditStudentView,
            arguments: settings.arguments,
          ),
        );
      case Routes.kTutorManageClassGroupsView:
        return MaterialPageRoute(
          builder: (_) => const ManageClassGroupsView(),
          settings: const RouteSettings(name: Routes.kTutorManageClassGroupsView),
        );
      case Routes.kTutorEditGroupView:
        return MaterialPageRoute(
          builder: (_) => const EditGroupView(),
          settings: RouteSettings(
            name: Routes.kTutorEditGroupView,
            arguments: settings.arguments,
          ),
        );
      case Routes.kTutorUploadTestsView:
        return MaterialPageRoute(
          builder: (_) => const ManageTestsView(),
          settings: const RouteSettings(name: Routes.kTutorUploadTestsView),
        );
      case Routes.kTutorAddTestView:
        return MaterialPageRoute(
          builder: (_) => const AddTestView(),
          settings: const RouteSettings(name: Routes.kTutorAddTestView),
        );
      case Routes.kTutorEditTestView:
        return MaterialPageRoute(
          builder: (_) => const EditTestView(),
          settings: RouteSettings(
            name: Routes.kTutorEditTestView,
            arguments: settings.arguments,
          ),
        );
      case Routes.kTutorQrHomeView:
        return MaterialPageRoute(
          builder: (_) => const TutorQrHomeView(),
          settings: const RouteSettings(name: Routes.kTutorQrHomeView),
        );
      case Routes.kTutorQrGenerateView:
        return MaterialPageRoute(
          builder: (_) => const TutorQrGenerateView(),
          settings: const RouteSettings(name: Routes.kTutorQrGenerateView),
        );
      case Routes.kTutorQrViewOnly:
        return MaterialPageRoute(
          builder: (_) => const TutorQrViewOnly(),
          settings: const RouteSettings(name: Routes.kTutorQrViewOnly),
        );
      case Routes.kTutorAnnouncementsView:
        return MaterialPageRoute(
          builder: (_) => const AnnouncementsView(),
          settings: const RouteSettings(name: Routes.kTutorAnnouncementsView),
        );
      case Routes.kTutorPollsView:
        return MaterialPageRoute(
          builder: (_) => const PollsView(),
          settings: const RouteSettings(name: Routes.kTutorPollsView),
        );
      case Routes.kTutorResultsView:
        return MaterialPageRoute(
          builder: (_) => const SimplePlaceholderView(
            title: 'Results',
            message: 'Results screens will be implemented next.',
          ),
          settings: const RouteSettings(name: Routes.kTutorResultsView),
        );
      case Routes.kTutorManageAdminsView:
        return MaterialPageRoute(
          builder: (_) => const ManageAdminsView(),
          settings: const RouteSettings(name: Routes.kTutorManageAdminsView),
        );
      case Routes.kTutorNotificationsView:
        return MaterialPageRoute(
          builder: (_) => const TutorNotificationsView(),
          settings: const RouteSettings(name: Routes.kTutorNotificationsView),
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
