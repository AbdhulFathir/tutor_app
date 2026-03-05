import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../widgets/common_app_bar.dart';

class TutorQrViewOnly extends StatelessWidget {
  const TutorQrViewOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'View QR'),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 260.w,
            height: 260.w,
            decoration: BoxDecoration(
              color: colors(context).secondarySurface,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Center(
              child: QrImageView(
                data: 'wavelearn-monthly-qr',
                version: QrVersions.auto,
                size: 200.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

