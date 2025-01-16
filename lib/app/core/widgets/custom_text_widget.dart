import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/app_style.dart';
import 'app_widgets.dart';

//ignore: must_be_immutable
class CustomTextWidget extends StatelessWidget {

  final bool? showTitle,showBorder,showStar,showLabelSeparate,isTextHint;
  final String? label,text;
  final Color? textColor;

  CustomTextWidget({
    super.key,
    required this.text,
    this.textColor = AppColors.textColor,
    this.showBorder = true,
    this.showTitle = true,
    this.showStar = false,
    this.showLabelSeparate = true,
    this.isTextHint = true,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showLabelSeparate! ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label != "" ? Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Row(
                children: [
                  Text(label ?? "",style: textRegularStyle(context,color: AppColors.blackPure),),
                  showStar ?? false ? AppWidgets().gapW(4) : AppWidgets().gapH(0),
                  showStar ?? false ? Text("*",style: textRegularStyle(context,color: AppColors.warningRed),) : const SizedBox()
                ],
              ),
            ) : AppWidgets().gapH(0),
            label != "" ? AppWidgets().gapH8() : AppWidgets().gapH(0),
          ],
        ) : AppWidgets().gapH(0.0),

        Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: showBorder! ? AppColors.textGrayShade4 : AppColors.transparentPure,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(text ?? "",textAlign: TextAlign.start,style: textRegularStyle(context,color: isTextHint! ? AppColors.textGray : textColor),),
          )
        ),
      ],
    );
  }
}
