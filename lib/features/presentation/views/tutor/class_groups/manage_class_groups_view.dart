import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/app_dialog.dart';

class ManageClassGroupsView extends ConsumerWidget {
  const ManageClassGroupsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Class Groups'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGroupSheet(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('groups')
                .orderBy('group')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Failed to load groups.',
                    style: TextStyle(
                      color: colors(context).secondaryText,
                      fontSize: 13.sp,
                    ),
                  ),
                );
              }

              final docs = snapshot.data?.docs ?? [];
              if (docs.isEmpty) {
                return Center(
                  child: Text(
                    'No groups yet. Tap + to add.',
                    style: TextStyle(
                      color: colors(context).secondaryText,
                      fontSize: 13.sp,
                    ),
                  ),
                );
              }

              final groups = docs.map((d) {
                final data = d.data();
                return _GroupItem(
                  id: d.id,
                  name: (data['group'] ?? '').toString(),
                );
              }).toList();

              return ListView.separated(
                itemCount: groups.length,
                separatorBuilder: (_, __) => 10.verticalSpace,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return _GroupCard(group: group);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAddGroupSheet(BuildContext context) {
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
                onPressed: () async {
                  final name = controller.text.trim();
                  if (name.isEmpty) return;

                  await FirebaseFirestore.instance
                      .collection('groups')
                      .add({'group': name});

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

class _GroupCard extends StatelessWidget {
  final _GroupItem group;

  const _GroupCard({
    required this.group,
  });

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
                  group.name,
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  'Tap to view students',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showManageSheet(context),
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }

  void _showManageSheet(BuildContext context) {
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
              SizedBox(
                height: 260.h,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('group', isEqualTo: group.name)
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
                            fontSize: 12.sp,
                          ),
                        ),
                      );
                    }

                    final docs = snapshot.data?.docs ?? [];
                    if (docs.isEmpty) {
                      return Center(
                        child: Text(
                          'No students assigned yet.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 12.sp,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: docs.length,
                      separatorBuilder: (_, __) => 4.verticalSpace,
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        final data = doc.data();
                        final name =
                            '${data['first_name'] ?? ''} ${data['last_name'] ?? ''}'
                                .trim();
                        final regId =
                            (data['id'] ?? '').toString();

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            name,
                            style: TextStyle(
                              color: colors(context).text,
                              fontSize: 13.sp,
                            ),
                          ),
                          subtitle: Text(
                            regId,
                            style: TextStyle(
                              color: colors(context).secondaryText,
                              fontSize: 11.sp,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                _confirmRemoveStudentFromGroup(
                              context,
                              doc.id,
                              name,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              16.verticalSpace,
              CommonButton(
                text: 'Delete Group',
                backgroundColor: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  _confirmDeleteGroup(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteGroup(BuildContext context) {
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
        onPositiveCallback: () async {
          final firestore = FirebaseFirestore.instance;
          final batch = firestore.batch();

          final usersQuery = await firestore
              .collection('users')
              .where('group', isEqualTo: group.name)
              .get();

          for (final doc in usersQuery.docs) {
            batch.update(doc.reference, {'group': ''});
          }

          batch.delete(
            firestore.collection('groups').doc(group.id),
          );

          await batch.commit();
        },
      ),
    );
  }

  void _confirmRemoveStudentFromGroup(
    BuildContext context,
    String userDocId,
    String studentName,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Remove from Group',
        description:
            'Remove $studentName from "${group.name}"?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Remove',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userDocId)
              .update({'group': ''});
        },
      ),
    );
  }
}

class _GroupItem {
  final String id;
  final String name;

  _GroupItem({
    required this.id,
    required this.name,
  });
}

