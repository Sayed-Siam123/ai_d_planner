import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalConstants{
  static Locale en = const Locale("en","US");
  static Locale bn = const Locale("bn","BD");

  static const bdLocalCode = "bn_BD";
  static const enLocalCode = "en_US";

  static getCurrentLocale(context){
    return EasyLocalization.of(context)!.currentLocale!.languageCode;
  }

}