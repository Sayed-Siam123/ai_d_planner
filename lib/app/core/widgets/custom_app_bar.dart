import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../constants/assets_constants.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import '../utils/helper/app_helper.dart';
import '../utils/helper/debounce_helper.dart';

class CustomAppBar {
  static customAppBar(context,title,
      {isCenterTitle = true,
      navBarColor = AppColors.whitePure,
      backgroundColor = AppColors.whitePure,
      Function()? onBackTap = null,
        elevation = 5.0,
        statusBarColor = AppColors.primaryColor,
        isDarkBrightness = true,
        titleFontSize = 20,
        titleFontWeight = FontWeight.bold,
      List<Widget>? actionWidget}) {
    return AppBar(
      actions: actionWidget ?? [const SizedBox()],
      surfaceTintColor: backgroundColor,
      backgroundColor: backgroundColor,
      toolbarHeight: 65,
      title: Text(
        title,
        style: textRegularStyle(context,fontSize: double.parse(titleFontSize.toString()), fontWeight: titleFontWeight,color: AppColors.appBarTitleTextColor),
      ),
      elevation: elevation,
      shadowColor: AppColors.white.withOpacity(0.4),
      centerTitle: isCenterTitle,
      systemOverlayStyle: AppHelper().systemOverlayStyle(navBarColor: navBarColor,color: statusBarColor,isDarkBrightness: Platform.isAndroid ? true : false,),
      leading: Visibility(
        visible: onBackTap != null ? true : false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Transform.translate(
            offset: const Offset(-2, 0),
            child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      DebounceHelper().killAllDebounce();
                      DebounceHelper().debounce(
                        tag: DebounceHelper.backButtonTag,
                        onMethod: onBackTap!,
                      );
                    },
                    child: Transform.translate(
                        offset: const Offset(0, 0),
                        child: const Icon(Icons.arrow_back_outlined,size: 23,color: AppColors.blackPure,)
                    )
                )
            ),
          ),
        ),
      ),
      leadingWidth: onBackTap != null ? 65 : 0,
    );
    //TODO:: isDarkBrightness: true for android, false for ios
  }

  static customAppBarWithCustomLeadingAndActionButton(context,title,
      {isCenterTitle = true,
        navBarColor = AppColors.whitePure,
        backgroundColor = AppColors.whitePure,
        VoidCallback? onLeadingIconTap = null,
        VoidCallback? onActionIconTap = null,
        elevation = 5.0,
        isTitleImage = false,
        statusBarColor = AppColors.primaryColor,
        isDarkBrightness = true,
      titleTextColor = AppColors.textColor}) {
    return AppBar(
      surfaceTintColor: backgroundColor,
      backgroundColor: backgroundColor,
      toolbarHeight: 65,
      title: !isTitleImage ? Text(
        title,
        style: textRegularStyle(context,fontSize: 20, fontWeight: FontWeight.w800,color: titleTextColor),
      ) : Transform.translate(offset: const Offset(0,-10),child: Image.asset(logoPath,scale: 8,)),
      elevation: elevation,
      shadowColor: AppColors.white.withOpacity(0.4),
      centerTitle: isCenterTitle,
      systemOverlayStyle: AppHelper().systemOverlayStyle(navBarColor: navBarColor,color: statusBarColor,isDarkBrightness: Platform.isAndroid ? true : false,),
      leading: Visibility(
        visible: onLeadingIconTap != null ? true : false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Transform.translate(
            offset: const Offset(5, 0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => onLeadingIconTap!.call(),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          // color: AppColors.liteGray
                          color: AppColors.transparentPure
                      )
                  ),
                  child: const Icon(Feather.menu,size: 28,color: AppColors.textColor),
                ),
              ),
            ),
          ),
        ),
      ),
      leadingWidth: 65,
      actions: [
        Transform.translate(
          offset: const Offset(-15, 0),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () => onActionIconTap!.call(),
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        // color: AppColors.liteGray
                        color: AppColors.transparentPure
                    )
                ),
                // child: Badge(
                //     offset: const Offset(1,-2),
                //     // alignment: Alignment.topRight,
                //     label: const Text("10"),
                //     backgroundColor: AppColors.primaryColor,
                //     textStyle: textRegularStyle(context,fontSize: 10,fontWeight: FontWeight.w700),
                //     child: const Icon(Icons.notifications_none_outlined,size: 30,color: AppColors.blackPure,)
                // ),
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.loose,
                  children: [
                    const Icon(Feather.bell,size: 28,color: AppColors.textColor,),
                    Visibility(
                      visible: true,
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: const Offset(7,-11),
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
    //TODO:: isDarkBrightness: true for android, false for ios
  }

  static noAppBar({navBarColor = AppColors.whitePure,statusBarColor = AppColors.primaryColor,isDarkBrightness = false}) {
    return AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        backgroundColor: navBarColor,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: AppHelper().systemOverlayStyle(navBarColor: navBarColor,color: statusBarColor,isDarkBrightness: Platform.isAndroid ? true : false,));
    //TODO:: isDarkBrightness: true for android, false for ios
  }

  static noAppBar2({navBarColor = AppColors.whitePure,statusBarColor = AppColors.primaryColor,isDarkBrightness = false}) {
    return AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        backgroundColor: navBarColor,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: AppHelper().systemOverlayStyle(navBarColor: navBarColor,color: statusBarColor,isDarkBrightness: isDarkBrightness,));
    //TODO:: isDarkBrightness: true for android, false for ios
  }
}
