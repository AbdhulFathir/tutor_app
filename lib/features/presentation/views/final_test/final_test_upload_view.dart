import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/common_button.dart';

class FinalTestUploadView extends StatelessWidget {
  const FinalTestUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBgColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final cardColor = isDark ? const Color(0xFF222222) : Colors.grey[300];
    final headerColor = const Color(0xFF4CAF50); // Green theme

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: headerColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ML final test',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red..withValues( alpha:0.1),
                    ),
                    child: Icon(
                      Icons.school,
                      color: Colors.red,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'ML final test',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(24.w),
                  width: double.infinity,
                  height: 300.h,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.grey..withValues( alpha:0.5),
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload_file,
                        size: 48.sp,
                        color: textColor..withValues( alpha:0.5),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Upload',
                        style: TextStyle(
                          color: textColor..withValues( alpha:0.7),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'upload your solution file (max 10mb)',
                        style: TextStyle(
                          color: textColor..withValues( alpha:0.5),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  CommonButton(
                    text: 'Open a MCQ Sheet',
                    onPressed: () {},
                    backgroundColor: headerColor,
                  ),
                  SizedBox(height: 16.h),
                  CommonButton(
                    text: 'Submit My Answers',
                    onPressed: () {},
                    backgroundColor: headerColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

