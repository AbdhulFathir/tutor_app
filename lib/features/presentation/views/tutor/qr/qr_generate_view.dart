import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final now = DateTime.now().toIso8601String();
    final group = _selectedGroup ?? 'all';
    final month = _selectedMonth;
    return 'wavelearn-monthly-qr|group=$group|month=$month|ts=$now';
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
                onPressed: () {
                  Navigator.of(context).pop();
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

