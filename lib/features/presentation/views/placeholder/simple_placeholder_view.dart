import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../widgets/common_app_bar.dart';

class SimplePlaceholderView extends StatelessWidget {
  final String title;
  final String message;

  const SimplePlaceholderView({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(title: title),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors(context).text,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

