import 'package:ai_d_planner/app/core/constants/assets_constants.dart';
import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../../../../core/style/app_style.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  Widget _bodyWidget(BuildContext context) {
    return Padding(
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
    );
  }

  _favourite(BuildContext context) {
    return _gridViewWidget();
  }

  _upcoming(BuildContext context) {
    return _gridViewWidget();
  }

  _passed(BuildContext context) {
    return _gridViewWidget();
  }

  _gridViewWidget(){
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 7.0 / 10.0,
        shrinkWrap: true,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        children: List<Widget>.generate(16, (index) {
          return GridTile(
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: AppColors.whitePure,
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
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("02-01-2025",style: textRegularStyle(context,fontSize: 12,fontWeight: FontWeight.bold),)),
                      Row(
                        children: [
                          Image.asset(copy,height: 20,width: 20,),
                          AppWidgets().gapW16(),
                          Image.asset(share,height: 20,width: 20,),
                        ],
                      ),
                    ],
                  ),
                  AppWidgets().gapH16(),
                  Text("Date in Newyork, Park Street",style: textRegularStyle(context,fontSize: 16,fontWeight: FontWeight.bold),),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(mapPin,height: 20,width: 20,color: AppColors.primaryColor),
                      AppWidgets().gapW8(),
                      Expanded(child: Text("Park Street, New York",style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.textGrayShade7),))
                    ],
                  ),
                  AppWidgets().gapH8(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(budget,height: 20,width: 20,color: AppColors.primaryColor),
                      AppWidgets().gapW8(),
                      Text("\$500",style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.textGrayShade7),)
                    ],
                  ),
                  AppWidgets().gapH8(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(calender,height: 20,width: 20,color: AppColors.primaryColor),
                      AppWidgets().gapW8(),
                      Text("02-01-2025",style: textRegularStyle(context,fontWeight: FontWeight.normal,fontSize: 12,color: AppColors.textGrayShade7),)
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
