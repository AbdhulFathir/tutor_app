import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import 'course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 287.w,
          height: 122.h,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage(AppAssets.machineLearning)),
            color: Colors.black12,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 287.w,
          child:Padding(
            padding:EdgeInsets.fromLTRB(5.w, 8.h, 5.w, 0),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style:  TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: colors(context).text
                        )
                      ),
                      4.verticalSpace,
                      Text(
                        course.description,
                        style: TextStyle(
                          fontSize: 9.0,
                          color: colors(context).secondaryText
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                14.horizontalSpace,
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2979FF), // Blue background
                    foregroundColor: Colors.white,
                    fixedSize: Size(80.w, 25.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding:  EdgeInsets.symmetric(horizontal: 11.w, vertical: 4.5.h),
                  ),
                  child:  Text(
                    'Get Started',
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}