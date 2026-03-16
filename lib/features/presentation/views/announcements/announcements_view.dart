import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/services/notification_service.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/group_dropdown.dart';

class AnnouncementsView extends ConsumerStatefulWidget {
  const AnnouncementsView({super.key});

  @override
  ConsumerState<AnnouncementsView> createState() => _AnnouncementsViewState();
}

class _AnnouncementsViewState extends ConsumerState<AnnouncementsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Announcements & Notifications'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('announcements')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Failed to load announcements.',
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
                    'No announcements yet. Tap + to publish.',
                    style: TextStyle(
                      color: colors(context).secondaryText,
                      fontSize: 13.sp,
                    ),
                  ),
                );
              }

              return ListView.separated(
                itemCount: docs.length,
                separatorBuilder: (_, __) => 10.verticalSpace,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final data = doc.data();
                  return _AnnouncementCard(
                    docId: doc.id,
                    title: (data['title'] ?? '').toString(),
                    body: (data['body'] ?? '').toString(),
                    group: (data['group'] ?? '').toString(),
                    date: (data['createdAt'] != null)
                        ? (data['createdAt'] is Timestamp
                            ? (data['createdAt'] as Timestamp).toDate().toString()
                            : data['createdAt'].toString())
                        : '',
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    String? selectedGroup;
    bool isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors(context).surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  18.verticalSpace,
                  Text(
                    'Target Group',
                    style: TextStyle(
                      color: colors(context).text,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  8.verticalSpace,
                  GroupDropdown(
                    selectedGroup: selectedGroup,
                    showAllOption: true,
                    onChanged: (value) {
                      setModalState(() {
                        selectedGroup = value;
                      });
                    },
                  ),
                  24.verticalSpace,
                  CommonButton(
                    text: 'Publish',
                    isLoading: isSubmitting,
                    onPressed: () async {
                      final title = titleController.text.trim();
                      final body = bodyController.text.trim();
                      if (title.isEmpty || body.isEmpty) return;

                      setModalState(() => isSubmitting = true);

                      try {
                        final targetGroup = selectedGroup ?? 'All';

                        await FirebaseFirestore.instance
                            .collection('announcements')
                            .add({
                          'title': title,
                          'body': body,
                          'group': targetGroup,
                          'createdAt': FieldValue.serverTimestamp(),
                        });

                        await notificationServiceProvider.sendNotification(
                          title: title,
                          body: body,
                          targetGroup: targetGroup,
                        );

                        if (!mounted) return;
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (_) => const AppDialog(
                            title: 'Published',
                            description:
                                'Announcement published and notification sent.',
                            alertType: AlertType.SUCCESS,
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        setModalState(() => isSubmitting = false);
                        showDialog(
                          context: context,
                          builder: (_) => AppDialog(
                            title: 'Failed',
                            description: 'Error: ${e.toString()}',
                            alertType: AlertType.FAIL,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String docId;
  final String title;
  final String body;
  final String group;
  final String date;

  const _AnnouncementCard({
    required this.docId,
    required this.title,
    required this.body,
    required this.group,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.kNotificationDetailsView,
          arguments: {
            'title': title,
            'body': body,
            'group': group,
            'createdAt': date,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: colors(context).secondarySurface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colors(context).secondarySurfaceBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: colors(context).text,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        AppUtils.getDate(date),
                        style: TextStyle(
                          color: colors(context).secondaryText,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: colors(context).text.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'To: $group',
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    body,
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
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => AppDialog(
                    title: 'Delete Announcement',
                    description: 'Are you sure you want to delete this announcement?',
                    alertType: AlertType.FAIL,
                    positiveButtonText: 'Delete',
                    negativeButtonText: 'Cancel',
                    onPositiveCallback: () {
                      FirebaseFirestore.instance
                          .collection('announcements')
                          .doc(docId)
                          .delete();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
