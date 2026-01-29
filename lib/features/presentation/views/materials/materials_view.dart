import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/materials/widgets/lesson_card.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/enums.dart';
import '../../widgets/app_search_box.dart';
import '../../widgets/common_app_bar.dart';
import '../home/widgets/course.dart';
import 'material_carousel.dart';
import 'widgets/material_card.dart';

class MaterialsView extends StatefulWidget {
  const MaterialsView({super.key});

  @override
  State<MaterialsView> createState() => _MaterialsViewState();
}

class _MaterialsViewState extends State<MaterialsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentPage = 0; // State for the current page indicator

  // 1. Define the list of courses for the carousel
  final List<Course> materialList = [
    Course(
      title: "Machine Learning",
      description:
      "Machine learning helps computers learn from data and make decisions.",
      // Using AppAssets.machineLearning locally as the MaterialCard is using it
      // Replace with your actual asset path if different
      imageUrl: AppAssets.machineLearning,
    ),
    Course(
      title: "AI (Artificial Intelligence)",
      description:
      "AI (Artificial Intelligence) is when machines are made to act smart like humans.",
      // Using the same asset for demonstration, replace with a different one if needed
      imageUrl: AppAssets.machineLearning,
    ),
    // Add more courses here
  ];

  List<Course> courseList = [
    Course(
      title: 'Supervised learning',
      description:
          'Explore unsupervised learning techniques and clustering methods.',
      courseStatus: CourseStatus.COMPLETED,
    ),
    Course(
      title: 'Unsupervised learning',
      description:
          'Explore unsupervised learning techniques and clustering methods.',
      courseStatus: CourseStatus.NEW,
    ),
    Course(
      title: 'Reinforcement learning',
      description:
          'Understand reinforcement learning and reward-based systems.',
    ),
  ];
  List<Course> filteredCourseList = [];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    filteredCourseList = courseList;
    _tabController.addListener(handleTabSelection);
    super.initState();
  }

  void handleTabSelection() {
    if (_tabController.indexIsChanging) return;
    final int index = _tabController.index;
    List<Course> newFilteredList = [];

    if (index == 0) {
      newFilteredList = courseList;
    } else if (index == 1) {
      newFilteredList =
          courseList
              .where((course) => course.courseStatus == CourseStatus.NEW)
              .toList();
    } else if (index == 2) {
      newFilteredList =
          courseList
              .where((course) => course.courseStatus == CourseStatus.COMPLETED)
              .toList();
    }
    setState(() {
      filteredCourseList = newFilteredList;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(handleTabSelection); // Clean up listener
    _tabController.dispose();
    super.dispose();
  }

  // Helper method to build the dot indicators
  Widget _buildPageIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: 6.w,
      height: 6.w,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF2979FF) : Colors.grey.withAlpha(80),
        borderRadius: BorderRadius.circular(3.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(title: 'Materials', showNotificationIcon: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(children: [
                  AppSearchBox(
                    controller: searchController,
                    onChanged: (value) {
                      print('Search value: $value');
                    },
                  ),
                  24.verticalSpace,
                ]),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     MaterialCard(
              //       course: Course(
              //         title: "Machine Learning",
              //         description:
              //         "Machine learning helps computers learn from data and make decisions.",
              //         imageUrl:
              //         "https://www.trentonsystems.com/hs-fs/hubfs/Machine_Learning%20.jpeg?width=8082&name=Machine_Learning%20.jpeg",
              //       ),
              //     ),
              //     31.verticalSpace,
              //   ],
              // ),
              MaterialCarousel(
                courses: [
                  Course(
                    title: "Machine Learning",
                    description:
                    "Machine learning helps computers learn from data and make decisions.",
                  ),
                  Course(
                    title: "AI",
                    description:
                    "AI allows machines to act smart like humans.",
                  ),
                ],
              ),
              31.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose your lesson',
                        style: TextStyle(
                          color:colors(context).text,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      21.verticalSpace,
                      TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          border: Border.all(color: colors(context).text.withAlpha(40)),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelColor: colors(context).text,
                        unselectedLabelColor: colors(context).text.withAlpha(40),
                        tabs: [
                          Tab(height: 28.h, text: 'All'),
                          Tab(height: 28.h, text: 'New'),
                          Tab(height: 28.h, text: 'Completed'),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Column(
                        children:
                        filteredCourseList.map((course) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            // Add spacing after each card
                            child: LessonCard(course: course),
                          );
                        }).toList(),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
