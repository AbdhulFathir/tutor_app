import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/enums.dart';

class CommonOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonFillType buttonFillType;
  final ButtonType buttonType;

  const CommonOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonFillType = ButtonFillType.outlined,
    this.buttonType = ButtonType.ENABLED,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: buttonType == ButtonType.DISABLED ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (buttonFillType == ButtonFillType.outlined) {
              return Colors.transparent;
            } else {
              if (buttonType == ButtonType.ENABLED){
                return Color(0xFF0060DB);
              } else {
                return Color(0xFF93C8FF);
              }

          }
          }),
          side: WidgetStateProperty.all<BorderSide>(
            BorderSide(
              color:
                  buttonFillType == ButtonFillType.outlined
                      ? buttonType == ButtonType.ENABLED ?Color(0xFF0060DB) : Colors.grey
                      : Color(0xFF0060DB),
              width: 1.0.w,
            ),
          ),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            color:
                buttonFillType == ButtonFillType.outlined
                    ? buttonType == ButtonType.ENABLED
                        ? Color(0xFF0060DB)
                        : Colors.grey
                    : Colors.white,
          ),
        ),
      ),
    );
  }
}
