import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../../tutor/models/class_group.dart';
import '../../../../tutor/state/tutor_state.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/app_dialog.dart';

class ManageClassGroupsView extends ConsumerWidget {
  const ManageClassGroupsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(tutorStoreProvider);

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Class Groups'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGroupSheet(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ListView.separated(
            itemCount: store.classGroups.length,
            separatorBuilder: (_, __) => 10.verticalSpace,
            itemBuilder: (context, index) {
              final group = store.classGroups[index];
              final count = store.students
                  .where((s) => s.classGroupId == group.id)
                  .length;
              return _GroupCard(group: group, studentCount: count);
            },
          ),
        ),
      ),
    );
  }

  void _showAddGroupSheet(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
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
            children: [
              Text(
                'Add New Class Group',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              18.verticalSpace,
              CommonTextField(
                controller: controller,
                labelText: 'Class group name',
                hintText: 'e.g. Web Dev 2025',
              ),
              24.verticalSpace,
              CommonButton(
                text: 'Add',
                onPressed: () {
                  final name = controller.text.trim();
                  if (name.isEmpty) return;
                  ref.read(tutorStoreProvider.notifier).addClassGroup(name);
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      title: 'Success',
                      description: 'Class group added successfully.',
                      alertType: AlertType.SUCCESS,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GroupCard extends ConsumerWidget {
  final ClassGroup group;
  final int studentCount;

  const _GroupCard({
    required this.group,
    required this.studentCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  group.name,
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '$studentCount students',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showManageSheet(context, ref),
            child: const Text('Manage'),
          ),
        ],
      ),
    );
  }

  void _showManageSheet(BuildContext context, WidgetRef ref) {
    final store = ref.read(tutorStoreProvider);
    final students =
        store.students.where((s) => s.classGroupId == group.id).toList();

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
            bottom: 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    group.name,
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
              if (students.isEmpty)
                Text(
                  'No students assigned yet.',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 12.sp,
                  ),
                )
              else
                ...students.map(
                  (s) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      s.fullName,
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 13.sp,
                      ),
                    ),
                    subtitle: Text(
                      'Grade ${s.grade}',
                      style: TextStyle(
                        color: colors(context).secondaryText,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ),
              16.verticalSpace,
              CommonButton(
                text: 'Delete Group',
                backgroundColor: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  _confirmDeleteGroup(context, ref);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteGroup(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Delete Group',
        description:
            'Are you sure you want to delete "${group.name}"? Students will be unassigned from this group.',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () {
          ref.read(tutorStoreProvider.notifier).deleteClassGroup(group.id);
        },
      ),
    );
  }
}

