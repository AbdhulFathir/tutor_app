import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/home/widgets/course.dart';
import 'package:tutor_app/features/presentation/views/home/widgets/course_casousal.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/app_search_box.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final cardColor = isDark ? const Color(0xFF222222) : Colors.white;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              17.verticalSpace,
              Padding(
                padding:  EdgeInsets.symmetric( horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.kProfileView);
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue, // Blue circle border
                                    width: 2.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child:
                                  // Image.network(
                                  //   'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2Fgirl-dp--721279696594521302%2F&psig=AOvVaw04ntqFAreXo5uL97GLCL8V&ust=1764261972339000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCODzqZaikJEDFQAAAAAdAAAAABAV', // Replace with your actual image URL or Asset path
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Image.asset(AppAssets.profilePicture),
                                ),
                              ),
                              12.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Back',
                                    style: TextStyle(
                                      color: colors(context).text,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    'Hello, Senuri',
                                    style: TextStyle(
                                      color:  colors(context).text,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.kScanView);
                          },
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF2979FF).withValues( alpha:0.1),
                            ),
                            child: Image.asset(
                              AppAssets.iconNotificationBell,
                              width: 24.w,
                              height: 24.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    31.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'What do you want to learn today?',
                          style: TextStyle(
                            color: colors(context).text,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Image.asset(AppAssets.thinkingBoy, height: 35.h),
                      ],
                    ),
                    22.verticalSpace,
                    AppSearchBox(
                      controller: searchController,
                      onChanged: (value) {
                        print('Search value: $value');
                      },
                    ),
                    32.verticalSpace,
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      30.horizontalSpace,
                      Text(
                        'My Course',
                        style: TextStyle(
                          color:  colors(context).text,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.kMaterialsView);
                        },
                        child: Text(
                          'Explore all',
                          style: TextStyle(
                            color: const Color(0xFF2979FF),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      30.horizontalSpace,
                    ],
                  ),
                  // SizedBox(height: 16.h),
                  // SizedBox(
                  //   height: 200.h,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       _buildCourseCard(
                  //         context: context,
                  //         title: 'Machine learning',
                  //         textColor: textColor,
                  //         cardColor: cardColor,
                  //         buttonText: 'Get Started',
                  //       ),
                  //       SizedBox(width: 16.w),
                  //       _buildCourseCard(
                  //         context: context,
                  //         title: 'AI',
                  //         textColor: textColor,
                  //         cardColor: cardColor,
                  //         buttonText: 'Continue',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 32.h),
                  // CourseCard(
                  //   course: Course(
                  //     title: "Machine Learning",
                  //     description:
                  //     "Machine learning helps computers learn from data and make decisions.Machine learning helps computers learn from data and make decisions.",
                  //     imageUrl:
                  //     "https://www.trentonsystems.com/hs-fs/hubfs/Machine_Learning%20.jpeg?width=8082&name=Machine_Learning%20.jpeg",
                  //   ),
                  // ),

                  CoursesCarousel(
                    courses: [
                      Course(
                        title: "Machine Learning",
                        description:
                        "Machine learning helps computers learn from data and make decisions.Machine learning helps computers learn from data and make decisions.",
                        imageUrl:
                        "https://www.trentonsystems.com/hs-fs/.../Machine_Learning.jpeg",
                      ),
                      Course(
                        title: "AI",
                        description:
                        "AI (Artificial Intelligence) is when machines are made to act smart...",
                        imageUrl:
                        "https://images.pexels.com/photos/5999862/ai_photo.jpeg",
                      ),
                      Course(
                        title: "Machine Learning",
                        description:
                        "Machine learning helps computers learn from data and make decisions.Machine learning helps computers learn from data and make decisions.",
                        imageUrl:
                        "https://www.trentonsystems.com/hs-fs/.../Machine_Learning.jpeg",
                      ),
                      Course(
                        title: "AI",
                        description:
                        "AI (Artificial Intelligence) is when machines are made to act smart...",
                        imageUrl:
                        "https://images.pexels.com/photos/5999862/ai_photo.jpeg",
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                ],
              ),
              Padding(
                padding:  EdgeInsets.symmetric( horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Learning Progress Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Learning Progress',
                          style: TextStyle(
                            color: colors(context).text,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.kModulesView);
                          },
                          child: Text(
                            'Explore all',
                            style: TextStyle(
                              color: const Color(0xFF2979FF),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildProgressCard(
                      context: context,
                      title: 'Machine Learning',
                      completed: 5,
                      total: 10,
                      textColor: textColor,
                      cardColor: cardColor,
                    ),
                    SizedBox(height: 12.h),
                    _buildProgressCard(
                      context: context,
                      title: 'Cyber Security',
                      completed: 3,
                      total: 10,
                      textColor: textColor,
                      cardColor: cardColor,
                    ),
                    SizedBox(height: 32.h),
                    // Assessment results Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Assessment results',
                          style: TextStyle(
                            color: colors(context).text,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Explore all',
                            style: TextStyle(
                              color: const Color(0xFF2979FF),
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildAssessmentCard(
                            context: context,
                            title: 'Machine learning',
                            percentage: 75,
                            textColor: textColor,
                            cardColor: cardColor,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildAssessmentCard(
                            context: context,
                            title: 'Cyber Security',
                            percentage: 50,
                            textColor: textColor,
                            cardColor: cardColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildProgressCard({
    required BuildContext context,
    required String title,
    required int completed,
    required int total,
    required Color textColor,
    required Color cardColor,
  }) {
    final progress = completed / total;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color:colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors(context).secondarySurfaceBorder,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$completed/$total',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withValues( alpha:0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2979FF)),
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentCard({
    required BuildContext context,
    required String title,
    required int percentage,
    required Color textColor,
    required Color cardColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color:colors(context).secondarySurfaceBorder ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80.w,
                  height: 80.w,
                  child: CircularProgressIndicator(
                    value: percentage / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.withValues( alpha:0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF2979FF),
                    ),
                  ),
                ),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              color: colors(context).text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
