import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/theme/colors/main_colors.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../tutor/models/firestore_test.dart';
import '../../../../tutor/models/test_submission.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_outlined_button.dart';

class TestSubmissionsView extends StatelessWidget {
  const TestSubmissionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final test = args is FirestoreTest ? args : null;

    if (test == null) {
      return Scaffold(
        backgroundColor: colors(context).surface,
        appBar: const CommonAppBar(title: 'Test Submissions'),
        body: Center(
          child: Text(
            'Invalid test.',
            style: TextStyle(
              color: colors(context).secondaryText,
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    final dueDateText = test.dueDate != null
        ? AppUtils.getDate(test.dueDate!.toIso8601String())
        : '';

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(
        title: 'Results - ${test.title}',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colors(context).secondarySurface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors(context).secondarySurfaceBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test.title,
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      test.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors(context).secondaryText,
                        fontSize: 12.sp,
                      ),
                    ),
                    6.verticalSpace,
                    Text(
                      '${test.totalQuestions} Questions • ${test.group}',
                      style: TextStyle(
                        color: colors(context).secondaryText,
                        fontSize: 11.sp,
                      ),
                    ),
                    if (dueDateText.isNotEmpty) ...[
                      2.verticalSpace,
                      Text(
                        'Due date: $dueDateText',
                        style: TextStyle(
                          color: colors(context).secondaryText,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              16.verticalSpace,
              Text(
                'Submissions',
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.verticalSpace,
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('submision')
                      .where('testId', isEqualTo: test.id)
                      .orderBy('submittedAt', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Failed to load submissions.',
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
                          'No submissions yet for this test.',
                          style: TextStyle(
                            color: colors(context).secondaryText,
                            fontSize: 13.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final submissions =
                        docs.map(TestSubmission.fromDoc).toList();

                    return ListView.separated(
                      itemCount: submissions.length,
                      separatorBuilder: (_, __) => 10.verticalSpace,
                      itemBuilder: (context, index) {
                        final submission = submissions[index];
                        return _SubmissionCard(
                          test: test,
                          submission: submission,
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
  }
}

class _SubmissionCard extends StatelessWidget {
  final FirestoreTest test;
  final TestSubmission submission;

  const _SubmissionCard({
    required this.test,
    required this.submission,
  });

  @override
  Widget build(BuildContext context) {
    final submittedText = submission.submittedAt != null
        ? AppUtils.getDate(submission.submittedAt!.toIso8601String())
        : '';
    final statusText = submission.isMarked ? 'Marked' : 'Pending';
    final statusColor = submission.isMarked
        ? MainColors.appBlueColor
        : Colors.orange;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colors(context).secondarySurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors(context).secondarySurfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  submission.userId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors(context).text,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              8.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          4.verticalSpace,
          if (submittedText.isNotEmpty)
            Text(
              'Submitted on $submittedText',
              style: TextStyle(
                color: colors(context).secondaryText,
                fontSize: 11.sp,
              ),
            ),
          8.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Text(
                  submission.isMarked
                      ? 'Score: ${submission.score}%, Grade: ${submission.gradeText}'
                      : 'Awaiting marking',
                  style: TextStyle(
                    color: colors(context).secondaryText,
                    fontSize: 11.sp,
                  ),
                ),
              ),
              8.horizontalSpace,
              CommonOutlinedButton(
                text: 'View',
                onPressed: () {
                  _openMarkSheet(context, test, submission);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openMarkSheet(
    BuildContext context,
    FirestoreTest test,
    TestSubmission submission,
  ) {
    final scoreController =
        TextEditingController(text: submission.score.toString());
    final correctController =
        TextEditingController(text: submission.correctAnswers.toString());
    final incorrectController =
        TextEditingController(text: submission.incorrectAnswers.toString());
    final gradeController =
        TextEditingController(text: submission.gradeText);
    final commentController =
        TextEditingController(text: submission.tutorComment);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors(context).surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        bool isSaving = false;
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> save() async {
              if (isSaving) return;
              setState(() => isSaving = true);
              try {
                final score = int.tryParse(scoreController.text.trim()) ?? 0;
                final correct =
                    int.tryParse(correctController.text.trim()) ?? 0;
                final incorrectText = incorrectController.text.trim();
                final incorrect =
                    incorrectText.isEmpty
                        ? (test.totalQuestions - correct).clamp(0, test.totalQuestions)
                        : int.tryParse(incorrectText) ??
                            (test.totalQuestions - correct)
                                .clamp(0, test.totalQuestions);

                await FirebaseFirestore.instance
                    .collection('submision')
                    .doc(submission.id)
                    .update({
                  'score': score,
                  'correctAnswers': correct,
                  'incorrectAnswers': incorrect,
                  'gradeText': gradeController.text.trim(),
                  'tutorComment': commentController.text.trim(),
                  'isMarked': true,
                });

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              } catch (_) {
                setState(() => isSaving = false);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to save marks. Please try again.'),
                    ),
                  );
                }
              }
            }

            Future<void> openDrive() async {
              final link = submission.driveLink.trim();
              if (link.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Drive link not available'),
                  ),
                );
                return;
              }
              final uri = Uri.tryParse(link);
              if (uri == null || !uri.hasScheme) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid Drive link'),
                  ),
                );
                return;
              }
              final ok = await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
              if (!ok && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Could not open link'),
                  ),
                );
              }
            }

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
                          'Mark Submission',
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
                    Text(
                      submission.userId,
                      style: TextStyle(
                        color: colors(context).secondaryText,
                        fontSize: 12.sp,
                      ),
                    ),
                    18.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: scoreController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Score (%)',
                            ),
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: TextField(
                            controller: gradeController,
                            decoration: const InputDecoration(
                              labelText: 'Grade text',
                              hintText: 'e.g. A, Good, etc.',
                            ),
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: correctController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Correct answers',
                            ),
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: TextField(
                            controller: incorrectController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Incorrect answers',
                              hintText: 'Auto from total if empty',
                            ),
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Tutor comment',
                      ),
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            text: 'Open Answers',
                            isFullWidth: true,
                            onPressed: openDrive,
                          ),
                        ),
                      ],
                    ),
                    12.verticalSpace,
                    CommonButton(
                      text: isSaving ? 'Saving...' : 'Save Marks',
                      isLoading: isSaving,
                      onPressed: save,
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
}

