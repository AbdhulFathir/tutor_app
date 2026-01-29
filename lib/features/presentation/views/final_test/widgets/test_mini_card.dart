import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';

class TestMiniCard extends StatelessWidget {
  final String image;
  // final Widget iconIndicator;
  final String title;
  final String subtitle;
  // final Color color;

  const TestMiniCard({super.key, required this.image, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: colors(context).secondarySurface,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color:colors(context).secondarySurfaceShadow,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(9.w, 9.h, 9.w, 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              width: 24.w,
              height: 24.w,
            ),
            11.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: colors(context).text
                  ),
                ),
                3.verticalSpace,
                Text(
                  subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: colors(context).secondaryText
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}