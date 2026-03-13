import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_app/core/theme/theme_data.dart';
import 'package:tutor_app/features/presentation/views/settings/widgets/settings_container_row.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../utils/enums.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeProvider);


    return Scaffold(
      backgroundColor: colors(context).surface,
      appBar: CommonAppBar(title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
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
              const Spacer(),
              CommonButton(
                text: 'Save',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

