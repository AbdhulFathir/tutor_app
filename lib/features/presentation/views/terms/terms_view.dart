import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/common_outlined_button.dart';
import '../../../../utils/enums.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: colors(context).surface,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 33.h, left: 31.w, right: 31.w),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF000000),
                    Color(0xFF0060DB),
                    Color(0xFF003375),
                    Color(0xFF003375),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20.w,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Edit profile',
                            style: AppStyling.normal500Size16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  36.verticalSpace,
                  Text(
                    'Hello 👋',
                    style: AppStyling.normal500Size14.copyWith(
                      color: Colors.white.withValues(alpha: 0.73),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Your trust matters. Please review our Terms & Conditions carefully.',
                    style: AppStyling.normal500Size14.copyWith(
                      color: Colors.white.withValues(alpha: 0.73),
                    ),
                  ),
                  25.verticalSpace,
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 21.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Terms & Conditions', style: AppStyling.normal600Size16),
                    Text(
                      'Latest updated: 4 Jun 2025',
                      style: AppStyling.normal400Size9.copyWith(
                        color: Colors.black.withValues(alpha: 0.26),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Please read these Terms & Conditions carefully before using our app. By accessing or using this app, you agree to be bound by these terms. If you do not agree, you should stop using the app immediately.',
                      style: TextStyle(
                        color: colors(context).text.withValues(alpha: 0.68),
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    termSection(
                      context,
                      title: '1. Acceptance of Terms',
                      content:
                          'By using this app, you agree to follow these Terms & Conditions. Please read them carefully before using the app.',
                      textColor: colors(context).text,
                    ),
                    SizedBox(height: 24.h),

                    termSection(
                      context,
                      title: '2. Use of the App',
                      content:
                          'This app is provided for your personal use only. You agree not to use it for illegal purposes or in ways that may harm others.',
                      textColor: colors(context).text,
                    ),
                    SizedBox(height: 24.h),

                    termSection(
                      context,
                      title: '3. User Accounts',
                      content:
                          'You are responsible for keeping your login details safe. Any activity under your account will be considered your responsibility.',
                      textColor: colors(context).text,
                    ),
                    SizedBox(height: 24.h),

                    termSection(
                      context,
                      title: '4. Privacy',
                      content:
                          'We respect your privacy. Your personal information will be handled according to our Privacy Policy.',
                      textColor: colors(context).text,
                    ),
                    SizedBox(height: 24.h),

                    termSection(
                      context,
                      title: '5. Changes to the Terms',
                      content:
                          'We reserve the right to modify these terms at any time. We will notify you of any changes.',
                      textColor: colors(context).text,
                    ),
                    SizedBox(height: 24.h),

                    termSection(
                      context,
                      title: '6. Privacy',
                      content:
                          'We respect your privacy. Your personal information will be handled according to our Privacy Policy.',
                      textColor: colors(context).text,
                    ),
                    SizedBox(height: 24.h),

                    termSection(
                      context,
                      title: '7. Changes to the Terms',
                      content:
                          'We reserve the right to modify these terms at any time. We will notify you of any changes.',
                      textColor: colors(context).text,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: colors(context).secondarySurface.withValues(alpha: 0.1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CommonOutlinedButton(
                      text: 'Decline',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      buttonFillType: ButtonFillType.outlined,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CommonOutlinedButton(
                      text: 'Accept',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      buttonFillType: ButtonFillType.filled,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget termSection(
    BuildContext context, {
    required String title,
    required String content,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          content,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.8),
            fontSize: 14.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
