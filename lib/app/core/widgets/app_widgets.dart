import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../binding/central_dependecy_injection.dart';
import '../../routes/app_pages.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';

class AppWidgets {
  static GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

  var globalContext = routerDelegate.navigatorKey.currentContext!;

  Widget gapH(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget gapW(double width) {
    return SizedBox(
      width: width,
    );
  }

  Widget gapW8() {
    return const SizedBox(
      width: 8,
    );
  }

  Widget gapH8() {
    return const SizedBox(
      height: 8,
    );
  }

  Widget gapH16() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget gapW16() {
    return const SizedBox(
      width: 16,
    );
  }

  Widget gapW12() {
    return const SizedBox(
      width: 12,
    );
  }

  Widget gapW24() {
    return const SizedBox(
      width: 24,
    );
  }

  Widget gapH12() {
    return const SizedBox(
      height: 12,
    );
  }

  Widget gapH24() {
    return const SizedBox(
      height: 24,
    );
  }

  getSnackBar(
      {title,
      message,
      int animationDuration = 3000,
        bool enableActionButton = false,
        String? actionLabel = "",
        VoidCallback? onActionPressed,
        SnackBarStatus status = SnackBarStatus.success,
        MobileSnackBarPosition position = MobileSnackBarPosition.bottom,
      colorText = Colors.white}) {
    // final SnackBar snackBar = SnackBar(
    //   backgroundColor: isError ? AppColors.warningRed : AppColors.primaryColor,
    //   content: Text(message),
    //   duration: Duration(milliseconds: animationDuration),
    //   action: enableActionButton ? SnackBarAction(
    //     onPressed: () => onActionPressed?.call(),
    //     label: actionLabel.toString(),
    //     textColor: AppColors.whitePure,
    //   ) : null,
    //   // behavior: SnackBarBehavior.floating,
    //   // margin: EdgeInsets.only(
    //   //   bottom: MediaQuery.of(AppWidgets.snackBarKey.currentContext!).size.height-250,
    //   // ),
    // );

    // ScaffoldMessenger.of(globalContext)
    // ..hideCurrentSnackBar()
    // ..showSnackBar(snackBar);

    AnimatedSnackBar(
      builder: (context) {
        return SizedBox(
          width: double.maxFinite,
          child: Material(
            borderRadius: BorderRadius.circular(6),
            color: status == SnackBarStatus.error ? AppColors.warningRed
                : status == SnackBarStatus.success ? AppColors.primaryColor
                : status == SnackBarStatus.warning ? Colors.amber
                : Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(status == SnackBarStatus.error ? Icons.error_rounded
                      : status == SnackBarStatus.success ? Icons.check_circle_rounded
                      : status == SnackBarStatus.warning ? Icons.warning_rounded
                      : Icons.info_rounded,
                    color: AppColors.whitePure,size: 40,),
                  AppWidgets().gapW16(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(title != null) Text(title,style: textRegularStyle(context,color: colorText,fontWeight: FontWeight.w600,fontSize: 14),),
                        if(title != null) AppWidgets().gapH(4),
                        Text(message,style: textRegularStyle(context,color: colorText,fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  if(enableActionButton) GestureDetector(onTap: () => onActionPressed?.call(),child: Text(actionLabel ?? "",style: textRegularStyle(context,color: colorText,fontWeight: FontWeight.w600,fontSize: 13),))
                ],
              ),
            ),
          ),
        );
      },
      animationDuration: const Duration(milliseconds: 500),
      duration: Duration(milliseconds: animationDuration),
      mobileSnackBarPosition: position,
      snackBarStrategy: RemoveSnackBarStrategy()
    ).show(globalContext);

  }
}

enum SnackBarStatus {
  success,
  error,
  warning,
  info
}

