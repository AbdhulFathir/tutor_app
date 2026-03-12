import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../tutor/state/tutor_state.dart';
import '../../widgets/common_app_bar.dart';

class TutorNotificationsView extends ConsumerWidget {
  const TutorNotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(tutorStoreProvider);

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Notifications'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ListView.separated(
            itemCount: store.notifications.length,
            separatorBuilder: (_, __) => 10.verticalSpace,
            itemBuilder: (context, index) {
              final n = store.notifications[index];
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: colors(context).secondarySurface,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: colors(context).secondarySurfaceBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      n.title,
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      n.body,
                      style: TextStyle(
                        color: colors(context).secondaryText,
                        fontSize: 12.sp,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      '${n.date}',
                      style: TextStyle(
                        color: colors(context).secondaryText,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

