import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/app_search_box.dart';
import '../widgets/tutor_tile.dart';

class TutorHomeView extends StatelessWidget {
  const TutorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    23.verticalSpace,
                    Row(
                      children: [
                        Image.asset(AppAssets.appLogo, width: 60.w, height: 60.w),
                        8.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Scribble 2 Scrabble',
                                style: TextStyle(
                                  color: colors(context).text,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Where Mess Becomes Mastery',
                                style: TextStyle(
                                  color: colors(context).secondaryText,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _CircleIconButton(
                          icon: Icons.notifications_none_rounded,
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorAnnouncementsView),
                        ),
                        10.horizontalSpace,
                        _CircleIconButton(
                          icon: Icons.logout_rounded,
                          onTap: () => Navigator.pushReplacementNamed(context, Routes.kLoginView),
                        ),
                      ],
                    ),
                    36.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1E88E5),
                            Color(0xFF0060DB),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipOval(
                              child: Image.asset(AppAssets.profilePicture, fit: BoxFit.cover),
                            ),
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  'Hello, Senuri',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Admin',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    18.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'what you want to do ?',
                          style: TextStyle(
                            color: colors(context).text,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        8.horizontalSpace,
                        Image.asset(AppAssets.thinkingBoy, height: 26.h),
                      ],
                    ),
                    18.verticalSpace,
                    AppSearchBox(
                      controller: searchController,
                      onChanged: (_) {},
                    ),
                    16.verticalSpace,
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 1.55,
                      children: [
                        TutorTile(
                          icon: AppAssets.iconUploads,
                          label: 'Upload Materials',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorUploadMaterialsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconFolderOpenFill,
                          label: 'Manage Lessons',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorManageLessonsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconUser,
                          label: 'Manage Students',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorManageStudentsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconUser,
                          label: 'Manage Class Groups',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorManageClassGroupsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconTest,
                          label: 'Upload Tests',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorUploadTestsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconScan,
                          label: 'QR Generator',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorQrHomeView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconAnnouncement,
                          label: 'Announcements',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorAnnouncementsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconPoll,
                          label: 'Polls',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorPollsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconResult,
                          label: 'Results',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorResultsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconUsers,
                          label: 'Manage admins',
                          onTap: () => Navigator.pushNamed(context, Routes.kTutorManageAdminsView),
                        ),
                        TutorTile(
                          icon: AppAssets.iconSetting,
                          label: 'Settings',
                          onTap: () => Navigator.pushNamed(context, Routes.kSettingsView),
                        ),
                      ],
                    ),
                    18.verticalSpace,
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A2643), Color(0xFF0060DB)],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'July 28, 2025 - 12:48',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    'Local time in Sri Lanka, LK',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 9.sp,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    'copyright 2025 - Made by SR',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors(context).secondarySurface,
          border: Border.all(color: colors(context).secondarySurfaceBorder),
        ),
        child: Icon(icon, size: 18.sp, color: colors(context).text),
      ),
    );
  }
}
