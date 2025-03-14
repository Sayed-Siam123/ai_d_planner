import 'dart:io';

import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/constants/string_constants.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_event.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_bloc.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_event.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_state.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/size_constants.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';

class GetStartedPage extends BaseView {
  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  GetStartedPage(this.context, {super.key, this.pageRouteArg});

  late SwiperController? swiperController;

  late PageController? pageController;

  final getStartedBloc = getIt<GetStartedBloc>();
  final authBloc = getIt<AuthenticationBloc>();

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
      padding: const EdgeInsets.all(0.0),
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topPart(context),
          _middlePart(context),
          _bottomPart(context),
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
    swiperController?.dispose();
    pageController?.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    swiperController = SwiperController();
    pageController = PageController();
  }

  @override
  void onPopBack(BuildContext context) {
    var _supabase = Supabase.instance.client;
    // _supabase.auth.currentUser == null ?
    // toReplacementNamed(AppRoutes.login,args: PageRouteArg(
    //   to: AppRoutes.login,
    //   from: AppRoutes.getStarted,
    //   pageRouteType: PageRouteType.pushReplacement,
    //   isFromDashboardNav: false,
    //   isBackAction: true
    // )) : null;
    AppHelper.appExitMethod();
  }

  @override
  showBottomNav() {
    // TODO: implement showBottomNav
    return false;
  }

  _topPart(BuildContext context) {
    return Text.rich(TextSpan(
        text: StringConstants.aiPowered,
        style: textRegularStyle(context,
            languageSelect: LanguageSelect.kalnia,
            fontSize: 24,
            fontWeight: FontWeight.w500),
        children: [
          TextSpan(text: "\n"),
          TextSpan(
            text: StringConstants.datePlanner,
            style: textRegularStyle(context,
                languageSelect: LanguageSelect.gilroy,
                fontSize: 36,
                fontWeight: FontWeight.bold),
          )
        ]));
  }

  _middlePart(BuildContext context) {
    return Column(
      children: [
        AppWidgets().gapH(30),
        Swiper(
          controller: swiperController,
          indicatorLayout: PageIndicatorLayout.SLIDE,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(swipeCardRadius),
                child: Image.network(
                  "https://via.assets.so/album.png?id=${index + 1}&q=95&w=360&h=360&fit=fill",
                  fit: BoxFit.fitHeight,
                ));
          },
          itemCount: 3,
          onIndexChanged: (value) {
            //pageController!.jumpToPage(value);
            getStartedBloc.add(ChangeSlideIndicator(currentIndex: value));
          },
          autoplay: true,
          autoplayDelay: 2000,
          autoplayDisableOnInteraction: false,
          // pagination: SwiperPagination(),
          // control: SwiperControl(),
          layout: SwiperLayout.STACK,
          itemWidth: 300.w,
          itemHeight: 350.h,
          axisDirection: AxisDirection.right,
          allowImplicitScrolling: true,
          curve: Curves.easeInOut,
          scrollDirection: Axis.horizontal,
        ),
        AppWidgets().gapH12(),
        BlocBuilder<GetStartedBloc, GetStartedState>(
          builder: (context, state) {
            return AnimatedSmoothIndicator(
              activeIndex: state.swiperCurrentIndex ?? 0,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.primaryColor,
                dotHeight: 6,
                dotWidth: 6,
                spacing: 10
              ),
            );
          },
        )
      ],
    );
  }

  _bottomPart(BuildContext context) {
    return Column(
      children: [
        AppWidgets().gapH(30),
        // Spacer(),
        Text(StringConstants.bodyMessage,style: textRegularStyle(context,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),
        // Spacer(),
        AppWidgets().gapH(30),
        CustomAppMaterialButton(
          title: StringConstants.buttonStart,
          backgroundColor: AppColors.primaryColor,
          borderColor: AppColors.primaryColor,
          usePrefixIcon: false,
          needSplashEffect: true,
          borderRadius: 50,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          onPressed: () async {

            // authBloc.add(Logout());

            toReplacementNamed(AppRoutes.quesFlow,args: PageRouteArg(
              to: AppRoutes.quesFlow,
              from: AppRoutes.getStarted,
              pageRouteType: PageRouteType.pushReplacement,
              isFromDashboardNav: false,
            ));
          },
        ),
        //AppWidgets().gapH24(),
      ],
    );
  }
}
