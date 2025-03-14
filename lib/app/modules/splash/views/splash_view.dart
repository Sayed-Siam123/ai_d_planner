import 'dart:io';

import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/services/storage_prefs.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/base/base_view.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../data/models/page_route_arguments.dart';
import '../../../routes/app_routes.dart';

class SplashPage extends BaseView {

  SplashPage({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.noAppBar(
      navBarColor: Platform.isAndroid
          ? AppColors.backgroundColor
          : AppColors.backgroundColor,
      statusBarColor: AppColors.backgroundColor,
      isDarkBrightness: false,
    );
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(loginLogo),
        ),
        // Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        //   style: textRegularStyle(context,fontWeight: FontWeight.normal,languageSelect: LanguageSelect.gilroy,fontSize: 20),),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  initState() async{
    // TODO: implement initState

    if(!await StoragePrefs.hasData(StoragePrefs.questionDone)!){
      await setQuestionDone(data: false);
      await setPaymentDone(data: false);
    }
    _proceedToNext();
  }

  @override
  void onPopBack(BuildContext context) {
    // TODO: implement onPopBack
  }

  @override
  showBottomNav() {
    // TODO: implement showBottomNav
    return false;
  }

  setQuestionDone({required bool data}) async{
    if(await StoragePrefs.hasData(StoragePrefs.questionDone)!){
      await StoragePrefs.deleteByKey(StoragePrefs.questionDone);
      await StoragePrefs.set(StoragePrefs.questionDone, data);
    } else{
      await StoragePrefs.set(StoragePrefs.questionDone, data);
    }
  }

  setPaymentDone({required bool data}) async{
    if(await StoragePrefs.hasData(StoragePrefs.paymentDone)!){
      await StoragePrefs.deleteByKey(StoragePrefs.paymentDone);
      await StoragePrefs.set(StoragePrefs.paymentDone, data);
    } else{
      await StoragePrefs.set(StoragePrefs.paymentDone, data);
    }
  }

  void _proceedToNext() async{
    SupabaseClient _supabase = Supabase.instance.client;

    await Future.delayed(Duration(seconds: 2));

    /*if(_supabase.auth.currentUser != null){
      // toReplacementNamed(AppRoutes.getStarted,args: PageRouteArg(
      //   to: AppRoutes.getStarted,
      //   from: AppRoutes.splash,
      //   pageRouteType: PageRouteType.pushReplacement,
      //   isFromDashboardNav: false,
      // ));
      toReplacementNamed(AppRoutes.dashboard,args: PageRouteArg(
        to: AppRoutes.dashboard,
        from: AppRoutes.splash,
        pageRouteType: PageRouteType.pushReplacement,
        isFromDashboardNav: false,
      ));
    } else{
      toReplacementNamed(AppRoutes.login,args: PageRouteArg(
        to: AppRoutes.login,
        from: AppRoutes.splash,
        pageRouteType: PageRouteType.pushReplacement,
        isFromDashboardNav: false,
      ));
    }*/

    bool questionAnswerStatus = bool.parse(await StoragePrefs.get(StoragePrefs.questionDone) ?? "false");
    bool paymentStatus = bool.parse((await StoragePrefs.get(StoragePrefs.paymentDone) ?? "false"));

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    bool isSubscribed = customerInfo.entitlements.active.isNotEmpty;

    printLog(isSubscribed);
    printLog(customerInfo.originalAppUserId);

    if(isSubscribed){

      if(_supabase.auth.currentUser != null){
        toReplacementNamed(AppRoutes.dashboard,args: PageRouteArg(
          to: AppRoutes.dashboard,
          from: AppRoutes.splash,
          pageRouteType: PageRouteType.pushReplacement,
          isFromDashboardNav: false,
        ));
      } else{
        toReplacementNamed(AppRoutes.login,
            args: PageRouteArg(
              to: AppRoutes.login,
              from: AppRoutes.splash,
              pageRouteType: PageRouteType.pushReplacement,
              isFromDashboardNav: false,
            ));
      }
    }
    else{
      if(questionAnswerStatus){

        toReplacementNamed(AppRoutes.seeFullFeature,
            args: PageRouteArg(
              to: AppRoutes.seeFullFeature,
              from: AppRoutes.splash,
              pageRouteType: PageRouteType.pushReplacement,
              isFromDashboardNav: false,
            ));

      }
      else{
        toReplacementNamed(AppRoutes.getStarted,args: PageRouteArg(
          to: AppRoutes.getStarted,
          from: AppRoutes.splash,
          pageRouteType: PageRouteType.pushReplacement,
          isFromDashboardNav: false,
        ));
      }
    }
  }

}

