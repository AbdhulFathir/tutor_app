import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../tutor/models/firestore_test.dart';
import '../../widgets/app_search_box.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/group_dropdown.dart';

class ManageTestsView extends ConsumerStatefulWidget {
  const ManageTestsView({super.key});

  @override
  ConsumerState<ManageTestsView> createState() => _ManageTestsViewState();
}

class _ManageTestsViewState extends ConsumerState<ManageTestsView> {
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
      appBar: const CommonAppBar(title: 'Manage Tests'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCreateNewTestCard(context),
              20.verticalSpace,
              Text(
                'Check Available Test',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.verticalSpace,
              Row(
                children: [
                  Icon(Icons.filter_list, size: 18.w, color: colors(context).secondaryText),
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
                hintText: 'Search here...',
                onChanged: (value) {
                  setState(() => _query = value.trim().toLowerCase());
                },
              ),
              16.verticalSpace,
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('tests')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
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
                    final docs = snapshot.data?.docs ?? [];
                    var tests = docs
                        .map((d) => FirestoreTest.fromDoc(d))
                        .where((t) {
                          final matchGroup = _selectedGroup == null ||
                              t.group == _selectedGroup;
                          final matchSearch = _query.isEmpty ||
                              t.title.toLowerCase().contains(_query) ||
                              t.description.toLowerCase().contains(_query);
                          return matchGroup && matchSearch;
                        })
                        .toList();
                    tests = List.from(tests)
                      ..sort((a, b) {
                        final aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                        final bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                        return bDate.compareTo(aDate);
                      });
                    if (tests.isEmpty) {
                      return Center(
                        child: Text(
                          docs.isEmpty
                              ? 'No tests yet. Create a new test.'
                              : 'No tests match your filter or search.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: tests.length,
                      separatorBuilder: (_, __) => 10.verticalSpace,
                      itemBuilder: (context, index) {
                        final test = tests[index];
                        return _TestCard(test: test);
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

  Widget _buildCreateNewTestCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.kTutorAddTestView);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: colors(context).secondarySurface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colors(context).secondarySurfaceBorder),
        ),
        child: Row(
          children: [
            Text(
              'Create New Test',
              style: TextStyle(
                color: colors(context).text,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Material(
              color: const Color(0xFF2979FF),
              borderRadius: BorderRadius.circular(24.r),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.kTutorAddTestView);
                },
                borderRadius: BorderRadius.circular(24.r),
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Icon(Icons.add, color: Colors.white, size: 24.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TestCard extends StatelessWidget {
  final FirestoreTest test;

  const _TestCard({required this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(10.r),
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
              ],
            ),
          ),
          CommonButton(
            text: 'Manage',
            isFullWidth: false,
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.kTutorEditTestView,
                arguments: test.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
