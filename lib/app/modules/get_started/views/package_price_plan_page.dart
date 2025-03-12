import 'package:ai_d_planner/app/core/base/base_view.dart';
import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/constants/string_constants.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_bloc.dart';
import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_state.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../binding/central_dependecy_injection.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_buttons_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';
import '../../../services/subscription_purchase/bloc/subscription_purchase_event.dart';
import '../bloc/get_started_bloc.dart';
import '../bloc/get_started_event.dart';
import '../bloc/get_started_state.dart';

class PackagePricePlanPage extends BaseView {

  final BuildContext? context;
  final PageRouteArg? pageRouteArg;

  PackagePricePlanPage(this.context,{super.key,this.pageRouteArg});

  final getStartedBloc = getIt<GetStartedBloc>();
  final subscriptionBloc = getIt<SubscriptionPurchaseBloc>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar
    return CustomAppBar.customAppBar(context,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(StringConstants.priceTopTitle,style: textRegularStyle(context,fontSize: 20,fontWeight: FontWeight.bold),),
                      AppWidgets().gapH8(),
                      Text(StringConstants.priceTopSubtitle,style: textRegularStyle(context,fontSize: 16,fontWeight: FontWeight.normal),),
                      AppWidgets().gapH(30),
                    ],
                  ),
                ),
                _swipePackage(),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppWidgets().gapH(30),
              CustomAppMaterialButton(
                title: "Start Free Trial Now",
                backgroundColor: AppColors.whitePure,
                borderColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
                usePrefixIcon: false,
                needSplashEffect: true,
                borderRadius: 50,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                onPressed: () async {

                },
              ),
              AppWidgets().gapH16(),
              CustomAppMaterialButton(
                title: "Buy",
                backgroundColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                usePrefixIcon: false,
                needSplashEffect: true,
                borderRadius: 50,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                onPressed: () async {
                  // toReplacementNamed(AppRoutes.exclusiveVipOffer,args: PageRouteArg(
                  //     to: AppRoutes.exclusiveVipOffer,
                  //     from: AppRoutes.packagePricePlan,
                  //     pageRouteType: PageRouteType.pushReplacement,
                  //     isFromDashboardNav: false,
                  // ));
                  
                  // printLog(getIt<GetStartedBloc>().state.product);

                  if(getIt<GetStartedBloc>().state.product != null){
                    getIt<SubscriptionPurchaseBloc>().add(PurchaseSubscription(getIt<GetStartedBloc>().state.product!));
                  } else{
                    AppWidgets().getSnackBar(
                      message: "Please select a plan first",
                      status: SnackBarStatus.error
                    );
                  }
                },
              ),
            ],
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
  }

  @override
  void initState() {
    // TODO: implement initState
    getStartedBloc.add(PurchaseSubsList());
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
    toReplacementNamed(AppRoutes.seeFullFeature,args: PageRouteArg(
      to: AppRoutes.seeFullFeature,
      from: AppRoutes.packagePricePlan,
      pageRouteType: PageRouteType.pushReplacement,
      isFromDashboardNav: false,
      isBackAction: true
    ));
  }

  _swipePackage() {
    return BlocBuilder<GetStartedBloc,GetStartedState>(
      builder: (context, state) {
        return state.availablePackageLists != null ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 470,
              width: double.maxFinite,
              child: Swiper(
                itemHeight: 470,
                itemWidth: double.maxFinite,
                itemBuilder: (context, index) {

                  final currentProduct = state.availablePackageLists![index].storeProduct;
                  bool isSelected = state.product == currentProduct;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(boxRadius),
                          side: BorderSide(
                              color: isSelected ? AppColors.primaryColor : AppColors.transparentPure
                          )
                      ),
                      color: AppColors.whitePure,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(boxRadius),
                        onTap: () {
                          getIt<GetStartedBloc>().add(SelectSubscription(isSelected ? null : state.availablePackageLists![index].storeProduct));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24.0,16.0,24.0,0.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.check_circle,color: isSelected ? AppColors.primaryColor : AppColors.transparentPure,),
                              ),
                              SvgPicture.asset(crown),
                              AppWidgets().gapH16(),
                              Text.rich(TextSpan(
                                  text: "${state.availablePackageLists![index].storeProduct.title} package - ",
                                  style: textRegularStyle(context,fontSize: 24,fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: state.availablePackageLists![index].storeProduct.priceString,
                                      style: textRegularStyle(context,fontSize: 24,fontWeight: FontWeight.bold),
                                    )
                                  ]
                              )),
                              AppWidgets().gapH16(),
                              _containerInfo(context,text: "7 days Validity"),
                              AppWidgets().gapH16(),
                              _containerInfo(context,text: "View Full Plan"),
                              AppWidgets().gapH16(),
                              _containerInfo(context,text: "Ad Free"),
                              AppWidgets().gapH16(),
                              _containerInfo(context,text: "Cancel Anytime"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onIndexChanged: (value) {
                  getStartedBloc.add(ChangeSlideIndicator(currentIndex: value));
                },
                itemCount: state.availablePackageLists!.length,
                viewportFraction: 0.88,
                scale: 0.95,
              ),
            ),
            AppWidgets().gapH12(),
            BlocBuilder<GetStartedBloc, GetStartedState>(
              builder: (context, state) {
                return AnimatedSmoothIndicator(
                  activeIndex: state.swiperCurrentIndex ?? 0,
                  count: state.availablePackageLists!.length,
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
        ) : SizedBox();
      },
    );
  }

  _containerInfo(context,{text}) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundRadius),
        border: Border.all(
          color: AppColors.textFieldBorderColor
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppWidgets().gapW24(),
            Icon(Icons.check,color: AppColors.blackPure,),
            AppWidgets().gapW8(),
            Text(text,style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 15),),
          ],
        ),
      ),
    );
  }

}
