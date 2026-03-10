import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../tutor/models/firestore_test.dart';
import '../../../../tutor/models/test_submission.dart';
import '../../../widgets/app_search_box.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/group_dropdown.dart';

class TutorResultsView extends StatefulWidget {
  const TutorResultsView({super.key});

  @override
  State<TutorResultsView> createState() => _TutorResultsViewState();
}

class _TutorResultsViewState extends State<TutorResultsView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String? _selectedGroup;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Results'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Check tests and student marks',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              12.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    size: 18.w,
                    color: colors(context).secondaryText,
                  ),
                  6.horizontalSpace,
                  Text(
                    'Filter by',
                    style: TextStyle(
                      color: colors(context).secondaryText,
                      fontSize: 12.sp,
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: GroupDropdown(
                      selectedGroup: _selectedGroup,
                      showAllOption: true,
                      onChanged: (value) {
                        setState(() => _selectedGroup = value);
                      },
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              AppSearchBox(
                controller: _searchController,
                onChanged: (value) {
                  setState(() => _query = value.trim().toLowerCase());
                },
              ),
              16.verticalSpace,
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream:
                      FirebaseFirestore.instance.collection('tests').snapshots(),
                  builder: (context, testsSnapshot) {
                    if (testsSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (testsSnapshot.hasError) {
                      return Center(
                        child: Text(
                          'Failed to load tests.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    final testDocs = testsSnapshot.data?.docs ?? [];
                    if (testDocs.isEmpty) {
                      return Center(
                        child: Text(
                          'No tests found. Upload tests first.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final tests = testDocs
                        .map(FirestoreTest.fromDoc)
                        .where((t) {
                          final matchGroup = _selectedGroup == null ||
                              t.group == _selectedGroup;
                          final matchSearch = _query.isEmpty ||
                              t.title.toLowerCase().contains(_query) ||
                              t.description.toLowerCase().contains(_query);
                          return matchGroup && matchSearch;
                        })
                        .toList()
                      ..sort((a, b) {
                        final aDate =
                            a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                        final bDate =
                            b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                        return bDate.compareTo(aDate);
                      });

                    if (tests.isEmpty) {
                      return Center(
                        child: Text(
                          'No tests match your filters.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('submision')
                          .snapshots(),
                      builder: (context, submissionsSnapshot) {
                        if (submissionsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (submissionsSnapshot.hasError) {
                          return Center(
                            child: Text(
                              'Failed to load submissions.',
                              style: TextStyle(
                                color: colors(context).secondaryText,
                                fontSize: 13.sp,
                              ),
                            ),
                          );
                        }

                        final submissionsByTest =
                            <String, List<TestSubmission>>{};
                        for (final doc
                            in submissionsSnapshot.data?.docs ?? <QueryDocumentSnapshot<Map<String, dynamic>>>[]) {
                          final submission = TestSubmission.fromDoc(doc);
                          submissionsByTest
                              .putIfAbsent(submission.testId, () => [])
                              .add(submission);
                        }

                        return ListView.separated(
                          itemCount: tests.length,
                          separatorBuilder: (_, __) => 10.verticalSpace,
                          itemBuilder: (context, index) {
                            final test = tests[index];
                            final submissions =
                                submissionsByTest[test.id] ?? const [];
                            final total = submissions.length;
                            final marked = submissions
                                .where((s) => s.isMarked)
                                .length;
                            final pending = total - marked;

                            return _TestResultsCard(
                              test: test,
                              totalSubmissions: total,
                              markedCount: marked,
                              pendingCount: pending,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.kTutorTestSubmissionsView,
                                  arguments: test,
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestResultsCard extends StatelessWidget {
  final FirestoreTest test;
  final int totalSubmissions;
  final int markedCount;
  final int pendingCount;
  final VoidCallback onTap;

  const _TestResultsCard({
    required this.test,
    required this.totalSubmissions,
    required this.markedCount,
    required this.pendingCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateText = test.dueDate != null
        ? AppUtils.getDate(test.dueDate!.toIso8601String())
        : '';

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: colors(context).secondarySurface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: colors(context).secondarySurfaceBorder),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test.title,
                    style: TextStyle(
                      color: colors(context).text,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    '${test.totalQuestions} Questions • ${test.group}',
                    style: TextStyle(
                      color: colors(context).secondaryText,
                      fontSize: 12.sp,
                    ),
                  ),
                  if (dateText.isNotEmpty) ...[
                    2.verticalSpace,
                    Text(
                      'Due: $dateText',
                      style: TextStyle(
                        color: colors(context).secondaryText,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                  8.verticalSpace,
                  Row(
                    children: [
                      _buildChip(
                        context,
                        label: 'Submissions: $totalSubmissions',
                      ),
                      6.horizontalSpace,
                      _buildChip(
                        context,
                        label: 'Marked: $markedCount',
                      ),
                      6.horizontalSpace,
                      _buildChip(
                        context,
                        label: 'Pending: $pendingCount',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors(context).secondaryText,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, {required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurfaceBorder.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors(context).secondaryText,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}

