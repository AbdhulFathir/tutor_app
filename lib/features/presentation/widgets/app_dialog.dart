import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/theme_data.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_styling.dart';
import '../../../utils/enums.dart';
import 'common_gradiant_button.dart';
import 'common_outlined_button.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final Color? descriptionColor;
  final String? subDescription;
  final Color? subDescriptionColor;
  final AlertType alertType;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositiveCallback;
  final VoidCallback? onNegativeCallback;
  final Widget? dialogContentWidget;

  final bool? isSessionTimeout;

  const AppDialog(
      {super.key, this.title,
        this.description,
        this.descriptionColor,
        this.subDescription,
        this.subDescriptionColor,
        this.alertType = AlertType.SUCCESS,
        this.onPositiveCallback,
        this.onNegativeCallback,
        this.positiveButtonText,
        this.negativeButtonText,
        this.dialogContentWidget,
        this.isSessionTimeout});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
            alignment: FractionalOffset.center,
            padding:  EdgeInsets.symmetric(horizontal: 44.w),
            child: Wrap(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 65.5.w,vertical: 62.h),
                      child: Column(
                        children: [
                          Image.asset(
                            height: 77.h,
                            width: 77.h,
                            alertType == AlertType.SUCCESS
                                ?AppAssets.successIcon
                                :AppAssets.failedIcon,
                          ),
                          Text(
                            title ?? "",
                            textAlign: TextAlign.center,
                            style: AppStyling.normal600Size18,
                          ),
                          dialogContentWidget != null
                              ? Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 9, right: 9),
                            child: dialogContentWidget,
                          )
                              : SizedBox(),
                          description != null
                              ? Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text(
                              description ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: descriptionColor ?? Colors.black),
                            ),
                          )
                              : SizedBox(),
                          subDescription != null
                              ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              subDescription ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: subDescriptionColor ??Colors.black),
                            ),
                          )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 42),
                            child: CommonGradiantButton(
                              alertType: alertType,
                              text: positiveButtonText != null
                                  ? positiveButtonText!
                                  : "OK",
                              onPressed: () {
                                Navigator.pop(context);
                                if (onPositiveCallback != null) {
                                  onPositiveCallback!();
                                }
                              },
                            ),
                          ),
                          negativeButtonText != null
                              ? InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              if (onNegativeCallback != null) {
                                onNegativeCallback!();
                              }
                            },
                            child: SizedBox(
                              height: 57,
                              child: Center(
                                child: Text(
                                  negativeButtonText!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
