import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_state.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/views/show_plan_dialog_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../../../../../core/style/app_style.dart';

class ExplorePage extends StatefulWidget {

  final PageController? pageController;

  ExplorePage({Key? key,this.pageController}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  var exploreBloc = getIt<ExploreBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(exploreBloc.state.exploreStateStatus != ExploreStateStatus.success){
      exploreBloc.add(FetchAllPlans());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  Widget _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: AppColors.textFieldBorderColor,
                  indicatorColor: AppColors.primaryColor,
                  labelColor: AppColors.primaryColor,
                  labelStyle: textRegularStyle(context,
                      languageSelect: LanguageSelect.gilroy,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                  unselectedLabelStyle: textRegularStyle(context,
                      languageSelect: LanguageSelect.gilroy,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGrayShade6),
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: AppColors.primaryColor, width: 4),
                    borderRadius: BorderRadius.circular(boxRadius),
                  ),
                  tabs: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Text('Favorite')),
                    Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Text('Upcoming')),
                    Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Text('Passed')),
                  ]),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _favourite(context),
                    _upcoming(context),
                    _passed(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _favourite(BuildContext context) {
    return BlocBuilder<ExploreBloc,ExploreState>(
      builder: (context, state) {
        Widget widget = const SizedBox();

        if(state.exploreStateStatus == ExploreStateStatus.success){
          widget = state.favList!.isNotEmpty ? _gridViewWidget(context,state.favList!) : Center(child: Text("No item found",style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 20),));
        }

        return widget;
      },
    );
  }

  _upcoming(BuildContext context) {
    return BlocBuilder<ExploreBloc,ExploreState>(
      builder: (context, state) {
        Widget widget = const SizedBox();

        if(state.exploreStateStatus == ExploreStateStatus.success){
          widget = state.upcomingList!.isNotEmpty ? _gridViewWidget(context,state.upcomingList!) : Center(child: Text("No item found",style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 20),));
        }

        return widget;
      },
    );
  }

  _passed(BuildContext context) {
    return BlocBuilder<ExploreBloc,ExploreState>(
      builder: (context, state) {
        Widget widget = const SizedBox();

        if(state.exploreStateStatus == ExploreStateStatus.success){
          widget = state.passedList!.isNotEmpty ? _gridViewWidget(context,state.passedList!) : Center(child: Text("No item found",style: textRegularStyle(context,fontWeight: FontWeight.w600,fontSize: 20),));
        }

        return widget;
      },
    );
  }

  _gridViewWidget(BuildContext context,List<GetPlanResponseModel> plansList){
    return RefreshIndicator(
      onRefresh: () async{
        exploreBloc.add(FetchAllPlans());
      },
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 7.0 / 10.0,
          shrinkWrap: true,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 20.0),
          children: List<Widget>.generate(plansList.length, (index) {
            return Material(
              color: AppColors.whitePure,
              borderRadius: BorderRadius.circular(boxRadius),
              child: InkWell(
                borderRadius: BorderRadius.circular(boxRadius),
                onTap: () async{
                  await _openDetailsDialog(context,plansList[index]);
                },
                child: GridTile(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: AppColors.transparentPure,
                        borderRadius: BorderRadius.circular(boxRadius),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 66,
                            spreadRadius: 0,
                            color: AppColors.whitePure.withValues(
                              alpha: 0.15,
                            ),
                          )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(_getDateFormat(plansList[index].dateDateTime!)!,style: textRegularStyle(context,fontSize: 12,fontWeight: FontWeight.bold),)),
                            Row(
                              children: [
                                Image.asset(copy,height: 15,width: 15,),
                                AppWidgets().gapW(10),
                                Image.asset(share,height: 15,width: 15,),
                              ],
                            ),
                          ],
                        ),
                        AppWidgets().gapH16(),
                        Text("Date in ${plansList[index].location!}",style: textRegularStyle(context,fontSize: 16,fontWeight: FontWeight.bold),),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(mapPin,height: 20,width: 20,color: AppColors.primaryColor),
                            AppWidgets().gapW8(),
                            Expanded(child: Text(plansList[index].location!,style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.textGrayShade7),))
                          ],
                        ),
                        AppWidgets().gapH8(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(budget,height: 20,width: 20,color: AppColors.primaryColor),
                            AppWidgets().gapW8(),
                            Text("\$${plansList[index].plan!.totalEstimatedCost.toString()}",style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.textGrayShade7),)
                          ],
                        ),
                        AppWidgets().gapH8(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(calender,height: 20,width: 20,color: AppColors.primaryColor),
                            AppWidgets().gapW8(),
                            Text(_getDateFormat(plansList[index].dateDateTime!)!,style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.textGrayShade7),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }

  String? _getTimeFormat(String? dateTime) {
    // Parse the input string
    DateFormat inputFormat = DateFormat("dd-MMM-yyyy, hh:mm a");
    DateTime parsedDate = inputFormat.parse(dateTime!);

    // Format the date
    String formattedTime = DateFormat("HH:mm a").format(parsedDate);

    return formattedTime;
  }

  String? _getDateFormat(String? dateTime) {
    // Parse the input string
    DateFormat inputFormat = DateFormat("dd-MMM-yyyy, hh:mm a");
    DateTime parsedDate = inputFormat.parse(dateTime!);

    // Format the date
    String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);

    return formattedDate;
  }

  _openDetailsDialog(BuildContext? context,GetPlanResponseModel? planData) {
    showDialog(
        context: context!,
        useSafeArea: true,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ShowPlanDialogWidget(
            planData: planData,
          );
        });
  }
}
