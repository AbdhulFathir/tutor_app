import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../tutor/models/admin_user.dart';
import '../../../tutor/state/tutor_state.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/app_dialog.dart';

class ManageAdminsView extends ConsumerWidget {
  const ManageAdminsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(tutorStoreProvider);

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Manage Admins'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ListView.separated(
            itemCount: store.admins.length,
            separatorBuilder: (_, __) => 10.verticalSpace,
            itemBuilder: (context, index) {
              final admin = store.admins[index];
              return _AdminCard(admin: admin);
            },
          ),
        ),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final roleController = TextEditingController(text: 'Admin');

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Admin',
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
              18.verticalSpace,
              CommonTextField(
                controller: nameController,
                labelText: 'Name',
                hintText: 'Admin name',
              ),
              18.verticalSpace,
              CommonTextField(
                controller: roleController,
                labelText: 'Role',
                hintText: 'Admin role',
              ),
              24.verticalSpace,
              CommonButton(
                text: 'Save',
                onPressed: () {
                  final name = nameController.text.trim();
                  if (name.isEmpty) return;
                  ref.read(tutorStoreProvider.notifier).addAdmin(
                        AdminUser(
                          id: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),
                          name: name,
                          role: roleController.text.trim(),
                        ),
                      );
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      title: 'Success',
                      description: 'Admin added successfully.',
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

class _AdminCard extends ConsumerWidget {
  final AdminUser admin;

  const _AdminCard({required this.admin});

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
                  admin.name,
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  admin.role,
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AppDialog(
                  title: 'Remove Admin',
                  description: 'Remove ${admin.name} from admins?',
                  alertType: AlertType.FAIL,
                  positiveButtonText: 'Remove',
                  negativeButtonText: 'Cancel',
                  onPositiveCallback: () {
                    ref.read(tutorStoreProvider.notifier).deleteAdmin(admin.id);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

