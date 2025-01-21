import 'dart:io';
import 'dart:ui';

import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/constants/string_constants.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/assets_constants.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class SeeFullFeatures extends BaseView {

  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  SeeFullFeatures(this.context,{super.key,this.pageRouteArg});

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppWidgets().gapH24(),
          Text(StringConstants.seeFullFeatureTopTitle,style: textRegularStyle(context,fontSize: 20,fontWeight: FontWeight.bold),),
          AppWidgets().gapH24(),
          Expanded(child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),child: SvgPicture.asset(fadeImage,width: double.infinity,fit: BoxFit.fitWidth,))),
          AppWidgets().gapH24(),
          CustomAppMaterialButton(
            title: StringConstants.seeFullFeatureButtonTitle,
            backgroundColor: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
            usePrefixIcon: false,
            needSplashEffect: true,
            borderRadius: 50,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            onPressed: () async {
              toReplacementNamed(AppRoutes.packagePricePlan,args: PageRouteArg(
                to: AppRoutes.packagePricePlan,
                from: AppRoutes.getStarted,
                pageRouteType: PageRouteType.pushReplacement,
                isFromDashboardNav: false,
              ));
            },
          ),
          AppWidgets().gapH24(),
        ],
      ),
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
  void initState() {
    // TODO: implement initState
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
}
