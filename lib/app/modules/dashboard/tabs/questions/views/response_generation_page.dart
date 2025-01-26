import 'dart:developer';

import 'package:ai_d_planner/app/core/constants/size_constants.dart';
import 'package:ai_d_planner/app/core/style/app_style.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/views/question_answer_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../binding/central_dependecy_injection.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/utils/helper/app_helper.dart';
import '../../../../../core/utils/helper/custom_pop_scope.dart';
import '../../../../../core/widgets/custom_buttons_widget.dart';
import '../../../../../data/models/question_page_dummy_model.dart';
import '../../../../../routes/app_pages.dart';
import '../bloc/question_page_bloc.dart';

class ResponseGenerationPage extends StatefulWidget {

  final PageController? pageController;

  const ResponseGenerationPage({super.key, this.pageController});

  @override
  _ResponseGenerationPageState createState() => _ResponseGenerationPageState();
}

class _ResponseGenerationPageState extends State<ResponseGenerationPage> {

  var questionBloc = getIt<QuestionPageBloc>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(AppHelper().systemOverlayStyle(
        color: AppColors.backgroundColor,
        navBarColor: AppColors.backgroundColor,
        isDarkBrightness: false,
      )); //forcefully change status bar color and nav bar color change
    });

    return CustomPopScope(
      onPopScope: () {
        widget.pageController!.jumpToPage(dashboardQuestion);
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              _customAppBar(context),
              CustomAppMaterialButton(
                title: "Regenerate My Plan",
                backgroundColor: AppColors.customHex("D0A2DA").withValues(alpha: 0.1),
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
            ],
          ),
        ),
      ),
    );
  }

  _customAppBar(context) {
    return Row(
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
        Text("Your perfect date is ready 🎊",style: textRegularStyle(context,fontWeight: FontWeight.bold,fontSize: 20),)
      ],
    );
  }

  _openQuestionEditDialog(BuildContext? context) {
      showDialog(
          context: context!,
          builder: (BuildContext context) {
            return QuestionAnswerDialogWidget();
      });
    }
  }
