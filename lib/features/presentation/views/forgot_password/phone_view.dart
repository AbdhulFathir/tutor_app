import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/common_outlined_button.dart';
import '../../widgets/step_header.dart';
import '../../../../utils/navigation_routes.dart';

class PhoneView extends StatefulWidget {
  const PhoneView({super.key});

  @override
  State<PhoneView> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(52.w, 0, 52.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              99.verticalSpace,
              const StepHeader(currentStep: 1),
              SizedBox(height: 47.h),
              Text(
                'Enter your phone number.',
                style: AppStyling.normal700Size24.copyWith(
                  color: colors(context).text
                ) ,
              ),
              SizedBox(height: 14.h),
              Text(
                'Please enter your phone number to using Device Care + services',
                style: AppStyling.normal500Size13.copyWith(
                    color: colors(context).secondaryText
                )
              ),
              SizedBox(height: 24.h),
              CommonTextField(
                labelText:'Phone number',
                controller: _controller,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
                hintText: '+94',
                maxLength: 11,
              ),
              100.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CommonOutlinedButton(
                      text: 'Back',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CommonOutlinedButton(
                      text: 'Next',
                      onPressed: () => _showConfirmSheet(context),
                      buttonFillType: ButtonFillType.filled,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors(context).secondarySurface,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: colors(context).text,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              44.5.verticalSpace,
              Text(
                'Do you want to continue ?',
                style: AppStyling.normal600Size20.copyWith(
                  color: colors(context).text
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'We will send the authentication code to the phone number you\'ve entered;',
                textAlign: TextAlign.center,
                style: AppStyling.normal500Size13.copyWith(
                    color: colors(context).secondaryText
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Phone number: ${_controller.text}',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: colors(context).secondaryText
                ),
              ),
              SizedBox(height: 45.h),
              Row(
                children: [
                  Expanded(
                    child: CommonOutlinedButton(
                      text: 'Back',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CommonOutlinedButton(
                      text: 'Next',
                      buttonFillType: ButtonFillType.filled,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.kOtpView);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80.h),
            ],
          ),
        );
      },
    );
  }
}
