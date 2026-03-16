import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_utils.dart';
import '../../widgets/common_app_bar.dart';

class NotificationDetailsView extends StatelessWidget {
  const NotificationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        appBar: const CommonAppBar(title: 'Notification Details'),
        body: const Center(child: Text('Invalid Notification')),
      );
    }

    final title = (args['title'] ?? '').toString();
    final body = (args['body'] ?? '').toString();
    final group = (args['group'] ?? '').toString();
    final date = (args['createdAt'] ?? '').toString();

    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: const CommonAppBar(title: 'Notification Details'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              12.verticalSpace,
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: colors(context).text.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'Group: $group',
                      style: TextStyle(
                        color: colors(context).text,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppUtils.getDate(date),
                    style: TextStyle(
                      color: colors(context).secondaryText,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,
              Divider(color: colors(context).secondarySurfaceBorder),
              16.verticalSpace,
              Text(
                'Message:',
                style: TextStyle(
                  color: colors(context).secondaryText,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpace,
              Text(
                body,
                style: TextStyle(
                  color: colors(context).text,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
