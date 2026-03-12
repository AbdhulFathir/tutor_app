import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../tutor/models/announcement.dart';
import '../../../tutor/state/tutor_state.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/app_dialog.dart';

class AnnouncementsView extends ConsumerWidget {
  const AnnouncementsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(tutorStoreProvider);

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Announcements'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ListView.separated(
            itemCount: store.announcements.length,
            separatorBuilder: (_, __) => 10.verticalSpace,
            itemBuilder: (context, index) {
              final a = store.announcements[index];
              return _AnnouncementCard(item: a);
            },
          ),
        ),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

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
                    'Publish Announcement',
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
                controller: titleController,
                labelText: 'Title',
                hintText: 'e.g. Monthly Test',
              ),
              18.verticalSpace,
              CommonTextField(
                controller: bodyController,
                labelText: 'Message',
                hintText: 'Write your announcement',
                maxLines: 4,
              ),
              24.verticalSpace,
              CommonButton(
                text: 'Publish',
                onPressed: () {
                  final title = titleController.text.trim();
                  if (title.isEmpty) return;
                  ref.read(tutorStoreProvider.notifier).addAnnouncement(
                        Announcement(
                          id: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),
                          title: title,
                          body: bodyController.text.trim(),
                        ),
                      );
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      title: 'Published',
                      description: 'Announcement published successfully.',
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

class _AnnouncementCard extends ConsumerWidget {
  final Announcement item;

  const _AnnouncementCard({required this.item});

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
                  item.title,
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  item.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                  title: 'Delete Announcement',
                  description:
                      'Are you sure you want to delete "${item.title}"?',
                  alertType: AlertType.FAIL,
                  positiveButtonText: 'Delete',
                  negativeButtonText: 'Cancel',
                  onPositiveCallback: () {
                    ref
                        .read(tutorStoreProvider.notifier)
                        .deleteAnnouncement(item.id);
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

