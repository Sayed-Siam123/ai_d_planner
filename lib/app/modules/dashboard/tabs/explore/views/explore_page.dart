import 'package:add_2_calendar/add_2_calendar.dart';
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
      exploreBloc.add(SortPlansByDateEvent(ascending: exploreBloc.ascending));
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
          childAspectRatio: 7.5 / 10.0,
          shrinkWrap: false,
          crossAxisSpacing: 3,
          mainAxisSpacing: 15,
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 20.0),
          children: List<Widget>.generate(plansList.length, (index) {
            return Material(
              //color: AppColors.whitePure,
              borderRadius: BorderRadius.circular(boxRadius),
              child: InkWell(
                borderRadius: BorderRadius.circular(boxRadius),
                onTap: () async{
                  await _openDetailsDialog(context,plansList[index]);
                },
                child: GridTile(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.whitePure,
                          borderRadius: BorderRadius.circular(boxRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 4), // Shadow position
                            ),
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0,20.0,20.0,0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  color: AppColors.transparentPure,
                                  borderRadius: BorderRadius.circular(roundRadius),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(roundRadius),
                                    onTap: () {
                                      exploreBloc.add(DeletePlan(
                                        planID: int.parse(plansList[index].id.toString()),
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.delete,color: AppColors.primaryColor,size: 20,),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Material(
                                      color: AppColors.transparentPure,
                                      borderRadius: BorderRadius.circular(roundRadius),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(roundRadius),
                                        onTap: () {
                                          exploreBloc.add(ChangeStatusFav(
                                              planID: int.parse(plansList[index].id.toString()),
                                              status: !plansList[index].isFav!,
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(!plansList[index].isFav! ? Icons.favorite_border_rounded : Icons.favorite_rounded,color: !plansList[index].isFav! ? AppColors.textGrayShade8 : AppColors.red,size: 20,),
                                        ),
                                      ),
                                    ),
                                    AppWidgets().gapW(2),
                                    Material(
                                      color: AppColors.transparentPure,
                                      borderRadius: BorderRadius.circular(roundRadius),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(roundRadius),
                                        onTap: () async{
                                          await add2calender(
                                            dateTime: plansList[index].dateDateTime!,
                                            eventTitle: "Date plan ${plansList[index].id.toString()}",
                                            eventDescription: "",
                                            eventLocation: plansList[index].location!,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(calenderGray,height: 18,width: 18,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // AppWidgets().gapH16(),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: Text("Date in ${plansList[index].location!}",style: textRegularStyle(context,fontSize: 21,fontWeight: FontWeight.bold),)),
                                  AppWidgets().gapH16(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(mapPin,height: 20,width: 20,color: AppColors.primaryColor),
                                      AppWidgets().gapW8(),
                                      Expanded(child: Text(plansList[index].location!,overflow: TextOverflow.ellipsis,style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 17,color: AppColors.textGrayShade7),))
                                    ],
                                  ),
                                  AppWidgets().gapH8(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(budget,height: 20,width: 20,color: AppColors.primaryColor),
                                      AppWidgets().gapW8(),
                                      Text("\$${plansList[index].plan!.totalEstimatedCost.toString()}",style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 17,color: AppColors.textGrayShade7),)
                                    ],
                                  ),
                                  AppWidgets().gapH8(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(calender,height: 20,width: 20,color: AppColors.primaryColor),
                                      AppWidgets().gapW8(),
                                      Text(_getDateFormat(plansList[index].dateDateTime!)!,style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 17,color: AppColors.textGrayShade7),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

  add2calender({String? eventTitle,String? eventDescription,String? eventLocation,String? dateTime}){
    final Event event = Event(
      title: '$eventTitle',
      description: '$eventDescription',
      location: '$eventLocation',
      startDate: _getDateFromAPI(dateTime)!,
      endDate: _getDateFromAPI(dateTime)!,
      // iosParams: IOSParams(
      //   reminder: Duration(/* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
      //   url: 'https://www.example.com', // on iOS, you can set url to your event.
      // ),
      // androidParams: AndroidParams(
      //   emailInvites: [], // on Android, you can add invite emails to your event.
      // ),
    );

    Add2Calendar.addEvent2Cal(event);
  }

  DateTime? _getDateFromAPI(String? dateTime) {
    // Parse the input string
    DateFormat inputFormat = DateFormat("dd-MMM-yyyy, hh:mm a");
    DateTime parsedDate = inputFormat.parse(dateTime!);
    return parsedDate;
  }

}
