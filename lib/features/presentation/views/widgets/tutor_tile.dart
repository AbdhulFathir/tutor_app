import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';

class TutorTile extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const TutorTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
        decoration: BoxDecoration(
          color: colors(context).secondarySurface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors(context).secondarySurfaceBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(icon))
              ),
            ),
            Spacer(),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

