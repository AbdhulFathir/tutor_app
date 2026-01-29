import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../utils/enums.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final isDark = theme.themeType == ThemeType.DARK;
    final scaffoldBgColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: CommonAppBar(title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enable dark mode',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: theme.themeType == ThemeType.DARK,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).switchTheme(
                            value ? ThemeType.DARK : ThemeType.LIGHT,
                          );
                    },
                    activeColor: const Color(0xFF4CAF50),
                  ),
                ],
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

