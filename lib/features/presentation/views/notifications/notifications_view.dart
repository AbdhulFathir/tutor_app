import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../widgets/common_app_bar.dart';

class TutorNotificationsView extends ConsumerWidget {
  const TutorNotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Notifications'),
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
                    'Failed to load notifications.',
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
                    'No notifications yet.',
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
                  final title = (data['title'] ?? '').toString();
                  final body = (data['body'] ?? '').toString();
                  final group = (data['group'] ?? '').toString();
                  final date = (data['createdAt'] != null)
                      ? (data['createdAt'] is Timestamp
                          ? (data['createdAt'] as Timestamp).toDate().toString()
                          : data['createdAt'].toString())
                      : '';

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
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                          Text(
                            body,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors(context).secondaryText,
                              fontSize: 12.sp,
                            ),
                          ),
                          8.verticalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: colors(context).text.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'Group: $group',
                              style: TextStyle(
                                color: colors(context).text,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
