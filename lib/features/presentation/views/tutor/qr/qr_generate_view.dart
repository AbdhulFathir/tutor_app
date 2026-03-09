import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/group_dropdown.dart';
import '../../../../../utils/enums.dart';

class TutorQrGenerateView extends StatefulWidget {
  const TutorQrGenerateView({super.key});

  @override
  State<TutorQrGenerateView> createState() => _TutorQrGenerateViewState();
}

class _TutorQrGenerateViewState extends State<TutorQrGenerateView> {
  String? _selectedGroup;
  String _selectedMonth = _monthNames[DateTime.now().month - 1];

  static const List<String> _monthNames = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String _buildQrPayload() {
    final group = _selectedGroup ?? 'all';
    final month = _selectedMonth;
    return 'wavelearn-monthly-qr|group=$group|month=$month';
  }

  Future<Directory> _resolveDownloadsDirectory() async {
    if (Platform.isAndroid) {
      final defaultDir = Directory('/storage/emulated/0/Download');
      if (await defaultDir.exists()) {
        return defaultDir;
      }
      final extDir = await getExternalStorageDirectory();
      if (extDir != null) {
        return extDir;
      }
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _saveQrToDownloads(String data) async {
    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          return false;
        }
      }

      final qrPainter = QrPainter(
        data: data,
        version: QrVersions.auto,
        gapless: true,
        color: Colors.black,
        emptyColor: Colors.white,
      );

      final ui.ImageByteFormat format = ui.ImageByteFormat.png;
      final ByteData? imageData =
          await qrPainter.toImageData(1024, format: format);
      if (imageData == null) return false;

      final bytes = imageData.buffer.asUint8List();
      final dir = await _resolveDownloadsDirectory();
      final fileName =
          'monthly_qr_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _showGeneratedDialog(BuildContext context, String data) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40.w,
              ),
              12.verticalSpace,
              Text(
                'QR Generated Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colors(context).text,
                ),
              ),
              24.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: colors(context).secondarySurface,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                padding: EdgeInsets.all(16.w),
                child: QrImageView(
                  data: data,
                  version: QrVersions.auto,
                  size: 160.w,
                ),
              ),
              24.verticalSpace,
              CommonButton(
                text: 'Download QR',
                onPressed: () async {
                  final success = await _saveQrToDownloads(data);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (_) => AppDialog(
                        title: success ? 'Saved' : 'Failed',
                        description: success
                            ? 'QR saved to Downloads folder.'
                            : 'Unable to save QR. Please check permissions and try again.',
                        alertType: success
                            ? AlertType.SUCCESS
                            : AlertType.FAIL,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Generate New QR'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              32.verticalSpace,
              Text(
                'Welcome',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              24.verticalSpace,
              Text(
                'You can generate QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors(context).secondaryText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              32.verticalSpace,
              GroupDropdown(
                selectedGroup: _selectedGroup,
                onChanged: (value) {
                  setState(() {
                    _selectedGroup = value;
                  });
                },
              ),
              16.verticalSpace,
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: colors(context).secondarySurface,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: colors(context).secondarySurfaceBorder,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    isExpanded: true,
                    items: _monthNames
                        .map(
                          (m) => DropdownMenuItem<String>(
                            value: m,
                            child: Text(m),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedMonth = value;
                      });
                    },
                  ),
                ),
              ),
              const Spacer(),
              CommonButton(
                text: 'Generate',
                onPressed: () {
                  final data = _buildQrPayload();
                  _showGeneratedDialog(context, data);
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

