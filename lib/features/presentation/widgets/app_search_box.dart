import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/theme_data.dart';

class AppSearchBox extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool autofocus;

  const AppSearchBox({
    super.key,
    this.controller,
    this.hintText = 'Search here...',
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          // Optional: Add a subtle shadow for depth, if needed
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.05),
          //   blurRadius: 5,
          //   offset: Offset(0, 3),
          // ),
        ],
        border: Border.all(
          color: colors(context).secondarySurfaceBorder,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        autofocus: autofocus,
        style:  TextStyle(
          color: colors(context).text,
          fontSize: 12.sp,
        ),
        decoration: InputDecoration(

          hintText: hintText,
          hintStyle: TextStyle(
            color:  colors(context).text.withValues(alpha: .54),
            fontSize: 12.sp,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,

          prefixIcon: Padding(
            padding:  EdgeInsets.only(right: 19.w),
            child: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 13.w,
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }
}