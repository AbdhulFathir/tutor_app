import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final String? image;
  final Color? backgroundColor;
  final Color? textColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.image,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Color(0xFF2979FF),
        foregroundColor: textColor ?? Colors.white,
        // padding: EdgeInsets.symmetric(vertical: 16.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        elevation: 2,
      ),
      child: isLoading
          ? SizedBox(
              height: 50.h,
              width: 50.h,
              child: CircularProgressIndicator(
                color: textColor ?? Colors.white,
                strokeWidth: 2.5,
              ),
            )
          : image != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(image??"", width: 24.w , height: 24.w),
                    10.horizontalSpace,
                    Text(text),
                  ],
                )
              : Text(text),
    );

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            height: 51.h,
            child: button,
          )
        : button;
  }
}