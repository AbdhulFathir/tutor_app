import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../tutor/models/student.dart';
import '../../../../tutor/state/tutor_state.dart';
import '../../../widgets/app_search_box.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/app_dialog.dart';

class ManageStudentsView extends ConsumerStatefulWidget {
  const ManageStudentsView({super.key});

  @override
  ConsumerState<ManageStudentsView> createState() => _ManageStudentsViewState();
}

class _ManageStudentsViewState extends ConsumerState<ManageStudentsView> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(tutorStoreProvider);
    final students = store.students.where((s) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return s.fullName.toLowerCase().contains(q) ||
          s.username.toLowerCase().contains(q) ||
          s.grade.toLowerCase().contains(q);
    }).toList();

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
              20.verticalSpace,
              _buildHeaderRow(context),
              8.verticalSpace,
              Expanded(
                child: students.isEmpty
                    ? Center(
                        child: Text(
                          'No students yet. Tap the + icon to add.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: students.length,
                        separatorBuilder: (_, __) => 8.verticalSpace,
                        itemBuilder: (context, index) {
                          final student = students[index];
                          return _buildStudentRow(context, student);
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
          Expanded(flex: 3, child: Text('Student Name', style: labelStyle)),
          Expanded(flex: 2, child: Text('Grade', style: labelStyle)),
          Expanded(flex: 2, child: Text('Group', style: labelStyle)),
          Expanded(flex: 2, child: Text('Action', style: labelStyle, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _buildStudentRow(BuildContext context, Student student) {
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
          Expanded(flex: 3, child: Text(student.fullName, style: textStyle)),
          Expanded(flex: 2, child: Text(student.grade, style: textStyle)),
          Expanded(
            flex: 2,
            child: Text(
              student.classGroupId == null ? '-' : 'Group',
              // Group name can be wired from store.classGroups later if needed
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

  void _showStudentDetails(BuildContext context, Student student) {
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
              _detailRow(context, 'Grade', student.grade),
              _detailRow(context, 'Phone', student.phoneNumber),
              _detailRow(context, 'Email', student.email),
              _detailRow(context, 'Username', student.username),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _confirmDelete(student);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: CommonButton(
                      text: 'Done',
                      onPressed: () => Navigator.pop(context),
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

  void _confirmDelete(Student student) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Delete',
        description: 'Are you sure you want to delete ${student.fullName}?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () {
          ref.read(tutorStoreProvider.notifier).deleteStudent(student.id);
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const AppDialog(
              title: 'Success',
              description: 'Student deleted successfully.',
              alertType: AlertType.SUCCESS,
            ),
          );
        },
      ),
    );
  }
}

