import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';

class TutorQrHomeView extends StatelessWidget {
  const TutorQrHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Monthly QR Generator'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              32.verticalSpace,
              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: colors(context).text,
                ),
              ),
              12.verticalSpace,
              Text(
                'You can generate or view Monthly QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: colors(context).secondaryText,
                ),
              ),
              40.verticalSpace,
              Expanded(
                child: Center(
                  child: Container(
                    width: 260.w,
                    decoration: BoxDecoration(
                      color: colors(context).secondarySurface,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code_2_rounded,
                          size: 96.w,
                          color: Colors.blueAccent,
                        ),
                        24.verticalSpace,
                        Text(
                          'Monthly QR Generator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: colors(context).text,
                          ),
                        ),
                        8.verticalSpace,
                        Text(
                          'Generate a new QR or view existing one for attendance.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: colors(context).secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CommonButton(
                text: 'Generate New QR',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.kTutorQrGenerateView);
                },
              ),
              16.verticalSpace,
              CommonButton(
                text: 'View QR',
                backgroundColor: Colors.white,
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.kTutorQrViewOnly);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

