import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/services/sorting/bloc/sorting_bloc.dart';
import 'package:ai_d_planner/app/services/sorting/bloc/sorting_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/sorting/bloc/sorting_event.dart';
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

  static customMessageDialog(context, {title = "Warning",
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

  static customLocationDateTimeDialog(
      BuildContext context, {
        String title = "Select Date, Location",
        String confirmButtonTitle = "Confirm",
        String cancelButtonTitle = "Cancel",
        String resetButtonTitle = "Reset",
        Color titleTextColor = Colors.black,
        Color confirmButtonTextColor = Colors.blue,
        Color cancelButtonTextColor = Colors.red,
        Function(String location, DateTime dateTime)? onConfirm,
        Function()? onCancel,
        Function()? onReset,
        bool barrierDismissal = true,
      }) async {
    TextEditingController locationController = TextEditingController();
    DateTime selectedDateTime = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissal,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: titleTextColor,
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Location Input Field
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: "Enter Location",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // const SizedBox(height: 16),
                  // DateTime Picker Button
                  // OutlinedButton(
                  //   onPressed: () async {
                  //     DateTime? pickedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: selectedDateTime,
                  //       firstDate: DateTime(2000),
                  //       lastDate: DateTime(2100),
                  //     );
                  //
                  //     if (pickedDate != null) {
                  //       setState(() {
                  //         selectedDateTime = DateTime(
                  //           pickedDate.year,
                  //           pickedDate.month,
                  //           pickedDate.day,
                  //         );
                  //       });
                  //     }
                  //   },
                  //   child: Text(
                  //     "Pick Date",
                  //     style: TextStyle(color: Colors.blue),
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  // Display Selected Date and Time
                  // Text(
                  //   "Selected: ${DateFormat("dd-MMM-yyyy").format(selectedDateTime)}",
                  //   style: TextStyle(fontSize: 14, color: Colors.black87),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              );
            },
          ),
          actions: [

            TextButton(
              onPressed: () {
                if (onReset != null) onReset();
                Navigator.of(context).pop();
              },
              child: Text(
                resetButtonTitle,
                style: TextStyle(color: confirmButtonTextColor),
              ),
            ),
            // Cancel Button
            TextButton(
              onPressed: () {
                if (onCancel != null) onCancel();
                Navigator.of(context).pop();
              },
              child: Text(
                cancelButtonTitle,
                style: TextStyle(color: cancelButtonTextColor),
              ),
            ),
            // Confirm Button
            TextButton(
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm(
                    locationController.text,
                    selectedDateTime,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(
                confirmButtonTitle,
                style: TextStyle(color: confirmButtonTextColor),
              ),
            ),
          ],
        );
      },
    );
  }


  static sortDialog() async{
    return showDialog(
      context: AppWidgets().globalContext,
      builder: (context) {
        return AlertDialog(
          title: Text('Sort By'),
          content: BlocBuilder<SortBloc, SortState>(
          builder: (context, state) {
            String selectedSort = 'None';
            if (state is SortSelected) {
              selectedSort = state.sortOption;
            }

            printLog(selectedSort);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Budget (Low to High)'),
                  onTap: () {
                    getIt<SortBloc>().add(SortByBudgetLowToHigh());
                    Navigator.pop(AppWidgets().globalContext);
                  },
                ),
                ListTile(
                  title: Text('Budget (High to Low)'),
                  onTap: () {
                    getIt<SortBloc>().add(SortByBudgetHighToLow());
                    Navigator.pop(AppWidgets().globalContext);

                  },
                ),
                ListTile(
                  title: Text('A-Z'),
                  onTap: () {
                    getIt<SortBloc>().add(SortByAToZ());
                    Navigator.pop(AppWidgets().globalContext);
                  },
                ),
                ListTile(
                  title: Text('Z-A'),
                  onTap: () {
                    getIt<SortBloc>().add(SortByZToA());
                    Navigator.pop(AppWidgets().globalContext);
                  },
                ),
                ListTile(
                  title: Text('Newest to Oldest'),
                  onTap: () {
                    getIt<SortBloc>().add(SortByNewestToOldest());
                    Navigator.pop(AppWidgets().globalContext);
                  },
                ),
                ListTile(
                  title: Text('Oldest to Newest'),
                  onTap: () {
                    getIt<SortBloc>().add(SortByOldestToNewest());
                    Navigator.pop(AppWidgets().globalContext);
                  },
                ),
              ],
            );
            },
          ),
        );
      },
    );
  }

  _listTileWidget({title,VoidCallback? onTap}){
    return ListTile(
      title: Text('Oldest to Newest'),
      onTap: () {
        getIt<SortBloc>().add(SortByOldestToNewest());
        Navigator.pop(AppWidgets().globalContext);
      },
    );
  }

}