import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData? icon;

  const CommonCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Row(
          children: [
            Container(
              width: 3.w,
              height: 3.h,
              color: color,
            ),
            SizedBox(width: 2.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color:  Colors.black
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (icon != null) Icon(icon, color: color),
          ],
        ),
      ),
    );
  }
} 