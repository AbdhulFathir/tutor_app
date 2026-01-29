import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/theme_data.dart';
import '../../../utils/app_assets.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showNotificationIcon;
  final Color? notificationIconColor;
  final String? backButtonLabel;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.showNotificationIcon = false,
    this.notificationIconColor,
    this.backButtonLabel,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      actionsPadding: EdgeInsetsGeometry.symmetric(horizontal: 26.5.w),
      backgroundColor: colors(context).surface,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: colors(context).text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? Padding(
            padding:  EdgeInsets.only(left:26.5.w),
            child: IconButton(
                    icon: Icon(
            Icons.arrow_back_ios,
            color: colors(context).text,
                    ),
                    onPressed: () {
            Navigator.pop(context);
                    },
                  ),
          )
          : null,
      actions: [
        if (showNotificationIcon)
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:  notificationIconColor ?? colors(context).notificationBackgroundBlue,
          ),
          child: Image.asset(
            AppAssets.iconNotificationBell,
            width: 24.w,
            height: 24.w,
          ),
        ),
        ...?actions,
      ],
    );
  }

  @override
  final Size preferredSize;
} 