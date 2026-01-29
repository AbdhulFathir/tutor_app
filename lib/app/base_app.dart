import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/theme/theme_service.dart';
import '../utils/app_assets.dart';
import '../utils/app_constants.dart';
import '../utils/navigation_routes.dart';

class BaseApp extends ConsumerStatefulWidget {
  const BaseApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseAppState();
}

class _BaseAppState extends ConsumerState<BaseApp> {
  final AppAssets appAssets = AppAssets();

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    appAssets.setTheme(theme.themeType);
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (_,child){
        return MaterialApp(
          title: AppConstants.appName,
          initialRoute: Routes.kSplashView,
          onGenerateRoute: Routes.generateRoute,
          theme: theme.themeData,
        );
      }
    );
  }
}
