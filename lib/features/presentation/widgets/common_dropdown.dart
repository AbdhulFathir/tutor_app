import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CommonDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String label;
  final String? hint;
  final void Function(T?)? onChanged;
  final String Function(T)? itemToString;
  final bool enabled;

  const CommonDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    this.hint,
    this.onChanged,
    this.itemToString,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color:  Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: true, 
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor:  Colors.black,
            contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), 
              borderSide: BorderSide.none, 
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          dropdownColor:  Colors.white,
          borderRadius: BorderRadius.circular(8),
          elevation: 2,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemToString?.call(item) ?? item.toString(),
                // style: TextStyle(fontSize: 14.sp),
              ),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }
} 