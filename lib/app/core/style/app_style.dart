import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/local_constants.dart';
import 'app_colors.dart';


enum LanguageSelect{
  gilroy,
  kalnia
}

//inter
TextStyle textHeaderStyle(context,
    {color = AppColors.headerTextColor,
    double fontSize = 30, isShadowRequired = false,
    fontWeight = FontWeight.w600}) {

  var isBangla = EasyLocalization.of(context)!.locale.toString() == LocalConstants.bdLocalCode ? true : false;

  return GoogleFonts.anekBangla(
      shadows: isShadowRequired ? [
        Shadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(15, 15),
            blurRadius: 15),
      ] : [],
      fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

TextStyle textAppBarStyle(
    {color = AppColors.appBarTextColor,
    double fontSize = 14,isShadowRequired = false,
    fontWeight = FontWeight.w600,
    bool isGrayColor = false}) {
  return GoogleFonts.anekBangla(
      fontSize: fontSize.sp,
      color: isGrayColor ? AppColors.gray : color,
      shadows: isShadowRequired ? [
        Shadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(15, 15),
            blurRadius: 15),
      ] : [],
      fontWeight: fontWeight);
}

TextStyle textRegularStyle(
    context,{color = AppColors.textColor,
    double fontSize = 14,
      isShadowRequired = false,
    fontWeight = FontWeight.normal,
    bool isGrayColor = false,
    bool isWhiteColor = false,
    double? height,
    TextDecoration? decoration,
    LanguageSelect languageSelect = LanguageSelect.gilroy
    }) {
  return TextStyle(
    shadows: isShadowRequired ? [
      Shadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(15, 15),
          blurRadius: 15),
    ] : [],
    fontSize: fontSize,
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
        ? AppColors.gray
        : color,
    fontWeight: fontWeight,
    decoration: decoration,
    height: height,
    decorationColor: color,
    fontFamily: languageSelect == LanguageSelect.gilroy ? 'Gilroy' : 'Kalnia',
    // fontFamilyFallback: ['Gilroy']
    //height: needHeight ? 1.0 : 0.0
  );
}


TextStyle textRegularForLanguageShowStyle(
    context,{color = AppColors.textColor,
      double fontSize = 13,
      isShadowRequired = false,
      fontWeight = FontWeight.normal,
      bool isGrayColor = false,
      bool isWhiteColor = false,
      double? height,
      TextDecoration? decoration,
    }) {

  var isBangla = EasyLocalization.of(context)!.locale.toString() == LocalConstants.bdLocalCode ? true : false;

  return !isBangla ? GoogleFonts.tiroBangla(
    shadows: isShadowRequired ? [
      Shadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(15, 15),
          blurRadius: 15),
    ] : [],
    fontSize: (fontSize+1.0),
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
        ? AppColors.gray
        : color,
    fontWeight: fontWeight,
    decoration: decoration,
    height: height,
    decorationColor: color,
    //height: needHeight ? 1.0 : 0.0
  ) : GoogleFonts.inter(
    shadows: isShadowRequired ? [
      Shadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(15, 15),
          blurRadius: 15),
    ] : [],
    fontSize: (fontSize+1.0),
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
        ? AppColors.gray
        : color,
    fontWeight: fontWeight,
    decoration: decoration,
    height: height,
    decorationColor: color,
    //height: needHeight ? 1.0 : 0.0
  );
}
TextStyle textStyleTourWithLineThrough(
    {color = AppColors.red,
    double fontSize = 10, isShadowRequired = false,
    fontWeight = FontWeight.normal,
    bool isGrayColor = false,
    bool isWhiteColor = false}) {
  return GoogleFonts.anekBangla(
    shadows: isShadowRequired ? [
      Shadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(15, 15),
          blurRadius: 15),
    ] : [],
    fontSize: fontSize.sp,
    color: isWhiteColor
        ? AppColors.white
        : isGrayColor
            ? AppColors.gray
            : color,
    fontWeight: fontWeight,
    decoration: TextDecoration.lineThrough,
    decorationColor: color,
  );
}

TextStyle textButtonStyle(
    {color = AppColors.white,
    double fontSize = 18,
      isShadowRequired = false,
    fontWeight = FontWeight.w600}) {
  return GoogleFonts.anekBangla(
      shadows: isShadowRequired ? [
        Shadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(15, 15),
            blurRadius: 15),
      ] : [],
      fontSize: fontSize.sp, color: color, fontWeight: fontWeight);
}

final hintStyle = GoogleFonts.anekBangla(
    fontSize: 14.sp, color: AppColors.textGrayShade4, fontWeight: FontWeight.w500);

/// specifically for Auth text fields.
final smallHintStyle = GoogleFonts.anekBangla(
    fontSize: 12.sp, color: AppColors.textGrayShade4, fontWeight: FontWeight.w500);