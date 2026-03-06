import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/app_search_box.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/group_dropdown.dart';

class ManageStudentsView extends ConsumerStatefulWidget {
  const ManageStudentsView({super.key});

  @override
  ConsumerState<ManageStudentsView> createState() => _ManageStudentsViewState();
}

class _ManageStudentsViewState extends ConsumerState<ManageStudentsView> {
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
      appBar: CommonAppBar(
        title: 'View Students',
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_rounded),
            onPressed: () {
              Navigator.pushNamed(context, Routes.kTutorAddStudentView);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              AppSearchBox(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _query = value.trim();
                  });
                },
              ),
              12.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Filter by group',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              6.verticalSpace,
              GroupDropdown(
                selectedGroup: _selectedGroup,
                showAllOption: true,
                onChanged: (value) {
                  setState(() {
                    _selectedGroup = value;
                  });
                },
              ),
              20.verticalSpace,
              _buildHeaderRow(context),
              8.verticalSpace,
              Expanded(
                child: StreamBuilder<
                    QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .orderBy('first_name')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Failed to load students.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    final docs = snapshot.data?.docs ?? [];

                    final items = docs.map((doc) {
                      final data = doc.data();
                      return _StudentListItem(
                        docId: doc.id,
                        fullName:
                            '${data['first_name'] ?? ''} ${data['last_name'] ?? ''}'
                                .trim(),
                        indexNo: (data['id'] ?? '').toString(),
                        group: (data['group'] ?? '').toString(),
                        phone: (data['phone_number'] ?? '').toString(),
                        email: (data['email'] ?? '').toString(),
                        uid: (data['uid'] ?? '').toString(),
                        joinedDate:
                            (data['joined_date'] ?? '').toString(),
                      );
                    }).where((item) {
                      final matchesQuery = () {
                        if (_query.isEmpty) return true;
                        final q = _query.toLowerCase();
                        return item.fullName
                                .toLowerCase()
                                .contains(q) ||
                            item.indexNo
                                .toLowerCase()
                                .contains(q) ||
                            item.group
                                .toLowerCase()
                                .contains(q);
                      }();

                      final matchesGroupFilter =
                          _selectedGroup == null ||
                              item.group == _selectedGroup;

                      return matchesQuery && matchesGroupFilter;
                    }).toList();

                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          'No students yet. Tap the + icon to add.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => 8.verticalSpace,
                      itemBuilder: (context, index) {
                        final student = items[index];
                        return _buildStudentRow(context, student);
                      },
                    );
                  },
                ),
              ),
              16.verticalSpace,
              CommonButton(
                text: 'Add Student',
                onPressed: () {
                  Navigator.pushNamed(context, Routes.kTutorAddStudentView);
                },
              ),
              8.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    final labelStyle = TextStyle(
      color: colors(context).secondaryText,
      fontSize: 11.sp,
      fontWeight: FontWeight.w500,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors(context).secondarySurfaceBorder),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3, child: Text('Name', style: labelStyle)),
          Expanded(
              flex: 2, child: Text('Index No', style: labelStyle)),
          Expanded(
              flex: 2, child: Text('Group', style: labelStyle)),
          Expanded(
            flex: 2,
            child: Text(
              'Action',
              style: labelStyle,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentRow(
      BuildContext context, _StudentListItem student) {
    final textStyle = TextStyle(
      color: colors(context).text,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colors(context).secondarySurfaceBorder),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(student.fullName, style: textStyle)),
          Expanded(
              flex: 2,
              child: Text(student.indexNo, style: textStyle)),
          Expanded(
            flex: 2,
            child: Text(
              student.group.isEmpty ? '-' : student.group,
              style: textStyle,
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _showStudentDetails(context, student);
                },
                child: const Text('View'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showStudentDetails(
      BuildContext context, _StudentListItem student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors(context).surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Student Details',
                    style: TextStyle(
                      color: colors(context).text,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              8.verticalSpace,
              _detailRow(context, 'Name', student.fullName),
              _detailRow(context, 'Index No', student.indexNo),
              _detailRow(context, 'Group', student.group),
              _detailRow(context, 'Phone', student.phone),
              _detailRow(context, 'Email', student.email),
              _detailRow(
                context,
                'Joined',
                AppUtils.getDate(student.joinedDate),
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      text: 'Edit',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          Routes.kTutorEditStudentView,
                          arguments: student.docId,
                        );
                      },
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: colors(context).secondarySurfaceBorder,
                        ),
                      ),
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              label,
              style: TextStyle(
                color: colors(context).secondaryText,
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: colors(context).text,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class _StudentListItem {
  final String docId;
  final String fullName;
  final String indexNo;
  final String group;
  final String phone;
  final String email;
  final String uid;
  final String joinedDate;

  _StudentListItem({
    required this.docId,
    required this.fullName,
    required this.indexNo,
    required this.group,
    required this.phone,
    required this.email,
    required this.uid,
    required this.joinedDate,
  });
}


