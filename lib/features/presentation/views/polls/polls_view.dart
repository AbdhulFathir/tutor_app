import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/enums.dart';
import '../../../tutor/models/poll.dart';
import '../../../tutor/state/tutor_state.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/app_dialog.dart';

class PollsView extends ConsumerWidget {
  const PollsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(tutorStoreProvider);

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Polls'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ListView.separated(
            itemCount: store.polls.length,
            separatorBuilder: (_, __) => 10.verticalSpace,
            itemBuilder: (context, index) {
              final poll = store.polls[index];
              return _PollCard(poll: poll);
            },
          ),
        ),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Poll',
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
                controller: controller,
                labelText: 'Question',
                hintText: 'e.g. Was the lesson helpful?',
                maxLines: 3,
              ),
              24.verticalSpace,
              CommonButton(
                text: 'Create',
                onPressed: () {
                  final q = controller.text.trim();
                  if (q.isEmpty) return;
                  ref.read(tutorStoreProvider.notifier).addPoll(
                        Poll(
                          id: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),
                          question: q,
                        ),
                      );
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      title: 'Created',
                      description: 'Poll created successfully.',
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

class _PollCard extends ConsumerWidget {
  final Poll poll;

  const _PollCard({required this.poll});

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
            child: Text(
              poll.question,
              style: TextStyle(
                color: colors(context).text,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AppDialog(
                  title: 'Delete Poll',
                  description: 'Delete this poll?',
                  alertType: AlertType.FAIL,
                  positiveButtonText: 'Delete',
                  negativeButtonText: 'Cancel',
                  onPositiveCallback: () {
                    ref.read(tutorStoreProvider.notifier).deletePoll(poll.id);
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

