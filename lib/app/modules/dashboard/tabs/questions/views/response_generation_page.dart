import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_state.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/views/question_answer_dialog_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../binding/central_dependecy_injection.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/utils/helper/app_helper.dart';
import '../../../../../core/utils/helper/custom_pop_scope.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../data/models/question_page_dummy_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../get_started/bloc/get_started_bloc.dart';
import '../../../../get_started/bloc/get_started_event.dart';
import '../../../../get_started/bloc/get_started_state.dart';
import '../bloc/question_page_bloc.dart';

class ResponseGenerationPage extends StatefulWidget {

  final PageController? pageController;

  const ResponseGenerationPage({super.key, this.pageController});

  @override
  _ResponseGenerationPageState createState() => _ResponseGenerationPageState();
}

class _ResponseGenerationPageState extends State<ResponseGenerationPage> {

  var questionBloc = getIt<QuestionPageBloc>();
  final getStartedBloc = getIt<GetStartedBloc>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(AppHelper().systemOverlayStyle(
        color: AppColors.backgroundColor,
        navBarColor: AppColors.backgroundColor,
        isDarkBrightness: Platform.isIOS ? false : true,
      )); //forcefully change status bar color and nav bar color change
    });

    return CustomPopScope(
      onPopScope: () {
        widget.pageController!.jumpToPage(dashboardQuestion);
      },
      child: SafeArea(
        child: Column(
          children: [
            AppWidgets().gapH(20),
            _customAppBar(context),
            AppWidgets().gapH24(),
            Expanded(
              child: BlocBuilder<QuestionPageBloc, QuestionPageState>(
                builder: (context, state) {
                  return Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return _planItemWidget(context, index, state);
                    },
                    itemCount: state.plansFromDB!.length,
                    itemWidth: double.maxFinite,
                    axisDirection: AxisDirection.right,
                    allowImplicitScrolling: true,
                    curve: Curves.easeInOut,
                    outer: false,
                    viewportFraction: 0.85,
                    scale: 0.90,
                    onIndexChanged: (value) {
                      getStartedBloc.add(ChangeSlideIndicator(currentIndex: value));
                    },
                  );
                },
              ),
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
            ),
            AppWidgets().gapH12(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomAppMaterialButton(
                title: "Regenerate My Plan",
                backgroundColor: AppColors.customHex("D0A2DA").withValues(
                    alpha: 0.1),
                borderColor: AppColors.customHex("D0A2DA"),
                textColor: AppColors.customHex("D0A2DA"),
                usePrefixIcon: false,
                needSplashEffect: true,
                borderRadius: 50,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                onPressed: () async {
                  //log(questionPageDummyModelToJson(questionBloc.state.questionPageDummyData!));
                  _openQuestionEditDialog(context);
                },
              ),
            ),
            AppWidgets().gapH12(),
            Text("We’ll create something unforgettable this time!",style: textRegularStyle(context,fontSize: 14,fontWeight: FontWeight.w400),),
            AppWidgets().gapH24(),
            AppWidgets().gapH24(),
            AppWidgets().gapH24(),
            AppWidgets().gapH24(),
          ],
        ),
      ),
    );
  }

  _customAppBar(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            borderRadius: BorderRadius.circular(roundRadius),
            child: InkWell(
              borderRadius: BorderRadius.circular(roundRadius),
              onTap: () {
                widget.pageController!.jumpToPage(dashboardQuestion);
              },
              child: Icon(Icons.arrow_back_outlined),
            ),
          ),
          AppWidgets().gapW16(),
          Text("Your perfect date is ready 🎊", style: textRegularStyle(
              context, fontWeight: FontWeight.bold, fontSize: 20),)
        ],
      ),
    );
  }

  _openQuestionEditDialog(BuildContext? context) {
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return QuestionAnswerDialogWidget(
            pageController: widget.pageController,
          );
        });
  }

  _planItemWidget(BuildContext? context, int? index,QuestionPageState? state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whitePure,
        borderRadius: BorderRadius.circular(boxRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topLevel(context,state!.plansFromDB![index!].id.toString(),state.plansFromDB![index].plan!.datePlanId.toString(),isFav: state.plansFromDB![index].isFav),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.plansFromDB![index].plan!.activities!.map((activity) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.textFieldBorderColor
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(activity.startTime.toString(),style: textRegularStyle(context,fontWeight: FontWeight.bold,fontSize: 20),),
                            AppWidgets().gapH16(),
                            RichText(
                              text: TextSpan(
                                children: [
                                  // Normal part of the sentence
                                  TextSpan(
                                    text: '✨ ${activity.description!.replaceAll(".", "")} at ',
                                    style: textRegularStyle(context, fontWeight: FontWeight.normal, fontSize: 20),
                                  ),
                                  TextSpan(
                                    text: activity.location != null && activity.location!.split(' ').length > 2
                                        ? '${activity.location!.toLowerCase().split(' ').sublist(0, activity.location!.split(' ').length - 2).join(' ')} '
                                        : '${activity.location?.toLowerCase() ?? ''} ',
                                    style: textRegularStyle(context, fontWeight: FontWeight.normal, fontSize: 20),
                                  ),
                                  // Bold last two words
                                  TextSpan(
                                    text: activity.location != null && activity.location!.split(' ').length > 2
                                        ? activity.location!.toLowerCase().split(' ').sublist(activity.location!.split(' ').length - 2).join(' ')
                                        : '',
                                    style: textRegularStyle(context, fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text.rich(
              TextSpan(
                text: "Total estimated cost: ",
                style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 20),
                children: [
                  TextSpan(
                      text: "\$${state.plansFromDB![index].plan!.totalEstimatedCost!.toString()}",
                      style: textRegularStyle(context,fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  _topLevel(BuildContext? context,String? planID,String? datePlanID,{bool? isFav}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text("Plan 0${datePlanID.toString()}",style: textRegularStyle(context,fontWeight: FontWeight.bold,fontSize: 20),)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: AppColors.transparentPure,
                borderRadius: BorderRadius.circular(roundRadius),
                child: InkWell(
                    borderRadius: BorderRadius.circular(roundRadius),
                    onTap: () {
                      questionBloc.add(ChangeStatusFav(
                        planID: int.parse(planID.toString()),
                        status: !isFav
                      ));
                    },
                    child: Icon(!isFav! ? Icons.favorite_border_rounded : Icons.favorite_rounded,color: !isFav ? AppColors.textGrayShade8 : AppColors.red,size: 27,)),
              ),
              AppWidgets().gapW16(),
              Image.asset(calenderGray,scale: 1.5),
              AppWidgets().gapW16(),
              Image.asset(share,scale: 1.5),
            ],
          ),
        ],
      ),
    );
  }
}
