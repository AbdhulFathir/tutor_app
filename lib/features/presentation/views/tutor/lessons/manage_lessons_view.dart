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
import '../../../widgets/group_dropdown.dart';
import '../../../../tutor/models/lesson.dart';

class ManageLessonsView extends StatelessWidget {
  const ManageLessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Manage Lessons'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLessonSheet(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('lessons')
                .orderBy('order')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Failed to load lessons.',
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
                    'No lessons yet. Tap + to add.',
                    style: TextStyle(
                      color: colors(context).secondaryText,
                      fontSize: 13.sp,
                    ),
                  ),
                );
              }

              final lessons = docs.map((d) {
                final data = d.data();
                return Lesson(
                  id: d.id,
                  title: (data['title'] ?? '').toString(),
                  description: (data['description'] ?? '').toString(),
                  imageUrl: (data['image_url'] ?? '').toString(),
                  group: (data['group'] ?? '').toString(),
                  order: (data['order'] ?? 0) as int,
                  totalTopics: (data['totalTopics'] ?? 0) as int,
                );
              }).toList();

              return ListView.separated(
                itemCount: lessons.length,
                separatorBuilder: (_, __) => 10.verticalSpace,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  return _LessonCard(
                    lesson: lesson,
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.kTutorManageLessonDetailView,
                      arguments: lesson,
                    ),
                    onEdit: () => showEditLessonSheet(context, lesson),
                    onDelete: () => _confirmDeleteLesson(context, lesson),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  static void _showAddLessonSheet(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageUrlController = TextEditingController();
    final orderController = TextEditingController(text: '0');
    String? selectedGroup;

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add New Lesson',
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
                      hintText: 'e.g. Introduction to AI',
                    ),
                    18.verticalSpace,
                    buildDescriptionField(
                      context,
                      controller: descriptionController,
                      labelText: 'Description',
                      hintText: 'Brief description of the lesson',
                    ),
                    18.verticalSpace,
                    CommonTextField(
                      controller: imageUrlController,
                      labelText: 'Image URL',
                      hintText: 'https://...',
                    ),
                    18.verticalSpace,
                    CommonTextField(
                      controller: orderController,
                      labelText: 'Order',
                      hintText: '0',
                      keyboardType: TextInputType.number,
                    ),
                    18.verticalSpace,
                    Text(
                      'Class group',
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    10.verticalSpace,
                    GroupDropdown(
                      selectedGroup: selectedGroup,
                      onChanged: (value) {
                        setModalState(() => selectedGroup = value);
                      },
                    ),
                    24.verticalSpace,
                    CommonButton(
                      text: 'Add Lesson',
                      onPressed: () async {
                        final title = titleController.text.trim();
                        if (title.isEmpty) return;
                        if (selectedGroup == null || selectedGroup!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a class group'),
                            ),
                          );
                          return;
                        }

                        final order = int.tryParse(orderController.text.trim()) ?? 0;

                        try {
                          await FirebaseFirestore.instance
                              .collection('lessons')
                              .add({
                            'title': title,
                            'description': descriptionController.text.trim(),
                            'image_url': imageUrlController.text.trim(),
                            'group': selectedGroup,
                            'order': order,
                            'totalTopics': 0,
                          });

                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (_) => const AppDialog(
                              title: 'Success',
                              description: 'Lesson added successfully.',
                              alertType: AlertType.SUCCESS,
                            ),
                          );
                        } catch (_) {
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (_) => const AppDialog(
                              title: 'Failed',
                              description: 'Unable to add lesson. Please try again.',
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
      },
    );
  }

  static void showEditLessonSheet(BuildContext context, Lesson lesson) {
    final titleController = TextEditingController(text: lesson.title);
    final descriptionController = TextEditingController(text: lesson.description);
    final imageUrlController = TextEditingController(text: lesson.imageUrl);
    final orderController = TextEditingController(text: lesson.order.toString());
    String? selectedGroup = lesson.group.isNotEmpty ? lesson.group : null;

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Lesson',
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
                      hintText: 'e.g. Introduction to AI',
                    ),
                    18.verticalSpace,
                    buildDescriptionField(
                      context,
                      controller: descriptionController,
                      labelText: 'Description',
                      hintText: 'Brief description of the lesson',
                    ),
                    18.verticalSpace,
                    CommonTextField(
                      controller: imageUrlController,
                      labelText: 'Image URL',
                      hintText: 'https://...',
                    ),
                    18.verticalSpace,
                    CommonTextField(
                      controller: orderController,
                      labelText: 'Order',
                      hintText: '0',
                      keyboardType: TextInputType.number,
                    ),
                    18.verticalSpace,
                    Text(
                      'Class group',
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    10.verticalSpace,
                    GroupDropdown(
                      selectedGroup: selectedGroup,
                      onChanged: (value) {
                        setModalState(() => selectedGroup = value);
                      },
                    ),
                    24.verticalSpace,
                    CommonButton(
                      text: 'Save',
                      onPressed: () async {
                        final title = titleController.text.trim();
                        if (title.isEmpty) return;
                        if (selectedGroup == null || selectedGroup!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a class group'),
                            ),
                          );
                          return;
                        }

                        final order = int.tryParse(orderController.text.trim()) ?? 0;

                        try {
                          await FirebaseFirestore.instance
                              .collection('lessons')
                              .doc(lesson.id)
                              .update({
                            'title': title,
                            'description': descriptionController.text.trim(),
                            'image_url': imageUrlController.text.trim(),
                            'group': selectedGroup,
                            'order': order,
                          });

                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (_) => const AppDialog(
                              title: 'Success',
                              description: 'Lesson updated successfully.',
                              alertType: AlertType.SUCCESS,
                            ),
                          );
                        } catch (_) {
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (_) => const AppDialog(
                              title: 'Failed',
                              description: 'Unable to update lesson. Please try again.',
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
      },
    );
  }

  static Widget buildDescriptionField(
    BuildContext context, {
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: colors(context).text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        14.verticalSpace,
        TextFormField(
          controller: controller,
          maxLines: 3,
          style: TextStyle(color: colors(context).text, fontSize: 15.sp),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: colors(context).secondaryText),
            filled: true,
            fillColor: colors(context).secondarySurface,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: colors(context).secondarySurfaceBorder,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.blue.withValues(alpha: 0.7),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void _confirmDeleteLesson(BuildContext context, Lesson lesson) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Delete Lesson',
        description:
            'Are you sure you want to delete "${lesson.title}"? All topics will also be deleted.',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () async {
          try {
            final firestore = FirebaseFirestore.instance;

            // Delete all topics in the lesson first
            final topicsSnapshot = await firestore
                .collection('lessons')
                .doc(lesson.id)
                .collection('topics')
                .get();

            final batch = firestore.batch();
            for (final doc in topicsSnapshot.docs) {
              batch.delete(doc.reference);
            }
            batch.delete(firestore.collection('lessons').doc(lesson.id));
            await batch.commit();

            if (!context.mounted) return;
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (_) => const AppDialog(
                title: 'Success',
                description: 'Lesson deleted successfully.',
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
                description: 'Unable to delete lesson. Please try again.',
                alertType: AlertType.FAIL,
              ),
            );
          }
        },
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _LessonCard({
    required this.lesson,
    required this.onTap,
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Row(
          children: [
            if (lesson.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  lesson.imageUrl,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60.w,
                    height: 60.w,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.image_not_supported, size: 24.sp),
                  ),
                ),
              )
            else
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.menu_book, size: 24.sp),
              ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: TextStyle(
                      color: colors(context).text,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    '${lesson.totalTopics} topics · ${lesson.group}',
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
            TextButton(
              onPressed: onTap,
              child: const Text('Manage Topics'),
            ),
          ],
        ),
      ),
    );
  }
}
