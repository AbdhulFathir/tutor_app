import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/app_dialog.dart';

class EditGroupView extends StatefulWidget {
  const EditGroupView({super.key});

  @override
  State<EditGroupView> createState() => _EditGroupViewState();
}

class _EditGroupViewState extends State<EditGroupView> {
  final _nameController = TextEditingController();
  bool _isSaving = false;
  String _groupId = '';
  String _initialName = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _parseArgs() {
    if (_groupId.isNotEmpty) return;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _groupId = (args['id'] ?? '').toString();
      _initialName = (args['name'] ?? '').toString();
      _nameController.text = _initialName;
    }
  }

  Future<void> _save() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;
    if (_groupId.isEmpty) return;
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      final firestore = FirebaseFirestore.instance;

      await firestore.collection('groups').doc(_groupId).update({'group': newName});

      final usersSnapshot = await firestore
          .collection('users')
          .where('group', isEqualTo: _initialName)
          .get();

      for (final doc in usersSnapshot.docs) {
        await doc.reference.update({'group': newName});
      }

      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AppDialog(
          title: 'Success',
          description: 'Group updated successfully.',
          alertType: AlertType.SUCCESS,
          positiveButtonText: 'Done',
          onPositiveCallback: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      );
    } catch (_) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => const AppDialog(
          title: 'Failed',
          description: 'Unable to update group. Please try again.',
          alertType: AlertType.FAIL,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _confirmDeleteGroup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Delete Group',
        description:
            'Are you sure you want to delete "${_nameController.text.trim()}"? Students will be unassigned from this group.',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          try {
            final firestore = FirebaseFirestore.instance;
            final batch = firestore.batch();

            final usersQuery = await firestore
                .collection('users')
                .where('group', isEqualTo: _initialName)
                .get();

            for (final doc in usersQuery.docs) {
              batch.update(doc.reference, {'group': ''});
            }

            batch.delete(firestore.collection('groups').doc(_groupId));
            await batch.commit();

            if (!context.mounted) return;
            Navigator.pop(context); // close confirm
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AppDialog(
                title: 'Success',
                description: 'Group deleted successfully.',
                alertType: AlertType.SUCCESS,
                positiveButtonText: 'Done',
                onPositiveCallback: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            );
          } catch (_) {
            if (!context.mounted) return;
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const AppDialog(
                title: 'Failed',
                description: 'Unable to delete group. Please try again.',
                alertType: AlertType.FAIL,
              ),
            );
          }
        },
      ),
    );
  }

  void _confirmRemoveStudent(String userDocId, String studentName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Remove from Group',
        description: 'Remove $studentName from this group?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Remove',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userDocId)
              .update({'group': ''});
          if (!context.mounted) return;
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _parseArgs();

    if (_groupId.isEmpty) {
      return Scaffold(
        backgroundColor: colors(context).surface,
        appBar: const CommonAppBar(title: 'Edit Group'),
        body: Center(
          child: Text(
            'Invalid group.',
            style: TextStyle(
              color: colors(context).secondaryText,
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Edit Group'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(
                  controller: _nameController,
                  labelText: 'Class group name',
                  hintText: 'e.g. Web Dev 2025',
                ),
                24.verticalSpace,
                Text(
                  'Students in this group',
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                10.verticalSpace,
                SizedBox(
                  height: 220.h,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('group', isEqualTo: _initialName)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
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
                            'No students in this group.',
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
                          final regId = (data['id'] ?? '').toString();
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
                                Icons.person_remove,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  _confirmRemoveStudent(doc.id, name),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                24.verticalSpace,
                CommonButton(
                  text: 'Save',
                  isLoading: _isSaving,
                  onPressed: _save,
                ),
                16.verticalSpace,
                CommonButton(
                  text: 'Delete Group',
                  backgroundColor: Colors.red,
                  onPressed: _confirmDeleteGroup,
                ),
                24.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
