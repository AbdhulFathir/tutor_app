import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../home/widgets/course.dart';

class LessonCard extends StatelessWidget {
  final Course course;

  const LessonCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.fromLTRB(9.w, 8.h, 9.w, 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 135.w,
              height: 135.w,
              decoration: BoxDecoration(
                // image:DecorationImage(image: AssetImage(AppAssets.machineLearning),fit: BoxFit.fill),
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15.0),
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
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color:colors(context).text
                      ),
                    ),
                    16.verticalSpace,
                    Text(
                      course.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9.sp,
                        color: colors(context).secondaryText
                      ),
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.kLessonsView);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2979FF),
                            foregroundColor: Colors.white,
                            fixedSize: Size(66.w, 22.h),
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            'View',
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
