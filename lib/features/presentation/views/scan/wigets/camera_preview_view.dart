import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../../../core/theme/colors/main_colors.dart';
import '../../../../../core/theme/theme_data.dart';

class CameraPreviewBox extends StatelessWidget {
  final GlobalKey qrKey;

  const CameraPreviewBox({super.key, required this.qrKey});

  @override
  Widget build(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 ||
                MediaQuery.of(context).size.height < 400)
            ? 250.w
            : 400.w;
    return SizedBox(
      width: scanArea-2,
      height: scanArea -2,
      child: QRView(
        key: qrKey,
        onQRViewCreated: (_) {},
        overlay: QrScannerOverlayShape(
          overlayColor: colors(context).surface,
          borderColor: MainColors.appBlueColor,
          borderRadius: 20.r,
          borderLength: 30,
          borderWidth: 10.w,
          cutOutSize: scanArea,
        ),
      ),
    );
  }
}
