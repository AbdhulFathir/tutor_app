import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/common_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
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
                  // Use a slightly bolder weight for the main title
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
            const Spacer(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:42.w),
              child: CommonButton(
                text: 'Get Start',
                onPressed: () => Navigator.pushNamed(context, Routes.kLoginView),
              ),
            ),
            SizedBox(height: 122),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.grey[600],
                ),
                children: <TextSpan>[
                  TextSpan(text: 'By Sign in you Agree To WaveLearn`s\n'),
                  TextSpan(
                    text: 'Terms And Conditions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' Guidline And Our '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 34),
          ],
        ),
      ),
    );
  }
}


