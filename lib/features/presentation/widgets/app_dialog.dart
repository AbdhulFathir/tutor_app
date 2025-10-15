import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/theme_data.dart';
import '../../../utils/enums.dart';
import 'common_button.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final Color? descriptionColor;
  final String? subDescription;
  final Color? subDescriptionColor;
  final AlertType? alertType;
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
        this.alertType,
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
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              children: [
                Material(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Color(0xFFE1E1E1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.11, 0.58]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            title ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: alertType == AlertType.SUCCESS
                                    ? colors(context).blackColor
                                    : colors(context).blackColor),
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
                                  color: descriptionColor ?? colors(context).blackColor),
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
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: subDescriptionColor ?? colors(context).blackColor),
                            ),
                          )
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 42),
                            child: CommonButton(
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
                                      color: colors(context).blackColor),
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
