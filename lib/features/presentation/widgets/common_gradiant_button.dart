import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/enums.dart';

class CommonGradiantButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AlertType alertType;

  const CommonGradiantButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.alertType = AlertType.SUCCESS,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors:
                alertType == AlertType.SUCCESS
                    ? [Color(0xFF6BD942), Color(0xFF49B31C)]
                    : [Color(0xFFE57575), Color(0xFFD91414)],
          ),
        ),
        height: 51.h,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
