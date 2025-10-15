import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/navigation_routes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showNotificationIcon;
  final String? backButtonLabel;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.showNotificationIcon = false,
    this.backButtonLabel,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: AppColors.appWhiteColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
          : null,
      actions: [
        if (showNotificationIcon)
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.kHomeView);
            },
          ),
        ...?actions,
      ],
    );
  }

  @override
  final Size preferredSize;
} 