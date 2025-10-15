import 'package:flutter/material.dart';
import 'package:tutor_app/features/presentation/views/home/home_view.dart';
import 'package:tutor_app/features/presentation/views/splash/splash_view.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kLoginView = "kLoginView";
  static const String kHomeView = "kHomeView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return MaterialPageRoute(
          builder: (_) => SplashView(),
          settings: RouteSettings(name: Routes.kSplashView),
        );
        case Routes.kHomeView:
        return MaterialPageRoute(
          builder: (_) => HomeView(),
          settings: RouteSettings(name: Routes.kHomeView),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Invalid Route"))),
        );
    }
  }
}
