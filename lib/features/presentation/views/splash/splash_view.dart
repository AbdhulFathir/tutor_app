import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/navigation_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.kWelcomeView);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.appLogo,
              height: 110.h,
            ),
            SizedBox(height: 15.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
                children:[
                  TextSpan(text: 'Scribble '),
                  TextSpan(
                    text: '2',
                    style: TextStyle(
                      color: Color(0xFF2979FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' Scrabble'),
                ],
              ),
            ),
            SizedBox(height:8.h),
            Text(
              AppString.tagline,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
