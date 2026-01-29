import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';

class LessonsView extends StatelessWidget {
  const LessonsView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(
        title: 'Lessons',
        showNotificationIcon: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured Lesson Image
              Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                  color: colors(context).surface.withOpacity(0.1),
                ),
                child: Center(
                  child: Image.asset(
                    AppAssets.appLogo,
                    height: 100.h,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supervised Learning',
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Supervised learning is a machine learning approach where algorithms learn from labeled training data. The model makes predictions or decisions based on input-output pairs, learning to map inputs to correct outputs through examples.',
                      style: TextStyle(
                        color: colors(context).text.withValues( alpha: 0.8),
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'Related Lessons',
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildLessonCard(
                      context: context,
                      title: 'Supervised learning',
                      description: 'Learn about supervised learning algorithms and their applications.',
                      textColor: colors(context).text,
                      cardColor: colors(context).secondarySurface,
                    ),
                    SizedBox(height: 16.h),
                    _buildLessonCard(
                      context: context,
                      title: 'Unsupervised learning',
                      description: 'Explore unsupervised learning techniques and clustering methods.',
                      textColor: colors(context).text,
                      cardColor: colors(context).secondarySurface,
                    ),
                    SizedBox(height: 16.h),
                    _buildLessonCard(
                      context: context,
                      title: 'Reinforcement learning',
                      description: 'Understand reinforcement learning and reward-based systems.',
                      textColor: colors(context).text,
                      cardColor: colors(context).secondarySurface,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonCard({
    required BuildContext context,
    required String title,
    required String description,
    required Color textColor,
    required Color cardColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colors(context).secondarySurfaceShadow
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFF2979FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Image.asset(
                AppAssets.appLogo,
                height: 40.h,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 12.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          CommonButton(
            text: 'View',
            onPressed: () {
              if (title.toLowerCase() == 'supervised learning') {
                Navigator.pushNamed(context, Routes.kSupervisedLearningPdfView);
              } else {
                // Handle other lesson views here
                Navigator.pushNamed(context, Routes.kLessonsView);
              }
            },
            isFullWidth: false,
            backgroundColor: const Color(0xFF2979FF),
          ),
        ],
      ),
    );
  }
}

