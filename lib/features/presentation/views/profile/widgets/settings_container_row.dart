import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';


class SettingsContainerRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isLastItem;
  final bool hasTrailing;

  const SettingsContainerRow({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.isLastItem = false,
    this.hasTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only( bottom: isLastItem ? 0 : 22.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: colors(context).text,
            ),
            14.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: colors(context).text,
                ),
              ),
            ),
            if(hasTrailing)
              trailing
                  ??Icon(
                Icons.chevron_right,
                color: colors(context).text,
              ),
          ],
        ),
      ),
    );
  }
}



