import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      appBar: const CommonAppBar(title: 'QR'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              24.verticalSpace,
              Center(
                child: Container(
                  width: 220.w,
                  height: 220.w,
                  decoration: BoxDecoration(
                    color: colors(context).secondarySurface,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Center(
                    child: QrImageView(
                      data: 'wavelearn-monthly-qr',
                      version: QrVersions.auto,
                      size: 160.w,
                    ),
                  ),
                ),
              ),
              32.verticalSpace,
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

