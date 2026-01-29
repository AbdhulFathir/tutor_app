import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/common_button.dart';

class PasswordSuccessView extends StatelessWidget {
  const PasswordSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      body: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 96),
            SizedBox(height: 2.h),
            const Text('Verification Success', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            SizedBox(height: 0.8.h),
            const Text('You have created your password'),
            SizedBox(height: 3.h),
            CommonButton(
              text: 'Create Password',
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, Routes.kHomeView, (_) => false),
            ),
          ],
        ),
      ),
    );
  }
}


