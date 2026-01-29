import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/theme_data.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final int? maxLines;
  final void Function(String)? onChanged;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        onChanged: onChanged,
        style: TextStyle(fontSize: 14, color: colors(context).text),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          hintText: label,
          hintStyle: TextStyle(color: colors(context).text.withOpacity(0.5)),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: colors(context).text.withOpacity(0.6))
              : null,
          suffixIcon: suffixIcon,
          suffixIconColor: colors(context).secondaryText,
          filled: true,
          fillColor: colors(context).secondarySurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color:  colors(context).secondarySurfaceBorder,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.7),
              width: 2,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
