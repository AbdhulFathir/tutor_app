import 'package:flutter/material.dart';
import '../features/presentation/views/admins/add_admin_view.dart';
import '../features/presentation/views/admins/edit_admin_view.dart';
import '../features/presentation/views/admins/manage_admins_view.dart';
import '../features/presentation/views/announcements/announcements_view.dart';
import '../features/presentation/views/class_groups/edit_group_view.dart';
import '../features/presentation/views/class_groups/manage_class_groups_view.dart';
import '../features/presentation/views/lessons/manage_lesson_detail_view.dart';
import '../features/presentation/views/lessons/manage_lessons_view.dart';
import '../features/presentation/views/materials/upload_materials_view.dart';
import '../features/presentation/views/notifications/notification_details_view.dart';
import '../features/presentation/views/polls/polls_view.dart';
import '../features/presentation/views/qr/qr_generate_view.dart';
import '../features/presentation/views/qr/qr_home_view.dart';
import '../features/presentation/views/qr/qr_view_only.dart';
import '../features/presentation/views/results/test_submissions_view.dart';
import '../features/presentation/views/results/tutor_results_view.dart';
import '../features/presentation/views/settings/settings_view.dart';
import '../features/presentation/views/splash/splash_view.dart';
import '../features/presentation/views/Home/tutor_home_view.dart';
import '../features/presentation/views/login/login_view.dart';
import '../features/presentation/views/students/add_student_view.dart';
import '../features/presentation/views/students/edit_student_view.dart';
import '../features/presentation/views/students/manage_students_view.dart';
import '../features/presentation/views/tests/add_test_view.dart';
import '../features/presentation/views/tests/edit_test_view.dart';
import '../features/presentation/views/tests/manage_tests_view.dart';
import '../features/presentation/views/welcome/welcome_view.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kLoginView = "kLoginView";
  static const String kWelcomeView = "kWelcomeView";
  static const String kSettingsView = "kSettingsView";


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
  static const String kTutorTestSubmissionsView = "kTutorTestSubmissionsView";
  static const String kTutorManageAdminsView = "kTutorManageAdminsView";
  static const String kTutorAddAdminView = "kTutorAddAdminView";
  static const String kTutorEditAdminView = "kTutorEditAdminView";
  static const String kNotificationDetailsView = "kNotificationDetailsView";

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
          builder: (_) => const TutorResultsView(),
          settings: const RouteSettings(name: Routes.kTutorResultsView),
        );
      case Routes.kTutorTestSubmissionsView:
        return MaterialPageRoute(
          builder: (_) => const TestSubmissionsView(),
          settings: RouteSettings(
            name: Routes.kTutorTestSubmissionsView,
            arguments: settings.arguments,
          ),
        );
      case Routes.kTutorManageAdminsView:
        return MaterialPageRoute(
          builder: (_) => const ManageAdminsView(),
          settings: const RouteSettings(name: Routes.kTutorManageAdminsView),
        );
      case Routes.kTutorAddAdminView:
        return MaterialPageRoute(
          builder: (_) => const AddAdminView(),
          settings: const RouteSettings(name: Routes.kTutorAddAdminView),
        );
      case Routes.kTutorEditAdminView:
        return MaterialPageRoute(
          builder: (_) => const EditAdminView(),
          settings: RouteSettings(
            name: Routes.kTutorEditAdminView,
            arguments: settings.arguments,
          ),
        );
      case Routes.kNotificationDetailsView:
        return MaterialPageRoute(
          builder: (_) => const NotificationDetailsView(),
          settings: RouteSettings(
            name: Routes.kNotificationDetailsView,
            arguments: settings.arguments,
          ),
        );
      case Routes.kSettingsView:
        return MaterialPageRoute(
          builder: (_) => const SettingsView(),
          settings: const RouteSettings(name: Routes.kSettingsView),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Invalid Route"))),
        );
    }
  }
}
