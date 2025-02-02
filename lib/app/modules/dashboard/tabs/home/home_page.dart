import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/constants/string_constants.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/core/widgets/custom_buttons_widget.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_state.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_event.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../binding/central_dependecy_injection.dart';
import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/helper/print_log.dart';
import '../questions/bloc/question_page_bloc.dart';

class HomePage extends StatefulWidget {

  final PageController? pageController;

  const HomePage({super.key,this.pageController});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var profileBloc = getIt<ProfileBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printLog("Home page");

    if(profileBloc.state.profileStateStatus != ProfileStateStatus.success){
      profileBloc.add(FetchProfileData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(homeTopBackgroundImage,width: double.maxFinite,alignment: Alignment.topCenter,),
        SafeArea(
          child: Column(
            children: [
              _topWidget(),
              AppWidgets().gapH(28),
              _bottomWidget(context),
            ],
          ),
        ),
      ],
    );
  }

  _topWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          AppWidgets().gapH(10),
          Center(child: Text(StringConstants.appBarTitleLovePlanAI,style: textRegularStyle(context,isWhiteColor: true,fontWeight: FontWeight.bold,fontSize: 24),)),
          AppWidgets().gapH24(),
          Center(child: Text(StringConstants.appBarBottomTitle,textAlign: TextAlign.center,style: textRegularStyle(context,isWhiteColor: true,fontWeight: FontWeight.bold,fontSize: 20),)),
        ],
      ),
    );
  }

  _bottomWidget(context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(boxRadius10P),
                  border: Border.all(
                    color: AppColors.textFieldBorderColor,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Craft 🎉\nthe Perfect Date, Effortlessly.",style: textRegularStyle(context,fontSize: 20,fontWeight: FontWeight.bold),),
                      AppWidgets().gapH24(),
                      Align(alignment: Alignment.center,child: SvgPicture.asset(homeFrontImage,)),
                      AppWidgets().gapH24(),
                      CustomAppMaterialButton(
                        title: "Generate My Plan! 🎉",
                        backgroundColor: AppColors.transparentPure,
                        borderColor: AppColors.primaryColor,
                        textColor: AppColors.primaryColor,
                        usePrefixIcon: false,
                        needSplashEffect: true,
                        borderRadius: 50,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        onPressed: () async {
                          var questionBloc = getIt<QuestionPageBloc>();
                          questionBloc.add(ResetAll());

                          widget.pageController!.jumpToPage(dashboardQuestion);
                        },
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
