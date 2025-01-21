import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../binding/central_dependecy_injection.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';
import '../../../services/timer_bloc/cubit/timer_bloc_cubit.dart';

class ExclusiveVipOffer extends BaseView {
  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  ExclusiveVipOffer(this.context, {super.key, this.pageRouteArg});

  var timerCubitProvider = getIt<TimerCubit>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.customAppBar(
      context,
      "",
      backgroundColor: AppColors.backgroundColor,
      elevation: 0.0,
      navBarColor: AppColors.backgroundColor,
      statusBarColor: AppColors.backgroundColor,
      isDarkBrightness: false,
      onBackTap: () {
        _onBackMethod();
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringConstants.vipTopTitle,
                        style: textRegularStyle(context,
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      AppWidgets().gapH8(),
                      Text(
                        StringConstants.vipTopSubtitle,
                        style: textRegularStyle(context,
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      AppWidgets().gapH(30),
                    ],
                  ),
                ),
                _exclusiveOffer(context),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0,00.0,20.0,20.0),
          child: CustomAppMaterialButton(
            title: "⭐ Create the Best Plan For You",
            backgroundColor: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
            textColor: AppColors.whitePure,
            usePrefixIcon: false,
            needSplashEffect: true,
            borderRadius: 50,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            onPressed: () async {
              toReplacementNamed(AppRoutes.dashboard,
                  args: PageRouteArg(
                      to: AppRoutes.dashboard,
                      from: AppRoutes.exclusiveVipOffer,
                      pageRouteType: PageRouteType.pushReplacement,
                      isFromDashboardNav: false,
                  ));
            },
          ),
        ),
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
    timerCubitProvider.stopTimer();
  }

  @override
  void initState() {
    // TODO: implement initState
    // timerCubitProvider.startTimer(1200, showTime: "20:00");
  }

  @override
  void onPopBack(BuildContext context) {
    // TODO: implement onPopBack
    _onBackMethod();
  }

  @override
  showBottomNav() {
    // TODO: implement showBottomNav
    return false;
  }

  void _onBackMethod() {
    toReplacementNamed(AppRoutes.packagePricePlan,
        args: PageRouteArg(
            to: AppRoutes.packagePricePlan,
            from: AppRoutes.exclusiveVipOffer,
            pageRouteType: PageRouteType.pushReplacement,
            isFromDashboardNav: false,
            isBackAction: true));
  }

  _exclusiveOffer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(boxRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppWidgets().gapH(15),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor
                                    .withValues(alpha: 0.15),
                                borderRadius:
                                    BorderRadius.circular(roundRadius)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              child: Text(
                                "Offer end in 15:57",
                                style: textRegularStyle(context,
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text.rich(TextSpan(
                                text: "For Today Only\n",
                                style: textRegularStyle(context,
                                    color: AppColors.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "\$02.99",
                                      style: textRegularStyle(context,
                                          color: AppColors.primaryColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                          text: "/ month",
                                          style: textRegularStyle(context,
                                              color: AppColors.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ])
                                ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Transform.translate(
                  offset: const Offset(0, 17),
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(roundRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Save 80%",
                          style: textRegularStyle(context,
                              fontWeight: FontWeight.bold, isWhiteColor: true),
                        ),
                      )))
            ],
          ),
        ),
        AppWidgets().gapH(60),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _columnInformation(context,
                firstText: "50k+", secondText: "Active Users"),
            _columnInformation(context,
                firstText: "4.9 ⭐", secondText: "App Rating"),
            _columnInformation(context,
                firstText: "92%", secondText: "Success Rate"),
          ],
        ),
        AppWidgets().gapH(40),
        _profileAndReview(context),
        AppWidgets().gapH(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("What we serve:",style: textRegularStyle(context,fontSize: 16,fontWeight: FontWeight.bold),),
              AppWidgets().gapH8(),
              _whatWeHave(context),
              AppWidgets().gapH12(),
              _whatWeHave(context),
              AppWidgets().gapH12(),
              _whatWeHave(context),
              AppWidgets().gapH12(),
              _whatWeHave(context),
              AppWidgets().gapH12(),
              _whatWeHave(context),
              AppWidgets().gapH12(),
              _whatWeHave(context),
            ],
          ),
        ),
      ],
    );
  }

  _columnInformation(BuildContext context, {firstText, secondText}) {
    return Column(
      children: [
        Text(
          "$firstText",
          style: textRegularStyle(context,
              color: AppColors.blackPure,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "$secondText",
          style: textRegularStyle(context,
              color: AppColors.textGrayShade6,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  _profileAndReview(BuildContext context, {imageLink, name, review}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                userProfileImage,
                height: 25,
                width: 25,
              ),
              AppWidgets().gapW8(),
              Text(
                "Sarah K.",
                style: textRegularStyle(context,
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          AppWidgets().gapH16(),
          Text(
            "This app has changed my love life. I gave got a perfect husband for me. Blessed",
            textAlign: TextAlign.center,
            style: textRegularStyle(context,
                fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  _whatWeHave(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(boxRadius10P),
                        color: AppColors.primaryColor.withValues(alpha: 0.04)),
                    child: SvgPicture.asset(
                      menuList,
                      fit: BoxFit.scaleDown,
                    )),
                AppWidgets().gapW8(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("See the full date plan instantly",style: textRegularStyle(context,fontSize: 16,fontWeight: FontWeight.w700),),
                    Text("We help you to plan your date.",style: textRegularStyle(context,fontSize: 16,fontWeight: FontWeight.normal),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
