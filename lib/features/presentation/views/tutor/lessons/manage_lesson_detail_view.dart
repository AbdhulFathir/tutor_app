import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/app_dialog.dart';
import '../../../../tutor/models/lesson.dart';
import '../../../../tutor/models/topic.dart';
import 'manage_lessons_view.dart';

class ManageLessonDetailView extends StatelessWidget {
  const ManageLessonDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final initialLesson = ModalRoute.of(context)?.settings.arguments as Lesson?;
    if (initialLesson == null) {
      return Scaffold(
        backgroundColor: colors(context).surface,
        appBar: const CommonAppBar(title: 'Lesson'),
        body: Center(
          child: Text(
            'Invalid lesson.',
            style: TextStyle(
              color: colors(context).secondaryText,
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('lessons')
          .doc(initialLesson.id)
          .snapshots(),
      builder: (context, lessonSnapshot) {
        if (!lessonSnapshot.hasData) {
          return Scaffold(
            backgroundColor: colors(context).surface,
            appBar: const CommonAppBar(title: 'Lesson'),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final doc = lessonSnapshot.data!;
        if (!doc.exists) {
          return Scaffold(
            backgroundColor: colors(context).surface,
            appBar: const CommonAppBar(title: 'Lesson'),
            body: Center(
              child: Text(
                'Lesson not found.',
                style: TextStyle(
                  color: colors(context).secondaryText,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        }

        final data = doc.data() ?? {};
        final lesson = Lesson(
          id: doc.id,
          title: (data['title'] ?? '').toString(),
          description: (data['description'] ?? '').toString(),
          imageUrl: (data['image_url'] ?? '').toString(),
          group: (data['group'] ?? '').toString(),
          order: (data['order'] ?? 0) as int,
          totalTopics: (data['totalTopics'] ?? 0) as int,
        );

        return Scaffold(
          backgroundColor: colors(context).surface,
          appBar: CommonAppBar(
            title: lesson.title,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  ManageLessonsView.showEditLessonSheet(context, lesson);
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddTopicSheet(context, lesson),
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lesson info card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors(context).secondarySurface,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: colors(context).secondarySurfaceBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (lesson.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              lesson.imageUrl,
                              width: double.infinity,
                              height: 120.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 120.h,
                                color: Colors.grey.shade300,
                                child: Icon(Icons.image_not_supported, size: 40.sp),
                              ),
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            height: 120.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(Icons.menu_book, size: 40.sp),
                          ),
                        12.verticalSpace,
                        Text(
                          lesson.title,
                          style: TextStyle(
                            color: colors(context).text,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        8.verticalSpace,
                        Text(
                          lesson.description,
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                        8.verticalSpace,
                        Text(
                          'Group: ${lesson.group} · ${lesson.totalTopics} topics',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
              20.verticalSpace,
              Text(
                'Topics',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              12.verticalSpace,
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('lessons')
                      .doc(lesson.id)
                      .collection('topics')
                      .orderBy('order')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Failed to load topics.',
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
                          'No topics yet. Tap + to add.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                        ),
                      );
                    }

                    final topics = docs.map((d) {
                      final data = d.data();
                      return Topic(
                        id: d.id,
                        lessonId: lesson.id,
                        title: (data['title'] ?? '').toString(),
                        description: (data['description'] ?? '').toString(),
                        imageUrl: (data['image_url'] ?? '').toString(),
                        order: (data['order'] ?? 0) as int,
                        pdfUrl: (data['pdfUrl'] ?? '').toString(),
                        videoUrl: (data['video_url'] ?? '').toString(),
                      );
                    }).toList();

                    return ListView.separated(
                      itemCount: topics.length,
                      separatorBuilder: (_, __) => 10.verticalSpace,
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        return _TopicCard(
                          topic: topic,
                          onEdit: () => _showEditTopicSheet(context, lesson, topic),
                          onDelete: () => _confirmDeleteTopic(context, lesson, topic),
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
      },
    );
  }

  static void _showAddTopicSheet(BuildContext context, Lesson lesson) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageUrlController = TextEditingController();
    final pdfUrlController = TextEditingController();
    final videoUrlController = TextEditingController();
    final orderController = TextEditingController(text: '0');

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add New Topic',
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
                  hintText: 'e.g. What is AI',
                ),
                18.verticalSpace,
                ManageLessonsView.buildDescriptionField(
                  context,
                  controller: descriptionController,
                  labelText: 'Description',
                  hintText: 'Detailed description of the topic',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: imageUrlController,
                  labelText: 'Image URL',
                  hintText: 'https://...',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: pdfUrlController,
                  labelText: 'PDF URL',
                  hintText: 'Google Drive or direct PDF link',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: videoUrlController,
                  labelText: 'Video URL',
                  hintText: 'Google Drive or YouTube link',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: orderController,
                  labelText: 'Order',
                  hintText: '0',
                  keyboardType: TextInputType.number,
                ),
                24.verticalSpace,
                CommonButton(
                  text: 'Add Topic',
                  onPressed: () async {
                    final title = titleController.text.trim();
                    if (title.isEmpty) return;

                    final order = int.tryParse(orderController.text.trim()) ?? 0;

                    try {
                      await FirebaseFirestore.instance
                          .collection('lessons')
                          .doc(lesson.id)
                          .collection('topics')
                          .add({
                        'title': title,
                        'description': descriptionController.text.trim(),
                        'image_url': imageUrlController.text.trim(),
                        'pdfUrl': pdfUrlController.text.trim(),
                        'video_url': videoUrlController.text.trim(),
                        'order': order,
                      });

                      // Update totalTopics count
                      final topicsSnapshot = await FirebaseFirestore.instance
                          .collection('lessons')
                          .doc(lesson.id)
                          .collection('topics')
                          .get();

                      await FirebaseFirestore.instance
                          .collection('lessons')
                          .doc(lesson.id)
                          .update({'totalTopics': topicsSnapshot.docs.length});

                      if (!context.mounted) return;
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) => const AppDialog(
                          title: 'Success',
                          description: 'Topic added successfully.',
                          alertType: AlertType.SUCCESS,
                        ),
                      );
                    } catch (_) {
                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        builder: (_) => const AppDialog(
                          title: 'Failed',
                          description: 'Unable to add topic. Please try again.',
                          alertType: AlertType.FAIL,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _showEditTopicSheet(
    BuildContext context,
    Lesson lesson,
    Topic topic,
  ) {
    final titleController = TextEditingController(text: topic.title);
    final descriptionController = TextEditingController(text: topic.description);
    final imageUrlController = TextEditingController(text: topic.imageUrl);
    final pdfUrlController = TextEditingController(text: topic.pdfUrl);
    final videoUrlController = TextEditingController(text: topic.videoUrl);
    final orderController = TextEditingController(text: topic.order.toString());

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Topic',
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
                  hintText: 'e.g. What is AI',
                ),
                18.verticalSpace,
                ManageLessonsView.buildDescriptionField(
                  context,
                  controller: descriptionController,
                  labelText: 'Description',
                  hintText: 'Detailed description of the topic',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: imageUrlController,
                  labelText: 'Image URL',
                  hintText: 'https://...',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: pdfUrlController,
                  labelText: 'PDF URL',
                  hintText: 'Google Drive or direct PDF link',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: videoUrlController,
                  labelText: 'Video URL',
                  hintText: 'Google Drive or YouTube link',
                ),
                18.verticalSpace,
                CommonTextField(
                  controller: orderController,
                  labelText: 'Order',
                  hintText: '0',
                  keyboardType: TextInputType.number,
                ),
                24.verticalSpace,
                CommonButton(
                  text: 'Save',
                  onPressed: () async {
                    final title = titleController.text.trim();
                    if (title.isEmpty) return;

                    final order = int.tryParse(orderController.text.trim()) ?? 0;

                    try {
                      await FirebaseFirestore.instance
                          .collection('lessons')
                          .doc(lesson.id)
                          .collection('topics')
                          .doc(topic.id)
                          .update({
                        'title': title,
                        'description': descriptionController.text.trim(),
                        'image_url': imageUrlController.text.trim(),
                        'pdfUrl': pdfUrlController.text.trim(),
                        'video_url': videoUrlController.text.trim(),
                        'order': order,
                      });

                      if (!context.mounted) return;
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (_) => const AppDialog(
                          title: 'Success',
                          description: 'Topic updated successfully.',
                          alertType: AlertType.SUCCESS,
                        ),
                      );
                    } catch (_) {
                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        builder: (_) => const AppDialog(
                          title: 'Failed',
                          description: 'Unable to update topic. Please try again.',
                          alertType: AlertType.FAIL,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _confirmDeleteTopic(
    BuildContext context,
    Lesson lesson,
    Topic topic,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Delete Topic',
        description: 'Are you sure you want to delete "${topic.title}"?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          try {
            await FirebaseFirestore.instance
                .collection('lessons')
                .doc(lesson.id)
                .collection('topics')
                .doc(topic.id)
                .delete();

            // Update totalTopics count
            final topicsSnapshot = await FirebaseFirestore.instance
                .collection('lessons')
                .doc(lesson.id)
                .collection('topics')
                .get();

            await FirebaseFirestore.instance
                .collection('lessons')
                .doc(lesson.id)
                .update({'totalTopics': topicsSnapshot.docs.length});

            if (!context.mounted) return;
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const AppDialog(
                title: 'Success',
                description: 'Topic deleted successfully.',
                alertType: AlertType.SUCCESS,
              ),
            );
          } catch (_) {
            if (!context.mounted) return;
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const AppDialog(
                title: 'Failed',
                description: 'Unable to delete topic. Please try again.',
                alertType: AlertType.FAIL,
              ),
            );
          }
        },
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final Topic topic;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TopicCard({
    required this.topic,
    required this.onEdit,
    required this.onDelete,
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
          if (topic.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                topic.imageUrl,
                width: 50.w,
                height: 50.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 50.w,
                  height: 50.w,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.image_not_supported, size: 20.sp),
                ),
              ),
            )
          else
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.topic, size: 20.sp),
            ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  topic.description,
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
            icon: const Icon(Icons.edit_outlined),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
