import 'package:ai_d_planner/app/binding/central_dependecy_injection.dart';
import 'package:ai_d_planner/app/core/style/app_colors.dart';
import 'package:ai_d_planner/app/core/utils/helper/custom_pop_scope.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/custom_buttons_widget.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_state.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/size_constants.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/style/app_style.dart';
import '../../../../core/widgets/app_widgets.dart';
import '../../../../core/widgets/text_field_widget.dart';

class QuestionPage extends StatefulWidget {
  final PageController? pageController;

  const QuestionPage({super.key, this.pageController});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  var questionBloc = getIt<QuestionPageBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printLog("Question page");
    questionBloc.add(FetchQuestionFromDummy());
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopScope(
      onPopScope: () {
        widget.pageController!.jumpToPage(dashboardHome);
      },
      child: Stack(
        children: [
          Image.asset(
            homeTopBackgroundImage,
            width: double.maxFinite,
            alignment: Alignment.topCenter,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topWidget(context),
                AppWidgets().gapH(12.h),
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
          AppWidgets().gapH(10),
          Row(
            children: [
              Material(
                  color: AppColors.transparentPure,
                  child: InkWell(
                      onTap: () =>
                          widget.pageController!.jumpToPage(dashboardHome),
                      borderRadius: BorderRadius.circular(roundRadius),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: AppColors.whitePure,
                        ),
                      ))),
              Expanded(
                  child: Center(
                      child: Transform.translate(
                          offset: Offset(-20, -3),
                          child: Text(
                            StringConstants.appBarTitleLovePlanAI,
                            style: textRegularStyle(context,
                                isWhiteColor: true,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          )))),
            ],
          ),
          AppWidgets().gapH24(),
          Center(
              child: Transform.translate(
                offset: Offset(0, -6),
                child: Text(
                  StringConstants.appBarBottomTitle,
                  textAlign: TextAlign.center,
                  style: textRegularStyle(context,
                      isWhiteColor: true,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
        ],
      ),
    );
  }

  _bottomWidget(context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<QuestionPageBloc, QuestionPageState>(
          builder: (context, state) {
            Widget widget = const SizedBox();

            if(state.questionPageStateStatus == QuestionPageStateStatus.success){
              widget = Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("sasas")
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.questionPageDummyData!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _getQuestionTile(context,state,index);
                    },
                  ),
                  AppWidgets().gapH24(),
                  CustomAppMaterialButton(
                    title: "Submit",
                    backgroundColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    usePrefixIcon: false,
                    needSplashEffect: true,
                    borderRadius: 50,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    onPressed: () async {

                    },
                  ),
                ],
              );
            }

            return widget;
          },
        ),
      ),
    );
  }

  _getQuestionTile(BuildContext? context,QuestionPageState state,index) {
    bool isCustomSelected = state.questionPageDummyData![index].selected != null &&
        state.questionPageDummyData![index].selected is List<Map<String, dynamic>> &&
        (state.questionPageDummyData![index].selected as List<Map<String, dynamic>>)
            .any((selected) => selected["option"].toString().toLowerCase() == "custom");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppWidgets().gapH12(),
        Text(state.questionPageDummyData![index].ques ?? ""),
        AppWidgets().gapH12(),
        if(state.questionPageDummyData![index].isMultipleSelect == false && state.questionPageDummyData![index].options!.isEmpty)
          // Text("TextField")
          _getTextField(
              context,
              state.questionPageDummyData![index].ques,
              state.questionPageDummyData![index].hint,
              state.questionPageDummyData![index].textEditingController,
              state.questionPageDummyData![index].focusNode,
            textFieldType: state.questionPageDummyData![index].textFieldType,
            isActive: true,
            isReadOnly: state.questionPageDummyData![index].textFieldType == "dateField"
                || state.questionPageDummyData![index].textFieldType == "location" ? true : false
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: state.questionPageDummyData![index].options!.map((option) {
                  int optionIndex = state.questionPageDummyData![index].options!.indexOf(option);

                  // Determine if the option is selected
                  bool isSelected = false;
                  var selectedAnswers = state.questionPageDummyData![index].selected;

                  if (selectedAnswers != null && selectedAnswers is List<Map<String, dynamic>>) {
                    // Handle both multiple and single selection since `selected` is a list
                    isSelected = selectedAnswers.any((selected) =>
                    selected["optionID"] == optionIndex && selected["option"].toString().toLowerCase() == option.toLowerCase());
                  }

                  // Special case: custom option selection
                  if (option.toLowerCase() == "custom" &&
                      selectedAnswers != null &&
                      selectedAnswers is List<Map<String, dynamic>>) {
                    isSelected = selectedAnswers.any((selected) => selected["option"].toString().toLowerCase() == "custom");
                  }

                  return Material(
                    color: isSelected ? AppColors.primaryColor : AppColors.whitePure,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(roundRadius),
                      side: BorderSide(
                        color: AppColors.primaryColor.withOpacity(0.15),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context!).unfocus();
                        // Trigger the appropriate event for single or multiple selection
                        questionBloc.add(SelectOption(
                          questionIndex: index,
                          selectedAnswer: {
                            "optionID": optionIndex,
                            "option": option,
                          },
                        ));
                      },
                      borderRadius: BorderRadius.circular(roundRadius),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: option.toLowerCase() != "custom"
                            ? Text(
                          option,
                          style: textRegularStyle(
                            context,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            isWhiteColor: isSelected,
                          ),
                        ) : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              customQuestionIcon,
                              scale: 1.8,
                            ),
                            AppWidgets().gapW8(),
                            Text(
                              option,
                              style: textRegularStyle(
                                context,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                isWhiteColor: isSelected,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              AppWidgets().gapH12(),
              isCustomSelected ? _getTextField(
                  context,
                  state.questionPageDummyData![index].ques,
                  state.questionPageDummyData![index].ques,
                  state.questionPageDummyData![index].textEditingController,
                  state.questionPageDummyData![index].focusNode,
                  textFieldType: "text",
                  isActive: true,
                  isReadOnly: state.questionPageDummyData![index].textFieldType == "dateField"
                      || state.questionPageDummyData![index].textFieldType == "location" ? true : false
              ) : const SizedBox(),
            ],
          ),

        AppWidgets().gapH12(),
      ],
    );
  }

  _getTextField(BuildContext? context,title,hint,TextEditingController controller,FocusNode? focusNode, {bool? isReadOnly, bool? isActive,String? textFieldType = "text"}) {
    return CustomTextFieldWidget(
        context: context!,
        hint: hint,
        name: title,
        errorText: StringConstants.emailError,
        isPasswordType: false,
        showStar: true,
        keyboardType: KeyboardType.text,
        autoFillEnabled: false,
        controller: controller,
        focusNode: focusNode,
        isReadOnly: isReadOnly!,
        fieldEnable: isActive,
        fillColor: AppColors.whitePure,
        borderColor: AppColors.textFieldBorderColor,
        hasCustomIcon: true,
        showSuffixIcon: true,
        suffixIcon: textFieldType == "location" ? Image.asset(mapPin,scale: 2,) : textFieldType == "dateField" ? Image.asset(calender,scale: 2,) : null,
        onTap: () {
          if(textFieldType == "dateField"){
            printLog("Open date selector");
            _showDateTimePicker(context);
          } else if(textFieldType == "location"){
            printLog("Open location selector");
          }
        },
    );
  }

  void _showDateTimePicker(BuildContext? context) {
    BottomPicker.dateTime(
      bottomPickerTheme: BottomPickerTheme.plumPlate,
      pickerTitle: Text(
        'Set the event exact time and date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      onSubmit: (date) {
        printLog(date);
      },
      onCloseButtonPressed: () {
        printLog('Picker closed');
        Navigator.of(context!).pop();
      },
      dateOrder: DatePickerDateOrder.dmy,
      minDateTime: DateTime.now(),
      maxDateTime: DateTime(DateTime.now().year+5, DateTime.now().month, DateTime.now().day),
      initialDateTime: DateTime.now(),
      // gradientColors: [
      //   Color(0xfffdcbf1),
      //   Color(0xffe6dee9),
      // ],
    ).show(context!);
  }



}
