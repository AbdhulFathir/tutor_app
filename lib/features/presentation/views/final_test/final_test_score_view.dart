import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/final_test/widgets/test_mini_card.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/common_outlined_button.dart';
import '../modules/widgets/test.dart';
import '../modules/widgets/test_card.dart';
import 'widgets/oval_shape_painter.dart';

class FinalTestScoreView extends StatelessWidget {
  final TestItem testItem;

  const FinalTestScoreView({super.key, required this.testItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFF0A5DC8),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(28.w, 25.h, 28.w, 23.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ML final test',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              'Check how your exams are going',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFBAC8BD).withValues(alpha:.24),
                        ),
                        child: Image.asset(
                          AppAssets.iconBellWhite,
                          width: 24.w,
                          height: 24.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _bodyContent(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyContent(BuildContext context) {
    if (testItem.status == TestStatus.NOT_COMPLETED) {
      // Corresponds to the Upload screen
      return _notCompletedView(context);
    }

    if (testItem.status == TestStatus.COMPLETED) {
      if (testItem.isMarked == true) {
        return _completedView(context);
      } else {
        return _completedPendingView(context);
      }
    }

    return Center(child: Text("Test status error."));
  }

  Widget _completedView(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 362.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomPaint(
                  size: Size(430, 212),
                  painter: OvalShapePainter(color: Color(0xFF93C8FF)),
                ),
              ),
              Container(
                height: 269.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [Color(0xFF0060DB), Color(0xFF93C8FF)],
                  ),
                ),
              ),
              Positioned(
                top: 72.h,
                left: 153.w,
                child: Container(
                  height: 124,
                  width: 124,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFDBEEE4).withAlpha(27),
                  ),
                ),
              ),
              Positioned(
                top: 60.h,
                left: 154.w,
                child: Image.asset(AppAssets.trophyIcon),
              ),
              // Positioned(
              //     top: 210.h,
              //     left:192.5.w,
              //     child: Text("100%",
              //       style: TextStyle(
              //         fontSize: 32.sp,
              //         fontWeight: FontWeight.w300,
              //         color: Colors.white,
              //       ),
              //       )
              // ),
              // Positioned(
              //     top: 258.h,
              //     left:156.w,
              //     child: Text("Great Job!",
              //       style: TextStyle(
              //         fontSize: 32.sp,
              //         fontWeight: FontWeight.w600,
              //         color: Color(0xFF0060DB),
              //       ),
              //       )
              // ),
              Align(
                alignment: Alignment(0, 0.35),
                child: Text(
                  // testItem.score ?? "",
                  "100%",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),

              Align(
                alignment: Alignment(0, 0.65),
                child: Text(
                  "Great Job!",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0060DB),
                  ),
                ),
              ),
            ],
          ),
        ),
        17.verticalSpace,
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TestCard(item: testItem ,hasIcon: false,),
                10.verticalSpace,
                Row(
                  children: [
                    TestMiniCard(
                      image: AppAssets.iconMortarboardGold,
                      title:  testItem.score??"",
                      subtitle: 'Your score',
                    ),
                    6.horizontalSpace,
                    TestMiniCard(
                      image: AppAssets.iconChartFill,
                      title: testItem.gradeText??"",
                      subtitle: 'Your position',
                    ),
                  ],
                ),
                6.verticalSpace,
                Row(
                  children: [
                    TestMiniCard(
                      image: AppAssets.iconMortarboardGold,
                      title: testItem.correctAnswers.toString(),
                      subtitle: 'Correct answers',
                    ),
                    6.horizontalSpace,
                    TestMiniCard(
                      image: AppAssets.iconMortarboardGold,
                      title: (
                          (testItem.totalQuestions ?? 0) - (testItem.correctAnswers ?? 0)
                      ).toString(),
                      subtitle: 'Wrong Answers',
                    ),
                  ],
                ),
                6.verticalSpace,
                Row(
                  children: [
                    TestMiniCard(
                      image: AppAssets.iconMortarboardGold,
                      title: testItem.totalQuestions.toString(),
                      subtitle: 'Total questions',
                    ),
                    6.horizontalSpace,
                    TestMiniCard(
                      image: AppAssets.iconCalenderBlue,
                      title: testItem.date??"",
                      subtitle: 'Submitted Date',
                    ),
                  ],
                ),
                29.verticalSpace,
                Text(
                  "Tutors Comment",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: colors(context).text
                  ),
                ),
                27.verticalSpace,
                Text(
                  testItem.tutorComment ?? "No comment available.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:colors(context).secondaryText,
                    height: 1.5,
                  ),
                ),
                27.verticalSpace,
                CommonOutlinedButton(
                  buttonFillType: ButtonFillType.filled,
                  text: "View My Answers",
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.kFinalTestUploadView);
                  },
                ),
                80.verticalSpace
              ]),
        ),
      ],
    );
  }

  Widget _completedPendingView(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          30.verticalSpace,
          TestCard(item: testItem, hasIcon: false), // Mini card at the top
          29.verticalSpace,
          Container(
            width: 321.w,
            height: 359.h,
            decoration: BoxDecoration(
              color: colors(context).text.withValues(alpha: 0.10),
              borderRadius: BorderRadius.all(Radius.circular(20.r))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 57.w,
                  width: 57.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      color: colors(context).text .withValues(alpha: 0.09)
                  ),
                  child: Image.asset(
                    AppAssets.iconSearchFill,
                    height: 24.w,
                    width: 24.w,
                    color: colors(context).text,
                  ),
                ),
                24.verticalSpace,
                Text(
                  "Sorry",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: colors(context).text
                  ),
                ),
                10.verticalSpace,
                Text(
                  "Results are not released yet!",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: colors(context).secondaryText
                  ),
                ),
              ],
            ),
          ),
          34.verticalSpace,
          CommonOutlinedButton(
            buttonFillType: ButtonFillType.filled,
            buttonType: ButtonType.DISABLED,
            text: "View My Answers",
            onPressed: () {
              Navigator.pushNamed(context, Routes.kFinalTestUploadView);
            },
          ),
          80.verticalSpace,
        ],
      ),
    );
  }


  Widget _notCompletedView(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          33.verticalSpace,
          TestCard(item: testItem, hasIcon: false), // Mini card at the top
          29.verticalSpace,
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(20),
              color: Colors.grey.shade400,
              strokeWidth: 1,
              dashPattern: [6, 4],
              padding: EdgeInsets.zero
            ),
            child: Container(
              width: 321.w,
              height: 359.h,
              decoration: BoxDecoration(
                  color: colors(context).text.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.all(Radius.circular(20.r))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 57.w,
                    width: 57.w,
                    decoration: BoxDecoration(
                      color: colors(context).secondarySurface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colors(context).text.withValues(alpha:0.25),
                          blurRadius: 8,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    // child: Icon(
                    //     MagicoonRegular.starMagic,
                    //     size: 24.w,
                    //     color: Colors.black.withValues(alpha: 0.69)
                    // ),
                    child: Image.asset(
                      AppAssets.iconUploadFileFill,
                      height: 24.w,
                      width: 24.w,
                      color: colors(context).text,
                    ),
                  ),
                  24.verticalSpace,
                  Text(
                    "Upload",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: colors(context).text,
                    ),
                  ),
                  10.verticalSpace,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Click here",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xFF0A5DC8),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        TextSpan(
                          text: " to upload file or drag.",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Supported Format: SVG, JPG,\n PNG",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),

                ],
              ),
            ),
          ),
          18.verticalSpace,
          Padding(
            padding: EdgeInsets.only(right: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  AppAssets.iconCameraFill,
                  height: 31.w,
                  width: 31.w,
                ),
                15.horizontalSpace,
                Image.asset(
                  AppAssets.iconFolderOpenFill,
                  height: 31.w,
                  width: 31.w,
                )
              ],
            ),
          ),
          40.verticalSpace,
          Column(
            children: [
              CommonOutlinedButton(
                buttonFillType: ButtonFillType.outlined,
                text: "Open a MCQ Sheet",
                onPressed: () {
                  // Navigate to the MCQ sheet view
                },
              ),
              10.verticalSpace,
              CommonOutlinedButton(
                buttonType: ButtonType.DISABLED,
                buttonFillType: ButtonFillType.filled,
                text: "Submit My Answers",
                onPressed: () {
                  // Submission logic
                },
              ),
            ],
          ),
          80.verticalSpace
        ],
      ),
    );
  }
}
