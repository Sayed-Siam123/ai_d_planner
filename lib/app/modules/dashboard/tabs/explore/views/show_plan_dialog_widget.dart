import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/assets_constants.dart';
import '../../../../../core/constants/size_constants.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_style.dart';
import '../../../../../core/widgets/app_widgets.dart';
import '../../questions/views/response_generation_page.dart';

class ShowPlanDialogWidget extends StatefulWidget {

  final GetPlanResponseModel? planData;

  const ShowPlanDialogWidget({super.key,this.planData});

  @override
  _ShowPlanDialogWidgetState createState() => _ShowPlanDialogWidgetState();
}

class _ShowPlanDialogWidgetState extends State<ShowPlanDialogWidget> {

  var questionBloc = getIt<QuestionPageBloc>();
  var exploreBloc = getIt<ExploreBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.whitePure,
        borderRadius: BorderRadius.circular(boxRadiusDialogBox),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topLevel(context, widget.planData!.id.toString(),widget.planData!.plan!.datePlanId.toString(),
              isFav: widget.planData!.isFav,
              title: "Date plan ${widget.planData!.id.toString()}",
              desc: "",
              location: widget.planData!.location.toString(),
              dateTime: widget.planData!.dateDateTime.toString()
          ),
          Divider(height: 0,),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.planData!.plan!.activities!.map((activity) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.textFieldBorderColor
                          ),
                        borderRadius: BorderRadius.circular(boxRadius10P),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(activity.startTime.toString(),style: textRegularStyle(context,fontWeight: FontWeight.bold,fontSize: 20),),
                            AppWidgets().gapH8(),
                            /*RichText(
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
                            ),*/
                            /*RichText(
                              text: TextSpan(
                                children: [
                                  // Normal part of the sentence
                                  TextSpan(
                                    text: '✨ ${activity.description!.replaceAll(".", "")} at ',
                                    style: textRegularStyle(context, fontWeight: FontWeight.normal, fontSize: 20),
                                  ),
                                  // TextSpan(
                                  //   text: activity.location != null && activity.location!.split(' ').length > 2
                                  //       ? '${activity.location!.toLowerCase().split(' ').sublist(0, activity.location!.split(' ').length - 2).join(' ')} '
                                  //       : '${activity.location?.toLowerCase() ?? ''} ',
                                  //   style: textRegularStyle(context, fontWeight: FontWeight.normal, fontSize: 20),
                                  // ),
                                  // Bold last two words
                                  TextSpan(
                                    text: activity.location != null
                                        ? activity.location!.toString()
                                        : '',
                                    style: textRegularStyle(context, fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),*/
                            ActivityText(name: activity.name!.toString()),
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
                      text: "\$${widget.planData!.plan!.totalEstimatedCost!.toString()}",
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

  _topLevel(BuildContext? context,String? planID,String? datePlanID,{bool? isFav,title,desc,location,dateTime}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text("$title",style: textRegularStyle(context,fontWeight: FontWeight.bold,fontSize: 20),)),
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
                      exploreBloc.add(ChangeStatusFav(
                          planID: int.parse(planID.toString()),
                          status: !isFav
                      ));
                      Navigator.pop(context!);
                    },
                    child: Icon(!isFav! ? Icons.favorite_border_rounded : Icons.favorite_rounded,color: !isFav ? AppColors.textGrayShade8 : AppColors.red,size: 27,)),
              ),
              AppWidgets().gapW16(),
              Material(
                color: AppColors.transparentPure,
                borderRadius: BorderRadius.circular(roundRadius),
                child: InkWell(
                    borderRadius: BorderRadius.circular(roundRadius),
                    onTap: () async{
                      await add2calender(
                          dateTime: dateTime,
                          eventTitle: title,
                          eventDescription: desc,
                          eventLocation: location
                      );
                    },
                    child: Image.asset(calenderGray,scale: 1.5)),
              ),
              AppWidgets().gapW16(),
              Image.asset(share,scale: 1.5),
            ],
          ),
        ],
      ),
    );
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
