import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../binding/central_dependecy_injection.dart';
import '../connection_manager/internet_cubit/internet_cubit.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import '../utils/helper/debounce_helper.dart';
import 'app_widgets.dart';

//ignore: must_be_immutable
class CustomAppMaterialButton extends StatelessWidget {

  dynamic splashColor = AppColors.grayDark.withOpacity(0.07);
  final String? title,toolTipMessage;
  final Function()? onPressed;
  final dynamic textColor;
  final dynamic fontSize;
  final dynamic fontWeight;
  final dynamic backgroundColor;
  final dynamic iconColor;
  final dynamic borderColor;
  final bool usePrefixIcon;
  final dynamic prefixIconData;
  final bool isIconData;
  final int iconSize;
  final double? customHeight;
  final bool? needTooltip,needSplashEffect;
  final int? borderRadius;
  final int? gapBetweenTextAndIcon;

  CustomAppMaterialButton({
    super.key,
    this.onPressed,
    this.fontSize = 16,
    this.textColor = AppColors.whitePure,
    this.fontWeight = FontWeight.w500,
    this.backgroundColor = AppColors.primaryColor,
    this.borderColor = AppColors.textGrayShade4,
    this.usePrefixIcon = false,
    this.prefixIconData,
    this.isIconData = false,
    this.iconSize = 28,
    this.iconColor = AppColors.primaryColor,
    this.title,
    this.customHeight = 55.0,
    this.needTooltip = false,
    this.toolTipMessage = "",
    this.needSplashEffect = false,
    this.borderRadius = 6,
    this.gapBetweenTextAndIcon = 8
  });

  @override
  Widget build(BuildContext context) {
    var internetCubit = getIt<InternetCubit>();

    return Visibility(
      visible: needTooltip!,
      replacement: Material(
        color: backgroundColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(double.parse(borderRadius.toString())),
            side: BorderSide(
              color: borderColor,
            )
        ),
        child: SizedBox(
          height: double.parse(customHeight.toString()),
          width: double.maxFinite,
          child: InkWell(
            highlightColor: needSplashEffect == true ? null : splashColor,
            splashColor: needSplashEffect == true ? splashColor : null,
            // overlayColor: needSplashEffect == false ? MaterialStateProperty.all(AppColors.grayDark.withOpacity(0.07)) : null,
            // focusColor: needSplashEffect == false ? AppColors.transparentPure : null,
            // hoverColor: needSplashEffect == false ? AppColors.transparentPure : null,
            borderRadius: BorderRadius.circular(double.parse(borderRadius.toString())),
            onTap: () {
              if(internetCubit.state.status == InternetStatusState.connected){
                DebounceHelper().killAllDebounce();
                DebounceHelper().debounce(
                  time: 1,
                  tag: DebounceHelper.buttonTag,
                  onMethod: onPressed,
                );
              } else{
                AppWidgets().getSnackBar(
                    status: SnackBarStatus.warning,
                    message: "No internet connection available. Please connect to internet first"
                );
              }
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  usePrefixIcon ?
                  !isIconData
                      ? prefixIconData!.toLowerCase().contains("svg") ? SvgPicture.asset(prefixIconData!,height: 20,width: 20,) : Image.asset(prefixIconData!,height: 20,width: 20,)
                      : Icon(prefixIconData,size: double.parse(iconSize.toString()),color: iconColor,)
                      : const SizedBox(),

                  if(usePrefixIcon && title != null) AppWidgets().gapW(double.parse(gapBetweenTextAndIcon.toString())),

                  Visibility(
                    visible: title != null ? true : false,
                    child: Text("$title",
                      style: textRegularStyle(
                          context,
                          color: textColor,
                          fontSize: double.parse(fontSize.toString()),
                          fontWeight: fontWeight
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      child: Tooltip(
        message: toolTipMessage.toString(),
        showDuration: const Duration(seconds: 1),
        triggerMode: TooltipTriggerMode.longPress,
        preferBelow: false,
        textAlign: TextAlign.center,
        verticalOffset: 20,
        child: Material(
          color: backgroundColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: borderColor,
              )
          ),
          child: SizedBox(
            height: double.parse(customHeight.toString()),
            width: double.maxFinite,
            child: InkWell(
              highlightColor: needSplashEffect == true ? null : splashColor,
              splashColor: needSplashEffect == true ? splashColor : null,
              // overlayColor: needSplashEffect == false ? MaterialStateProperty.all(AppColors.grayDark.withOpacity(0.07)) : null,
              // focusColor: needSplashEffect == false ? AppColors.transparentPure : null,
              // hoverColor: needSplashEffect == false ? AppColors.transparentPure : null,
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                if(internetCubit.state.status == InternetStatusState.connected){
                  DebounceHelper().killAllDebounce();
                  DebounceHelper().debounce(
                    time: 1,
                    tag: DebounceHelper.buttonTag,
                    onMethod: onPressed,
                  );
                } else{
                  AppWidgets().getSnackBar(
                      status: SnackBarStatus.warning,
                      message: "No internet connection available. Please connect to internet first"
                  );
                }
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    usePrefixIcon ?
                    !isIconData
                        ? prefixIconData!.toLowerCase().contains("svg") ? SvgPicture.asset(prefixIconData!,height: 20,width: 20,) : Image.asset(prefixIconData!,height: 20,width: 20,)
                        : Icon(prefixIconData,size: double.parse(iconSize.toString()),color: iconColor,)
                        : const SizedBox(),

                    if(usePrefixIcon && title != null) AppWidgets().gapW(double.parse(gapBetweenTextAndIcon.toString())),

                    Visibility(
                      visible: title != null ? true : false,
                      child: Text("$title",
                        style: textRegularStyle(
                            context,
                            color: textColor,
                            fontSize: double.parse(fontSize.toString()),
                            fontWeight: fontWeight
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//ignore: must_be_immutable
class CustomAppTextButton extends StatelessWidget {

  dynamic splashColor = AppColors.red.withOpacity(0.07);
  final String? title,toolTipMessage;
  final Function()? onPressed;
  final dynamic textColor,borderColor;
  final dynamic fontSize;
  final dynamic fontWeight;
  final bool? needTooltip,needBorder;

  CustomAppTextButton({
    super.key,
    this.onPressed,
    this.fontSize = 13,
    this.textColor = AppColors.whitePure,
    this.fontWeight = FontWeight.w500,
    this.title,
    this.needTooltip = false,
    this.toolTipMessage = "",
    this.needBorder = false,
    this.borderColor = AppColors.textColor
  });

  @override
  Widget build(BuildContext context) {
    var internetCubit = getIt<InternetCubit>();

    return Visibility(
      visible: needTooltip!,
      replacement: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          if(internetCubit.state.status == InternetStatusState.connected){
            DebounceHelper().killAllDebounce();
            DebounceHelper().debounce(
              time: 1,
              tag: DebounceHelper.buttonTag,
              onMethod: onPressed,
            );
          } else{
            AppWidgets().getSnackBar(
                status: SnackBarStatus.warning,
                message: "No internet connection available. Please connect to internet first"
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: needBorder! ? textColor : AppColors.transparentPure,
            )
          ),
          padding: needBorder! ? EdgeInsets.all(6) : EdgeInsets.zero,
          child: Text("$title",
            style: textRegularStyle(
                context,
                color: textColor,
                fontSize: double.parse(fontSize.toString()),
                fontWeight: fontWeight
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      child: Tooltip(
        message: toolTipMessage.toString(),
        showDuration: const Duration(seconds: 1),
        triggerMode: TooltipTriggerMode.longPress,
        preferBelow: false,
        textAlign: TextAlign.center,
        verticalOffset: 20,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            if(internetCubit.state.status == InternetStatusState.connected){
              DebounceHelper().killAllDebounce();
              DebounceHelper().debounce(
                time: 1,
                tag: DebounceHelper.buttonTag,
                onMethod: onPressed,
              );
            } else{
              AppWidgets().getSnackBar(
                  status: SnackBarStatus.warning,
                  message: "No internet connection available. Please connect to internet first"
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: needBorder! ? textColor : AppColors.transparentPure,
                )
            ),
            padding: needBorder! ? EdgeInsets.all(6) : EdgeInsets.zero,
            child: Text("$title",
              style: textRegularStyle(
                  context,
                  color: textColor,
                  fontSize: double.parse(fontSize.toString()),
                  fontWeight: fontWeight
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

//ignore: must_be_immutable
class CustomAppButtonWithCustomChild extends StatelessWidget {

  dynamic splashColor = AppColors.grayDark.withOpacity(0.07);
  final Widget? child;
  final Function()? onPressed;
  final int? borderRadius;
  final bool? needTooltip,needSplashEffect,isCentered;
  final String? toolTipMessage;

  CustomAppButtonWithCustomChild({
    super.key,
    this.onPressed,
    this.child = const SizedBox(),
    this.borderRadius = 6,
    this.needTooltip = false,
    this.toolTipMessage = "",
    this.needSplashEffect = false,
    this.isCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    var internetCubit = getIt<InternetCubit>();

    return Material(
      color: AppColors.transparentPure,
      surfaceTintColor: Colors.transparent,
      child: Visibility(
        visible: needTooltip!,
        replacement: InkWell(
          highlightColor: needSplashEffect == true ? null : splashColor,
          splashColor: needSplashEffect == true ? splashColor : null,
          // overlayColor: needSplashEffect == false ? MaterialStateProperty.all(AppColors.grayDark.withOpacity(0.07)) : null,
          // focusColor: needSplashEffect == false ? AppColors.transparentPure : null,
          // hoverColor: needSplashEffect == false ? AppColors.transparentPure : null,
          borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 6),
          onTap: () {
            if(internetCubit.state.status == InternetStatusState.connected){
              DebounceHelper().killAllDebounce();
              DebounceHelper().debounce(
                time: 1,
                tag: DebounceHelper.buttonTag,
                onMethod: onPressed,
              );
            } else{
              AppWidgets().getSnackBar(
                  status: SnackBarStatus.warning,
                  message: "No internet connection available. Please connect to internet first"
              );
            }
          },
          child: isCentered! ? Center(child: child,) : child,
        ),
        child: Tooltip(
          message: toolTipMessage.toString(),
          showDuration: const Duration(seconds: 1),
          triggerMode: TooltipTriggerMode.longPress,
          preferBelow: false,
          textAlign: TextAlign.center,
          verticalOffset: 20,
          child: InkWell(
            highlightColor: needSplashEffect == true ? null : splashColor,
            splashColor: needSplashEffect == true ? splashColor : null,
            // overlayColor: needSplashEffect == false ? MaterialStateProperty.all(AppColors.grayDark.withOpacity(0.07)) : null,
            // focusColor: needSplashEffect == false ? AppColors.transparentPure : null,
            // hoverColor: needSplashEffect == false ? AppColors.transparentPure : null,
            borderRadius: BorderRadius.circular(borderRadius?.toDouble() ?? 10),
            onTap: () {
              if(internetCubit.state.status == InternetStatusState.connected){
                DebounceHelper().killAllDebounce();
                DebounceHelper().debounce(
                  tag: DebounceHelper.buttonTag,
                  onMethod: onPressed,
                );
              } else{
                AppWidgets().getSnackBar(
                    status: SnackBarStatus.warning,
                    message: "No internet connection available. Please connect to internet first"
                );
              }
            },
            child: isCentered! ? Center(child: child,) : child,
          ),
        ),
      ),
    );
  }
}

class CustomAppMaterialCapsuleButton extends StatelessWidget {

  final Function()? onPressed;
  final dynamic textColor;
  final dynamic fontSize;
  final dynamic fontWeight;
  final dynamic backgroundColor;
  final dynamic buttonTitle;

  CustomAppMaterialCapsuleButton({super.key, this.buttonTitle ,this.onPressed, this.textColor = AppColors.whitePure, this.fontSize = 10, this.fontWeight = FontWeight.w600, this.backgroundColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    var internetCubit = getIt<InternetCubit>();

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(60),
      child: InkWell(
        borderRadius: BorderRadius.circular(60),
        onTap: () {
          if(internetCubit.state.status == InternetStatusState.connected){
            DebounceHelper().killAllDebounce();
            DebounceHelper().debounce(
              time: 1,
              tag: DebounceHelper.buttonTag,
              onMethod: onPressed,
            );
          } else{
            AppWidgets().getSnackBar(
                status: SnackBarStatus.warning,
                message: "No internet connection available. Please connect to internet first"
            );
          }
        },
        child: SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(child: Text("$buttonTitle",style: textRegularStyle(AppWidgets().globalContext,color: textColor,fontWeight: fontWeight,fontSize: double.parse(fontSize.toString())),)),
          ),
        ),
      ),
    );
  }
}
