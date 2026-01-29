import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../home/widgets/course_card.dart';

class SettingsContainer extends StatelessWidget {
  final Widget widget;

  const SettingsContainer({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: colors(context).secondarySurfaceBorder.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: colors(context).secondarySurfaceShadow.withValues( alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(33.w, 22.h, 33.w, 22.h),
        child: widget,
      ),
    );
  }
}



