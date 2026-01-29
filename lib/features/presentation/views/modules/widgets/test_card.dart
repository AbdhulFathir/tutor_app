import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/modules/widgets/test.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/enums.dart';

class TestCard extends StatelessWidget {
  final TestItem item;
  final bool hasIcon;

  const TestCard({super.key, required this.item, this.hasIcon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 7.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: colors(context).secondarySurfaceBorder),
        boxShadow: [
          BoxShadow(
            color: colors(context).secondarySurfaceShadow,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 13.h, 18.w, 13.h),
        child: Row(
          children: [
            Container(
              width: 57.w,
              height: 57.w,
              decoration: BoxDecoration(
                color: const Color(0xFF2979FF),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(item.icon, color: Colors.white, size: 27.w),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: colors(context).text,
                      ),
                    ),
                    12.verticalSpace,
                    Text(
                      item.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11.sp,
                        color: colors(context).secondaryText,
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Image.asset(
                          item.status == TestStatus.COMPLETED
                              ? AppAssets.iconCheckGreenOutline
                              : AppAssets.iconInfoFill,
                          // color:
                          //     item.status == TestStatus.COMPLETED
                          //         ? Color(0xFF1CB009)
                          //         : Colors.red,
                          height: 24.w,
                          width: 24.w,
                        ),
                        4.horizontalSpace,
                        Text(
                          item.status.name.replaceAll('_', ' '),
                          // e.g., "COMPLETED"
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                item.status == TestStatus.COMPLETED
                                    ? Color(0xFF1CB009)
                                    : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (hasIcon) Icon(Icons.chevron_right, color: colors(context).text),
          ],
        ),
      ),
    );
  }
}
