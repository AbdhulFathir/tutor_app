import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/scan/wigets/camera_preview_view.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/common_button.dart';
import '../../widgets/gradiant_text.dart';

class ScanPreviewView extends StatefulWidget {
  const ScanPreviewView({super.key});

  @override
  State<ScanPreviewView> createState() => _ScanPreviewViewState();
}

final GlobalKey qrKey = GlobalKey(debugLabel: "qr_preview");
final GlobalKey qrKey2 = GlobalKey(debugLabel: 'QR');

class _ScanPreviewViewState extends State<ScanPreviewView> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            85.verticalSpace,
            GradientText(
              '${AppString.welcomeBack} Senuri!',
              style: TextStyle(fontSize: 24.sp,
                fontWeight: FontWeight.w700,),
              gradient: LinearGradient(colors: [
                Color(0xFF0E82FC),
                Color(0xFF063976),
                Color(0xFF063976),
              ]),
            ),
            22.verticalSpace,
            Text(
              AppString.scanMonthlyQR,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500
              ),
            ),
            87.verticalSpace,
            Text(
              "Place QR inside the frame to scan",
              style: TextStyle(
                color: colors(context).text,
                fontSize: 13.sp,
              ),
            ),
            29.verticalSpace,
            CameraPreviewBox(qrKey: qrKey),
            // SizedBox(
            //     height:scanArea,
            //     width:scanArea,
            //     child: _buildQrView(context)),
            121.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 42.w),
              child: CommonButton(
                image: AppAssets.iconScanWhite,
                text: "Scan Here",
                onPressed: () {
                  Navigator.pushNamed(context, Routes.kHomeView);
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) => const QRScanView()));
                },
                backgroundColor: const Color(0xFF2979FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

