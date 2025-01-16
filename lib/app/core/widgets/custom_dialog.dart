import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../style/app_colors.dart';
import '../style/app_style.dart';
import '../utils/helper/custom_pop_scope.dart';
import 'app_widgets.dart';
import 'custom_buttons_widget.dart';

class CustomDialog{
  dynamic appExit(context){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          // actionsPadding: const EdgeInsets.all(20),
          backgroundColor: AppColors.whitePure,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset(logo,height: 25,width: 25,),
              // AppWidgets().gapW8(),
              Text('Warning',style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 16,color: AppColors.warningRed),),
            ],
          ),
          content: Text('Are you sure to exit the app?',style: textRegularStyle(context),),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,12.0,5.0,12.0),
              child: CustomAppTextButton(
                title: "Exit",
                textColor: AppColors.warningRed,
                onPressed: () async{
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
              ),
            ),
            AppWidgets().gapW8(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,12.0,16.0,12.0),
              child: CustomAppTextButton(
                title: "Cancel",
                textColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static simpleDialog(context, {title = "Warning", message}){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          // actionsPadding: const EdgeInsets.all(20),
          backgroundColor: AppColors.whitePure,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset(logo,height: 25,width: 25,),
              // AppWidgets().gapW8(),
              Text('$title',style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 16,color: AppColors.warningRed),),
            ],
          ),
          content: Text('$message',style: textRegularStyle(context,fontWeight: FontWeight.w500),),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,12.0,16.0,12.0),
              child: CustomAppTextButton(
                title: "I Understand",
                textColor: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  static customDialog(context, {title = "Warning",
        message,
        String? cancelButtonTitle = "",
        String? confirmButtonTitle = "",
        Color? titleTextColor = AppColors.primaryColor,
        Color? cancelButtonTextColor = AppColors.primaryColor,
        Color? confirmButtonTextColor = AppColors.primaryColor,
        Function()? cancelButtonOnTap,Function()? confirmButtonOnTap,
        bool? barrierDismissal = true,
        bool popScope = false,
      }) async{

    //popScope = false means there will be no popscope, popScope = true means there can be popScope feature

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissal ?? true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return !popScope ? CustomPopScope(
          onPopScope: () {},
          child: AlertDialog(
            surfaceTintColor: Colors.transparent,
            // actionsPadding: const EdgeInsets.all(20),
            backgroundColor: AppColors.whitePure,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.asset(logo,height: 25,width: 25,),
                // AppWidgets().gapW8(),
                Text('$title',style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 16,color: titleTextColor),),
              ],
            ),
            content: Text('$message',style: textRegularStyle(context,fontWeight: FontWeight.w500),),
            actions: [
              if(cancelButtonTitle!.isNotEmpty) Padding(
                padding: const EdgeInsets.fromLTRB(0,12.0,16.0,12.0),
                child: CustomAppTextButton(
                  title: cancelButtonTitle,
                  textColor: cancelButtonTextColor,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    cancelButtonOnTap!();
                  },
                ),
              ),
              if(confirmButtonTitle!.isNotEmpty) Padding(
                padding: const EdgeInsets.fromLTRB(0,12.0,16.0,12.0),
                child: CustomAppTextButton(
                  title: confirmButtonTitle,
                  textColor: confirmButtonTextColor,
                  fontWeight: FontWeight.w600,
                  onPressed: () {
                    confirmButtonOnTap!();
                  },
                ),
              ),
            ],
          ),
        ) : AlertDialog(
          surfaceTintColor: Colors.transparent,
          // actionsPadding: const EdgeInsets.all(20),
          backgroundColor: AppColors.whitePure,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset(logo,height: 25,width: 25,),
              // AppWidgets().gapW8(),
              Text('$title',style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 16,color: titleTextColor),),
            ],
          ),
          content: Text('$message',style: textRegularStyle(context,fontWeight: FontWeight.w500),),
          actions: [
            if(cancelButtonTitle!.isNotEmpty) Padding(
              padding: const EdgeInsets.fromLTRB(0,12.0,16.0,12.0),
              child: CustomAppTextButton(
                title: cancelButtonTitle,
                textColor: cancelButtonTextColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  cancelButtonOnTap!();
                },
              ),
            ),
            if(confirmButtonTitle!.isNotEmpty) Padding(
              padding: const EdgeInsets.fromLTRB(0,12.0,16.0,12.0),
              child: CustomAppTextButton(
                title: confirmButtonTitle,
                textColor: confirmButtonTextColor,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  confirmButtonOnTap!();
                },
              ),
            ),
          ],
        );
      },
    );
  }


}