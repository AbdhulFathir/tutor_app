import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/app_dialog.dart';
import '../../../../../utils/enums.dart';

class TutorQrGenerateView extends StatelessWidget {
  const TutorQrGenerateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Generate QR'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              32.verticalSpace,
              Text(
                'Monthly QR for attendance',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              24.verticalSpace,
              Container(
                width: 220.w,
                height: 220.w,
                decoration: BoxDecoration(
                  color: colors(context).secondarySurface,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: QrImageView(
                    data: DateTime.now().toIso8601String(),
                    version: QrVersions.auto,
                    size: 160.w,
                  ),
                ),
              ),
              const Spacer(),
              CommonButton(
                text: 'Done',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      title: 'Success',
                      description: 'QR generated successfully.',
                      alertType: AlertType.SUCCESS,
                    ),
                  );
                },
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

