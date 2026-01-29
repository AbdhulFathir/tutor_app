import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors/main_colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../widgets/common_outlined_button.dart';
import '../../widgets/otp_field.dart';
import '../../widgets/step_header.dart';
import '../../../../utils/navigation_routes.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {

  int _countdown = 34;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _countdown = 10;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    if (_canResend) {
      if (kDebugMode) {
        debugPrint('Resending OTP code...');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Verification code has been resent',
            style: AppStyling.normal500Size13.copyWith(color: colors(context).text),
          ),
          backgroundColor:  MainColors.appBlueColor,
          duration: const Duration(seconds: 2),
        ),
      );
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(53.w, 0, 53.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              99.verticalSpace,
              const StepHeader(currentStep: 2),
              47.verticalSpace,
              Text(
                'Enter OTP Verification code',
                style: AppStyling.normal700Size24.copyWith(
                  color: colors(context).text
                ),
              ),
              14.verticalSpace,
              Text(
                'Verification code has been sent to',
                style: AppStyling.normal500Size13.copyWith(
                  color: colors(context).text
                ),
              ),
              10.verticalSpace,
              Text(
                '(+94) 812 234 567',
                style: AppStyling.normal700Size16.copyWith(
                  color:  colors(context).text
                ),
              ),
              44.verticalSpace,
              OTPField(
                length: 5,
                onCompleted: (code) {
                  debugPrint('OTP Completed: $code');
                  // Handle OTP verification here
                },
                onChanged: (code) {
                  if (kDebugMode) {
                    debugPrint('Current OTP: $code');
                  }
                },
                fieldSize: 56,
                textStyle:  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:  colors(context).text
                ),
                cursorColor: Colors.blue,
                fillColor: Colors.grey[100],
              ),

              29.verticalSpace,
              // Center(
              //   child: Text(
              //     "Didn't receive the code? Resend (34s)",
              //     style: AppStyling.normal500Size13.copyWith(
              //       color: Colors.black54,
              //     ),
              //   ),
              // ),
              Center(
                child: GestureDetector(
                  onTap: _resendCode,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't receive the code? ",
                          style: AppStyling.normal500Size13.copyWith(
                            color:  colors(context).text,
                          ),
                        ),
                        TextSpan(
                          text: _canResend ? 'Resend' : 'Resend (${_countdown}s)',
                          style: AppStyling.normal500Size13.copyWith(
                            color: _canResend ? MainColors.appBlueColor : colors(context).text,
                            fontWeight: _canResend ? FontWeight.w600 : FontWeight.normal,
                            decoration: _canResend ? TextDecoration.underline : TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
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
                      onPressed: () => _showVerifiedSheet(context),
                      buttonFillType: ButtonFillType.filled,
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void _showVerifiedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors(context).secondarySurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (_) => Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                44.5.verticalSpace,
                Text('Verification Success',
                    style: AppStyling.normal600Size20.copyWith(
                      color: colors(context).text
                    )
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please create your password',
                  style: AppStyling.normal500Size13.copyWith(
                      color: colors(context).secondaryText
                  ),
                ),
                SizedBox(height: 24.5.h),
                CommonOutlinedButton(
                  text: 'Create Password',
                  buttonFillType: ButtonFillType.filled,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.kCreatePasswordView);
                  },
                ),
                73.verticalSpace
              ],
            ),
          ),
    );
  }
}
