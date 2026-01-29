import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/features/presentation/views/profile/widgets/settings_container.dart';
import 'package:tutor_app/features/presentation/views/profile/widgets/settings_container_row.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../../utils/enums.dart';
import '../../widgets/common_app_bar.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor:  colors(context).surface,
      appBar: CommonAppBar(
        title: 'Profile',
        showNotificationIcon: false,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.settings, color:  colors(context).text),
        //     onPressed: () {
        //       Navigator.pushNamed(context, Routes.kSettingsView);
        //     },
        //   ),
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 34.h),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.kEditProfileView);
                    },
                    child: SettingsContainer(
                      widget: Row(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.blue, // Blue circle border
                                width: 2.0,
                              ),
                            ),
                            child: ClipOval(
                              child:
                              // Image.network(
                              //   'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pinterest.com%2Fpin%2Fgirl-dp--721279696594521302%2F&psig=AOvVaw04ntqFAreXo5uL97GLCL8V&ust=1764261972339000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCODzqZaikJEDFQAAAAAdAAAAABAV', // Replace with your actual image URL or Asset path
                              //   fit: BoxFit.cover,
                              // ),
                              Image.asset(AppAssets.profilePicture),
                            ),
                          ),
                          12.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Senuri',
                                style: TextStyle(
                                  color:  colors(context).text,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                'w0005',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.sp,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                "Wednesday 2025",
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color:  colors(context).text
                                ),
                              ),

                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            color:  colors(context).text,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                42.verticalSpace,
                Text("General Settings",
                    style: AppStyling.boldTextSize16.copyWith(
                      color:  colors(context).text
                    )),
                26.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color:  colors(context).secondarySurface,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: colors(context).secondarySurfaceBorder.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:  colors(context).secondarySurfaceShadow.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(33.w, 10.h, 33.w, 10.h),
                    child: SettingsContainerRow(
                      icon: Icons.palette,
                      title: 'Theme',
                      isLastItem: true,
                      trailing: CupertinoSwitch(
                        value: appTheme.themeType == ThemeType.DARK,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).switchTheme(
                            value ? ThemeType.DARK : ThemeType.LIGHT,
                          );
                        },
                        activeTrackColor: const Color(0xFF4CAF50),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                14.verticalSpace,
                SettingsContainer(
                  widget: Column(
                    children: [
                      SettingsContainerRow(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        onTap: () {},
                      ),
                      SettingsContainerRow(
                        icon: Icons.description_outlined,
                        title: 'Terms & conditions',
                        onTap: () {
                          Navigator.pushNamed(context, Routes.kTermsView);
                        },
                      ),
                      SettingsContainerRow(
                        icon: Icons.lock_outline,
                        title: 'Privacy Policy',
                        isLastItem: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                14.verticalSpace,
                SettingsContainer(
                  widget: Row(
                    children: [
                      Icon(Icons.logout,
                          size: 24.sp,
                          color: colors(context).text,
                      ),
                      14.horizontalSpace,
                      Expanded(
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
