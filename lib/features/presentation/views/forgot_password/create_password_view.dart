import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../widgets/app_dialog.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/common_outlined_button.dart';
import '../../widgets/step_header.dart';
import '../../../../utils/navigation_routes.dart';

class CreatePasswordView extends StatefulWidget {
  const CreatePasswordView({super.key});

  @override
  State<CreatePasswordView> createState() => _CreatePasswordViewState();
}

class _CreatePasswordViewState extends State<CreatePasswordView> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _obscure1 = true;

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
              const StepHeader(currentStep: 3),
              44.verticalSpace,
              Text('Create your password', style: AppStyling.normal700Size24),
              14.verticalSpace,
              Text(
                'Please enter your password to using Device Care + services',
                style: AppStyling.normal500Size13.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              24.verticalSpace,
              CommonTextField(
                labelText: 'Password',
                controller: _pass,
                obscureText: _obscure1,
                // suffixIcon: IconButton(
                //   icon: Icon(_obscure1 ? Icons.visibility_off : Icons.visibility),
                //   onPressed: () => setState(() => _obscure1 = !_obscure1),
                // ),
              ),
              15.verticalSpace,
              CommonTextField(
                labelText: 'Re-enter Password',
                controller: _confirm,
                // obscureText: _obscure2,
                // suffixIcon: IconButton(
                //   icon: Icon(_obscure2 ? Icons.visibility_off : Icons.visibility),
                //   onPressed: () => setState(() => _obscure2 = !_obscure2),
                // ),
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
                      buttonFillType: ButtonFillType.filled,
                      text: 'Next',
                      onPressed: () => _showSuccessDialog(context),
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

  // void _showSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (ctx) => Dialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       child: Padding(
  //         padding: EdgeInsets.all(20.w),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Icon(Icons.check_circle, color: Colors.green, size: 64),
  //             SizedBox(height: 12.h),
  //             const Text('Success', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
  //             SizedBox(height: 6.h),
  //             const Text('Password changed successfully'),
  //             SizedBox(height: 16.h),
  //             CommonButton(
  //               text: 'Done',
  //               onPressed: () {
  //                 Navigator.pop(ctx);
  //                 Navigator.pushReplacementNamed(context, Routes.kPasswordSuccessView);
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AppDialog(
            alertType: AlertType.SUCCESS,
            title: 'Success',
            description: 'Password changed successfully',
            positiveButtonText: 'Done',

            // Pass the navigation logic to the onPositiveCallback
            onPositiveCallback: () {
              // The AppDialog handles Navigator.pop(context) internally,
              // so we only need the navigation logic here.
              Navigator.pushNamed(context, Routes.kHomeView);
              Navigator.pop;
            },

            // Use dialogContentWidget to place the icon at the top if needed
            // dialogContentWidget: Padding(
            //   padding: const EdgeInsets.only(top: 10.0),
            //   child: Icon(Icons.check_circle, color: Colors.green, size: 64),
            // ),

            // The AppDialog already includes a background and padding,
            // so no need for explicit padding/shape here.
          ),
    );
  }
}
