import 'package:easy_debounce/easy_debounce.dart';

class DebounceHelper{
  static const String textFieldDebounceTag = "textFieldDebounceTag";
  static const String buttonTag = "buttonTag";
  static const String backButtonTag = "backButtonTag";


  debounce({tag,onMethod,time = 500}){
    EasyDebounce.debounce(
        tag,
        Duration(milliseconds: time),
        () => onMethod());
  }

  killDebounce({tag}){
    EasyDebounce.cancel(tag);
  }

  killAllDebounce(){
    EasyDebounce.cancelAll();
  }
}