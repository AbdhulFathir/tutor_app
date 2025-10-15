import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.black,
        foregroundColor: textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(vertical: 1.8.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
      child: isLoading
          ? SizedBox(
              height: 2.5.h,
              width: 2.5.h,
              child: CircularProgressIndicator(
                color: textColor ?? Colors.white,
                strokeWidth: 2.5,
              ),
            )
          : icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16.sp),
                    SizedBox(width: 2.w),
                    Text(text),
                  ],
                )
              : Text(text),
    );

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            height: 6.h,
            child: button,
          )
        : button;
  }
} 