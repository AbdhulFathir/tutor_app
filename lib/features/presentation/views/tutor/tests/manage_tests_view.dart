import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../../tutor/models/test_item.dart';
import '../../../../tutor/state/tutor_state.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_text_field.dart';
import '../../../widgets/app_dialog.dart';

class ManageTestsView extends ConsumerWidget {
  const ManageTestsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(tutorStoreProvider);

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Upload Tests'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTestSheet(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ListView.separated(
            itemCount: store.tests.length,
            separatorBuilder: (_, __) => 10.verticalSpace,
            itemBuilder: (context, index) {
              final test = store.tests[index];
              return _TestCard(test: test);
            },
          ),
        ),
      ),
    );
  }

  void _showCreateTestSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final questionsController = TextEditingController(text: '20');
    final passMarkController = TextEditingController(text: '50');

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
                    'Create New Test',
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
                labelText: 'Test Title',
                hintText: 'e.g. July 2025 Test',
              ),
              18.verticalSpace,
              CommonTextField(
                controller: questionsController,
                labelText: 'Total Questions',
                keyboardType: TextInputType.number,
                hintText: '20',
              ),
              18.verticalSpace,
              CommonTextField(
                controller: passMarkController,
                labelText: 'Pass Mark (%)',
                keyboardType: TextInputType.number,
                hintText: '50',
              ),
              24.verticalSpace,
              CommonButton(
                text: 'Create',
                onPressed: () {
                  final title = titleController.text.trim();
                  if (title.isEmpty) return;
                  final totalQuestions =
                      int.tryParse(questionsController.text.trim()) ?? 20;
                  final passMark =
                      int.tryParse(passMarkController.text.trim()) ?? 50;

                  ref.read(tutorStoreProvider.notifier).addTest(
                        TutorTest(
                          id: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),
                          title: title,
                          date: DateTime.now(),
                          totalQuestions: totalQuestions,
                          passMark: passMark,
                        ),
                      );

                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      title: 'Success',
                      description: 'Test created successfully.',
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

class _TestCard extends ConsumerWidget {
  final TutorTest test;

  const _TestCard({required this.test});

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
                  test.title,
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${test.totalQuestions} Questions • Pass ${test.passMark}%',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showDeleteConfirm(context, ref),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AppDialog(
        title: 'Delete Test',
        description: 'Are you sure you want to delete "${test.title}"?',
        alertType: AlertType.FAIL,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPositiveCallback: () {
          ref.read(tutorStoreProvider.notifier).deleteTest(test.id);
        },
      ),
    );
  }
}

