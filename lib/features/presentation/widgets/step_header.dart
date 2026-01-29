import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/theme_data.dart';

class StepHeader extends StatelessWidget {
  final int currentStep;
  const StepHeader({super.key, required this.currentStep});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStep(1,context),
            _buildLine(2,context),
            _buildStep(3,context),
            _buildLine(3,context),
            _buildStep(4,context),
          ],
        ),
      ],
    );
  }

  Widget _buildStep(int step,context) {
    final isActive = currentStep >= step;

    return Column(
      children: [
        Container(
          height: 18.h,
          width: 18.h,
          decoration: BoxDecoration(
            color: isActive ? colors(context).text : colors(context).white,
            shape: BoxShape.circle,
            border: Border.all(
              color: colors(context).text ,
              width: isActive ? 0 : 2,
            )
          ),
          child:Icon(
            Icons.check,
            color:isActive ? colors(context).white : colors(context).text,
            size: 14.r,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int step,context) {
    final isActive = currentStep >= step;
    return Container(
      height:isActive? 2.h:1.h,
      width: 80.w,
      color: colors(context).text,
    );
  }

  // Widget _buildLabel(String text, int step) {
  //   return SizedBox(
  //     width: 80.w,
  //     child: Text(
  //       text,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         fontSize: 12.sp,
  //         fontWeight: currentStep >= step ? FontWeight.w600 : FontWeight.normal,
  //         color: _textColor(step),
  //         height: 1.3,
  //       ),
  //     ),
  //   );
  // }
}