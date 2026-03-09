import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/group_dropdown.dart';

class TutorQrViewOnly extends StatefulWidget {
  const TutorQrViewOnly({super.key});

  @override
  State<TutorQrViewOnly> createState() => _TutorQrViewOnlyState();
}

class _TutorQrViewOnlyState extends State<TutorQrViewOnly> {
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

  Future<void> _showQrDialog(BuildContext context, String data) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'QR Code',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colors(context).text,
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
                    data: data,
                    version: QrVersions.auto,
                    size: 180.w,
                  ),
                ),
              ),
              24.verticalSpace,
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
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
      appBar: const CommonAppBar(title: 'View QR'),
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
              16.verticalSpace,
              Text(
                'You can view QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: colors(context).secondaryText,
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
                showAllOption: true,
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
                text: 'View',
                onPressed: () {
                  final data = _buildQrPayload();
                  _showQrDialog(context, data);
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
