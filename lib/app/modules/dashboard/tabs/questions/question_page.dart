import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/utils/helper/custom_pop_scope.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/widgets/app_widgets.dart';

class QuestionPage extends StatefulWidget {

  final PageController? pageController;

  const QuestionPage({super.key, this.pageController});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printLog("Question page");
  }


  @override
  Widget build(BuildContext context) {
    return CustomPopScope(
      onPopScope: () {
        widget.pageController!.jumpToPage(0);
      },
      child: Stack(
        children: [
          Image.asset(homeTopBackgroundImage,width: double.maxFinite,alignment: Alignment.topCenter,),
          SafeArea(
            child: Column(
              children: [
                _topWidget(context),
                AppWidgets().gapH(28),
                _bottomWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _topWidget(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(onTap: () => widget.pageController!.jumpToPage(0),child: Icon(Icons.arrow_back_outlined,color: AppColors.whitePure,)),
              Expanded(child: Center(child: Transform.translate(offset: Offset(-12, 0),child: Text("Date AI",style: textRegularStyle(context,isWhiteColor: true,fontWeight: FontWeight.bold,fontSize: 24),)))),
            ],
          ),
          AppWidgets().gapH24(),
          Center(child: Text("Your Perfect Date is Just a Few Questions Away 🌟",textAlign: TextAlign.center,style: textRegularStyle(context,isWhiteColor: true,fontWeight: FontWeight.bold,fontSize: 20),)),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Questions Starts Here")
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
