import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../core/services/dependecy_injection.dart';
import '../../../core/services/secure_storage.dart';
import '../../../utils/enums.dart';
import '../../data/dataSources/local_data_source.dart';
import '../bloc/base_bloc.dart';
import '../bloc/base_event.dart';
import '../bloc/base_state.dart';
import '../widgets/app_dialog.dart';

abstract class BaseView extends StatefulWidget {
  const BaseView({super.key});
}

abstract class BaseViewState<Page extends BaseView> extends State<Page> {
  final secureStorage = injection<SecureStorage>();
  final pref = injection<LocalDataSource>();

  bool isLoadingShow = false;
  bool isUploading = false;

  Widget buildView(BuildContext context);
  BaseBloc<BaseEvent, BaseState<dynamic>> getBloc();

  // @override
  // void initState() {
  //   _initSecurityState();
  //   listenerBase = AppLifecycleListener(
  //     onStateChange: _onStateChangedBase,
  //   );
  //
  //   // listenerBasePermisson =AppLifecycleListener(
  //   //   onStateChange:(state){
  //   //     if(state ==AppLifecycleState.resumed){
  //   //     _requestPermission();
  //   //     }
  //   //   }
  //   // );
  //
  //   if (AppConstants.IS_USER_LOGGED) {
  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //       _initializeTimer();
  //     });
  //   } else {
  //     if (_timerBase?.isActive ?? false) {
  //       _timerBase?.cancel();
  //     }
  //   }
  //   if (AppConfig.deviceOS == DeviceOS.ANDROID) {
  //     _configureFirebaseNotification();
  //   } else {
  //     _configureHuaweiPushNotifications();
  //   }
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<BaseBloc>(
        create: (_)=> getBloc(),
      child: BlocListener<BaseBloc, BaseState>(
        listener: (context, state) {
          if (state is APILoadingState) {
            showProgressBar();
          } else if (state is UploadLoadingState) {
            showLoadingBar();
          } else {
            hideLoadingBar();
            hideProgressBar();
          }
        },
        child:buildView(context),
      ),
    );
  }




  showAppDialog(
      {required String title,
        String? message,
        Color? messageColor,
        String? subDescription,
        Color? subDescriptionColor,
        AlertType alertType = AlertType.SUCCESS,
        String? positiveButtonText,
        String? negativeButtonText,
        String? bottomButtonText,
        VoidCallback? onPositiveCallback,
        VoidCallback? onNegativeCallback,
        VoidCallback? onBottomButtonCallback,
        VoidCallback? onClickDescription,
        VoidCallback? onClickSubDescription,
        Widget? dialogContentWidget,
        bool shouldDismiss = false,
        bool? shouldEnableClose,
        bool isSessionTimeout = false,
        bool isAlertTypeEnable = true}) async {

    showGeneralDialog(
        context: context,
        barrierDismissible: shouldDismiss,
        barrierLabel: "",
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppDialog(
                title: title,
                description: message,
                descriptionColor: messageColor,
                subDescription: subDescription,
                subDescriptionColor: subDescriptionColor,
                alertType: alertType,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                onNegativeCallback: onNegativeCallback,
                onPositiveCallback: onPositiveCallback,
                dialogContentWidget: dialogContentWidget,
                isSessionTimeout: isSessionTimeout,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return const SizedBox.shrink();
        });
  }

  showProgressBar() {
    if (!isLoadingShow) {
      isLoadingShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return PopScope(
              canPop: false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child:  Container(
                      alignment: FractionalOffset.center,
                      child: Wrap(
                        children: [
                          Container(
                              color: Colors.transparent,
                              child: SpinKitWave(
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const SizedBox.shrink();
          });
    }
  }

  showLoadingBar() {
    if (!isLoadingShow) {
      isLoadingShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return PopScope(
              canPop :false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child:Container(
                      alignment: FractionalOffset.center,
                      child: Wrap(
                        children: [
                          Container(
                              color: Colors.transparent,
                              child: SpinKitWave(
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const SizedBox.shrink();
          });
    }
  }

  hideLoadingBar() {
    if (isLoadingShow) {
      Navigator.pop(context);
      isLoadingShow = false;
    }
  }

  hideProgressBar() {
    if (isUploading) {
      Navigator.pop(context);
      isUploading = false;
    }
  }

}

