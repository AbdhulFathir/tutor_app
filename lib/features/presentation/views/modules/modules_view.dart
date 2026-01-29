import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/modules/widgets/test.dart';
import 'package:tutor_app/features/presentation/views/modules/widgets/test_card.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/app_search_box.dart';
import '../../widgets/common_app_bar.dart';

class ModulesView extends StatefulWidget {
  const ModulesView({super.key});

  @override
  State<ModulesView> createState() => _ModulesViewState();
}

class _ModulesViewState extends State<ModulesView> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  List<TestItem> allTests = [
    // 1. Completed & Marked (Score 85%)
    TestItem(
      id: '1',
      title: 'ML final test',
      description: 'ML final tesML final tetML final test...',
      status: TestStatus.COMPLETED,
      icon: Icons.question_mark,
      isMarked: true, // <-- SET TO TRUE
      score: '85%',
      totalQuestions: 15,
      correctAnswers: 13,
      incorrectAnswers: 2,
      gradeText: 'Good',
      date: '09/24/2025',
      tutorComment:
      'ML final test ML final tesML final tetML final test COMPLETED ML final test ML final tesML final tetML final test COMPLETED ML final test...',
    ),

    // 2. Completed & Pending (Not Marked - Should show "Sorry" screen)
    TestItem(
      id: '6',
      title: 'Data Science Midterm',
      description: 'Awaiting review by the course instructor.',
      status: TestStatus.COMPLETED,
      icon: Icons.question_mark,
      isMarked: false, // <-- SET TO FALSE
      score: null, // Null since results aren't out
      totalQuestions: 30,
      correctAnswers: null,
      incorrectAnswers: null,
      gradeText: null,
      date: '12/03/2025',
      tutorComment: null,
    ),

    // 3. Completed & Marked (Score 92%)
    TestItem(
      id: '2',
      title: 'ML mid test',
      description: 'ML final tesML final tetML final test...',
      status: TestStatus.COMPLETED,
      icon: Icons.question_mark,
      isMarked: true, // <-- SET TO TRUE
      score: '92%',
      totalQuestions: 13,
      correctAnswers: 12,
      incorrectAnswers: 1,
      gradeText: 'Excellent',
      date: '10/01/2025',
      tutorComment: 'Excellent performance on module 3 concepts.',
    ),

    // 4. Not Completed (Should show "Upload" screen)
    TestItem(
      id: '3',
      title: 'AI morning test',
      description: 'AI morning test AI morning test...',
      status: TestStatus.NOT_COMPLETED,
      icon: Icons.question_mark,
      isMarked: false, // <-- N/A, but keeping consistent
      score: null,
      totalQuestions: 20,
      correctAnswers: null,
      incorrectAnswers: null,
      gradeText: null,
      date: '10/10/2025',
      tutorComment: null,
    ),

    // 5. Completed & Marked (Score 78%)
    TestItem(
      id: '4',
      title: 'ML mid test',
      description: 'ML final tesML final tetML final test...',
      status: TestStatus.COMPLETED,
      icon: Icons.question_mark,
      isMarked: true, // <-- SET TO TRUE
      score: '78%',
      totalQuestions: 10,
      correctAnswers: 8,
      incorrectAnswers: 2,
      gradeText: 'Average',
      date: '10/15/2025',
      tutorComment: 'Solid attempt, review chapters 1 and 2.',
    ),

    // 6. Not Completed (Should show "Upload" screen)
    TestItem(
      id: '5',
      title: 'Deep Learning Quiz',
      description: 'Module 5 review quiz on CNNs.',
      status: TestStatus.NOT_COMPLETED,
      icon: Icons.question_mark,
      isMarked: false, // <-- N/A, but keeping consistent
      score: null,
      totalQuestions: 5,
      correctAnswers: null,
      incorrectAnswers: null,
      gradeText: null,
      date: '10/20/2025',
      tutorComment: null,
    ),

    // 7. Completed & Pending (Not Marked - Should show "Sorry" screen)
    TestItem(
      id: '7',
      title: 'Algorithms Final',
      description: 'Complex problem-solving assessment.',
      status: TestStatus.COMPLETED,
      icon: Icons.question_mark,
      isMarked: false, // <-- SET TO FALSE
      score: null,
      totalQuestions: 40,
      correctAnswers: null,
      incorrectAnswers: null,
      gradeText: null,
      date: '12/04/2025',
      tutorComment: null,
    ),
  ];
  List<TestItem> filteredTestList = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    filteredTestList = allTests;
    _tabController.addListener(handleTabSelection);
    super.initState();
  }

  void handleTabSelection() {
    if (_tabController.indexIsChanging) return;
    final int index = _tabController.index;
    List<TestItem> newFilteredList = [];

    if (index == 0) {
      newFilteredList = allTests;
    } else if (index == 1) {
      newFilteredList = allTests
          .where((test) => test.status == TestStatus.COMPLETED)
          .toList();
    } else if (index == 2) {
      newFilteredList = allTests
          .where((test) => test.status == TestStatus.NOT_COMPLETED)
          .toList();
    }
    setState(() {
      filteredTestList = newFilteredList;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(handleTabSelection); // Clean up listener
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(title: 'Modules', showNotificationIcon: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                28.verticalSpace,
                Text(
                  'Module',
                  style: TextStyle(fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: colors(context).text,
                  ),
                ),
                5.verticalSpace,
                Text(
                  'Check how your exams are going',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color:colors(context).secondaryText,
                  ),
                ),
                17.verticalSpace,
                AppSearchBox(
                  controller: searchController,
                  onChanged: (value) {
                    print('Search value: $value');
                  },
                ),
                34.verticalSpace,
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    border: Border.all(color: colors(context).text.withAlpha(40)),
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),
                  labelColor: colors(context).text,
                  unselectedLabelColor:colors(context).secondaryText,
                  tabs: [
                    Tab(
                      height: 28.h,
                      text: 'All',
                    ),
                    Tab(
                      height: 28.h,
                      text: 'Completed',
                    ),
                    Tab(
                      height: 28.h,
                      text: 'Not Completed',
                    ),
                  ],
                ),
                29.verticalSpace,
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: allTests.length,
                //     itemBuilder: (context, index) {
                //       final module = allTests[index];
                //       return InkWell(
                //         onTap: () {
                //           Navigator.pushNamed(
                //             context,
                //             Routes.kFinalTestScoreView,
                //           );
                //         },
                //         child: TestCard(item: module),
                //       );
                //     },
                //   ),
                // ),
                Column(
                  children:
                  filteredTestList.map((item) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.kFinalTestScoreView,
                          arguments: item,
                        );
                      },
                      child: TestCard(item: item),
                    );
                  }).toList(),
                ),
                // ListView.builder(
                //   padding: EdgeInsets.zero,
                //   itemCount: filteredTestList.length,
                //   itemBuilder: (context, index) {
                //     final item = filteredTestList[index];
                //     return InkWell(
                //       onTap: () {
                //         Navigator.pushNamed(context, Routes.kFinalTestScoreView,
                //           arguments: item,
                //         );
                //       },
                //       child: TestCard(item: item),
                //     );
                //   },
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
