import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_styling.dart';

import '../../../core/theme/theme_data.dart';


class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;

  const CommonTextField({
    super.key,
    required this.controller,
    this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppStyling.normal600Size12.copyWith(
            color: colors(context).text
          )
        ),
        14.verticalSpace,
        SizedBox(
          height: 46.h,
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            onChanged: onChanged,
            style:AppStyling.normal400Size15.copyWith(
              color:  colors(context).text
            ),
            // maxLength: maxLength,
            // maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: colors(context).secondaryText),
              prefixIcon:
                  prefixIcon != null
                      ? Icon(prefixIcon, color: colors(context).secondaryText,size: 19.h,)
                      : null,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: colors(context).secondarySurface,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 12.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: colors(context).secondarySurfaceBorder,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: Colors.blue.withOpacity(0.7),
                  width: 2,
                ),
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
