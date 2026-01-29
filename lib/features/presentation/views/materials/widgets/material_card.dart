import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../home/widgets/course.dart';

class MaterialCard extends StatelessWidget {
  final Course course;

  const MaterialCard({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.h,
      width: 337.w,
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: colors(context).secondarySurfaceBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: colors(context).secondarySurfaceShadow,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 9.w , vertical: 8.h),
            child: Row(
              children: [
                Container(
                  width: 132.w,
                  height: 139.h,
                  decoration: BoxDecoration(
                    image:DecorationImage(image: AssetImage(AppAssets.machineLearning),fit: BoxFit.fill),
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 14.w , vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              course.title,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: colors(context).text,
                              ),
                            ),
                            SizedBox(
                              width: 33.w,
                              height: 33.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 33.w,
                                    height: 33.w,
                                    child: CircularProgressIndicator(
                                      value: 48 / 100,
                                      strokeWidth: 4,
                                      backgroundColor: Colors.grey.withValues( alpha:0.2),
                                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2979FF)),
                                    ),
                                  ),
                                  Text(
                                    '48%',
                                    style: TextStyle(
                                      color: Color(0xFF2979FF),
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        16.verticalSpace,
                        Text(
                          course.description,
                          style:  TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 9.sp,
                            color: colors(context).secondaryText,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Image.asset(
                AppAssets.explore,
                width: 15.w,
                height: 15.w,
                color: colors(context).secondaryText,
              ),
              onPressed: () {
              },
            ),
          ),
        ],
      )

    );
  }
}
