import 'dart:io';
import 'dart:math';

import 'package:ai_d_planner/app/core/utils/extensions/app_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../binding/central_dependecy_injection.dart';
import '../../style/app_colors.dart';
import '../../widgets/app_widgets.dart';

class AppHelper {
  late SharedPreferences prefs;

  saveStringPref(String key, String value) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getStringPref(String key) async {
    prefs = await SharedPreferences.getInstance();
    String? mPrefs = prefs.getString(key);
    return mPrefs;
  }

  showLoader({bool dismissOnTap = true,hasMask = false}) {
    EasyLoading.instance
      // ..indicatorWidget = Container(
      //   height: 120,
      //   width: 120,
      //   color: Colors.transparent,
      //   padding: EdgeInsets.zero,
      //   margin: EdgeInsets.zero,
      //   child: Lottie.asset('assets/lottie/mobileloader.json',
      //       height: 120, width: 120, fit: BoxFit.fill),
      // )
      // ..loadingStyle = EasyLoadingStyle.custom

      ..indicatorType = EasyLoadingIndicatorType.foldingCube
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = Colors.white
      ..indicatorColor = AppColors.primaryColor
      ..maskType = hasMask ? EasyLoadingMaskType.black : EasyLoadingMaskType.clear
      ..maskColor = Colors.transparent
      ..backgroundColor = hasMask ? AppColors.whitePure : AppColors.transparentPure
      ..boxShadow = []
      ..contentPadding = const EdgeInsets.all(30)
      ..radius = 5
      ..animationDuration = const Duration(milliseconds: 200)
      ..indicatorSize = 50.0
      ..userInteractions = false
      ..dismissOnTap = dismissOnTap;

    // EasyLoading.instance
    //   ..displayDuration = const Duration(milliseconds: 2000)
    //   ..indicatorType = EasyLoadingIndicatorType.foldingCube
    //   ..loadingStyle = EasyLoadingStyle.custom
    //   ..indicatorSize = 45.0
    //   ..radius = 10.0
    //   ..progressColor = Colors.yellow
    //   ..backgroundColor = Colors.white
    //   ..indicatorColor = AppColors.primaryColor
    //   ..textColor = Colors.yellow
    //   ..maskType = EasyLoadingMaskType.black
    //   ..maskColor = Colors.blue.withOpacity(0.5)
    //   ..userInteractions = true
    //   ..dismissOnTap = true;

    return EasyLoading.show();
  }

  hideLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    // Navigator.of(context, rootNavigator: true).pop();
  }

  String minutesToHourMinutes(Duration duration) {
    var date = duration.toString().split(":");
    var hrs = date[0];
    var mns = date[1];
    var sds = date[2].split(".")[0];
    return hrs.toInt() == 0 ? "${mns}m" : "${hrs}h ${mns}m";
  }

  String getDayNameAndDateYearOnly(DateTime dateTime) {
    //Input: "2022-11-14 12:15:20"
    //Output: "12:15"
    return DateFormat('dd MMMM yyyy, EEEE').format(dateTime);
  }

  timeDifference({expiredTime}) {
    final expiredTimeData = DateTime.parse(expiredTime);
    final todayTime = DateTime.now();
    final difference = expiredTimeData.difference(todayTime).inMinutes;
    return difference;
  }

  timeDifferenceBetweenTwoTime({from, to}) {
    final fromTimeData = DateTime.parse(from);
    final toTimeData = DateTime.parse(to);
    final difference = toTimeData.difference(fromTimeData).inDays;
    return difference;
  }

  getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  hideKeyboard(context) {
    // FocusManager.instance.primaryFocus?.unfocus();
    FocusScopeNode currentFocus = FocusScope.of(context!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  hideKeyboardWithSystemChannel() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  bool isKeyBoardVisible(context) {
    //return MediaQuery.of(context).viewInsets.bottom > 0 ? true : false;
    return WidgetsBinding.instance.window.viewInsets.bottom > 0.0 ? true : false;
  }

  String getFormattedDateOnly(DateTime dateTime,
      {isWeekDayNameOnly = false,
      isDateOnly = true,
      isDayNameAndDateOnly = false}) {
    if (isWeekDayNameOnly) {
      return DateFormat('EEEE').format(dateTime);
    } else if (isDateOnly) {
      return DateFormat('dd MMM, yyyy').format(dateTime);
    } else if (isDayNameAndDateOnly) {
      return DateFormat('EEEE').format(dateTime);
    }
    return DateFormat('EE, dd MMM, yyyy').format(dateTime);
  }

  dateFormatter(date) {
    var dateFormat = DateTime.parse(date.toString());
    return DateFormat("dd MMM yy, EEE").format(dateFormat);
  }

  timeFormatter(date) {
    var dateFormat = DateTime.parse(date.toString());
    return DateFormat.Hm().format(dateFormat);
  }

  String getDayAndMonthOnly(DateTime dateTime) {
    return DateFormat('dd MMM, yy').format(dateTime);
  }

  String getDayNameOnly(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  scrollFlightListToTop(scrollController) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

/*
  pickImageFromDevice({isCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = isCamera
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);
    return image?.path ?? null;
  }
*/

  String durationListToFormattedHour(List<String> durationList,
      {bool isSecondNeeded = false}) {
    // List<String> dList = ['1d0h20m','1d46m', '1d2h','1h0m', '20m', '1h', '20m', '20m'];

    List<String> dList = durationList;
    int totalSeconds = 0;
    for (var duration in dList) {
      final daysMatch = RegExp(r'(\d+)d').firstMatch(duration);
      final hoursMatch = RegExp(r'(\d+)h').firstMatch(duration);
      final minutesMatch = RegExp(r'(\d+)m').firstMatch(duration);

      final days = daysMatch != null ? int.parse(daysMatch.group(1)!) : 0;
      final hours = hoursMatch != null ? int.parse(hoursMatch.group(1)!) : 0;
      final minutes =
          minutesMatch != null ? int.parse(minutesMatch.group(1)!) : 0;

      totalSeconds += (days * 86400) + (hours * 3600) + (minutes * 60);
    }

    Duration duration = Duration(seconds: totalSeconds);
    var date = duration.toString().split(":");
    var hrs = date[0];
    var mns = date[1];
    var sds = date[2].split(".")[0];
    /*return isSecondNeeded
        ? "$totalSeconds"
        : hrs.toInt() == 0
            ? "${mns}m"
            : "${hrs}h ${mns}m"; */

    return isSecondNeeded
        ? "$totalSeconds"
        : convertSecondsToDayHourMinutes(duration.inSeconds);
  }

  String convertSecondsToDayHourMinutes(int totalSeconds) {
    int days = totalSeconds ~/ (24 * 3600);
    int remainingSeconds = totalSeconds % (24 * 3600);
    int hours = remainingSeconds ~/ 3600;
    remainingSeconds %= 3600;
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;

    print('$totalSeconds seconds is equal to '
        '$days days, $hours hours, $minutes minutes, and $seconds seconds.');
    return '${days < 1 ? "" : days.toString() + "d"} ${hours < 1 ? "" : hours.toString() + "h"} ${minutes < 1 ? "" : minutes.toString() + "m"}';
  }

  String calculateTotalTime(List<String> dList) {
    //Input
    // List<String> dList = ['1d0h20m', '1d30m', '1d2h', '1h0m', '20m', '21h', '20m', '20m'];

    //Output
    //Total Time: 4d1h50m
    int totalDays = 0, totalHours = 0, totalMinutes = 0;

    for (String duration in dList) {
      int days = 0, hours = 0, minutes = 0;

      RegExp exp = RegExp(r'(\d+)d');
      RegExpMatch? match = exp.firstMatch(duration);
      if (match != null) {
        days = int.parse(match.group(1)!);
      }

      exp = RegExp(r'(\d+)h');
      match = exp.firstMatch(duration);
      if (match != null) {
        hours = int.parse(match.group(1)!);
      }

      exp = RegExp(r'(\d+)m');
      match = exp.firstMatch(duration);
      if (match != null) {
        minutes = int.parse(match.group(1)!);
      }

      totalDays += days;
      totalHours += hours;
      totalMinutes += minutes;
    }

    totalHours += totalMinutes ~/ 60;
    totalMinutes %= 60;
    totalDays += totalHours ~/ 24;
    totalHours %= 24;

    // return '$totalDays' 'd' '$totalHours' 'h' '$totalMinutes' 'm';
    return "${totalDays == 0 ? "" : totalDays.toString() + "d "}${totalHours == 0 ? "" : totalHours.toString() + "h "}${totalMinutes == 0 ? "" : totalMinutes.toString() + "m"} ";
  }

  String get12HourTime(String timeStamp24HR) {
    //Input: "2022-11-14 12:15:20"
    //Output: "12:15"
    return DateFormat.jm().format(DateTime.parse(timeStamp24HR));
  }

  String getDayNameAndDateOnly(DateTime dateTime) {
    //Input: "2022-11-14 12:15:20"
    //Output: "12:15"
    return DateFormat('EEEE, dd MMM').format(dateTime);
  }

  getPhoneNumber({String? number}) {
    var getNumber = number;
    var numbers = number!.split("");
    if (numbers[0] == "1") {
      getNumber = "0" + number;
    } else {
      getNumber = number;
    }

    if (getNumber.isEmpty) {
      return "";
    } else {
      return getNumber;
    }
  }

  showNoInternetSnackbar(context) {
    AppWidgets().getSnackBar(title: "Info", message: "No Internet Connection", animationDuration: 5);
  }

  ///Check if the given `phoneNo` is valid for BD region
  ///
  /// if validation fails it will return `false`
  ///
  /// or else it will return `true`
  static bool numberCheckBD({required String phoneNo}) {
    if (phoneNo.startsWith("+8800")) return false;
    if (!phoneNo.startsWith("+8801")) return false;
    if (phoneNo.length != 14) return false;

    return true;
  }

  ///This function returns download directory for iOS and android.
  ///
  ///This function also handles android version specific permission.
  /*static Future<Directory?> getDownloadDirectory() async {
    if (Platform.isIOS) return getApplicationDocumentsDirectory();

    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    bool isAndroidX = int.parse(deviceInfo.version.release) > 10;

    if (!isAndroidX && !await Permission.storage.isGranted) {
      await Permission.storage.request();
    }

    if (!isAndroidX &&
        (await Permission.storage.isDenied ||
            await Permission.storage.isPermanentlyDenied)) {
      Fluttertoast.showToast(msg: "Storage permission is not given");
      return null;
    }

    String _localPath = '/storage/emulated/0/Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    return savedDir;
  }*/

  ///This function shows a dropdown like options but in bottom sheet.
  ///
  ///This is a customized bottomsheet picket.
  static Future<String?> showAppDropdown({
    required List<String> items,
    required BuildContext context,
    String? selectedValue,
    ValueChanged<String>? onChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 10,
      isDismissible: true,
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppWidgets().gapH8(),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.liteGray,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              AppWidgets().gapH(14),
              Text(
                "Tap on an item to select",
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
              AppWidgets().gapH8(),
              Divider(),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${items[index]}"),
                    leading: Icon(
                      items[index] == selectedValue
                          ? Icons.radio_button_checked
                          : Icons.circle_outlined,
                      color: items[index] == selectedValue
                          ? AppColors.primaryColor
                          : AppColors.black,
                    ),
                    onTap: () {
                      if (onChanged != null) onChanged(items[index]);
                      Navigator.pop(context);
                    },
                    visualDensity: VisualDensity.compact,
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  get24HourTime(String timeStamp) {
    return DateFormat("hh:mm").format(DateTime.parse(timeStamp));
  }

  systemOverlayStyle({color = AppColors.primaryColor,navBarColor = AppColors.whitePure, isDarkBrightness = false}){
    return SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarBrightness: isDarkBrightness ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: isDarkBrightness ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: navBarColor,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  /*openWhatsapp() async {
    var whatsappUrl = "whatsapp://send?phone=+8801701208389" +
        "&text=${Uri.encodeComponent("")}";
    try {
      if (await launch(whatsappUrl)) {
        launch(whatsappUrl);
      } else {
        AppWidgets()
            .getSnackBar(title: "Info", message: "Install Whatsapp to inbox");
      }
    } catch (e) {
      AppWidgets()
          .getSnackBar(title: "Info", message: "Install Whatsapp to inbox");
    }
  }*/

  String ordinalNumberSuffixHelper(int num) {
    return ["st", "nd", "rd", "th", "th", "th", "th", "th", "th"][num];
  }

  int findLowestNumber(List<int> numbers) {
    if (numbers.isEmpty) {
      throw ArgumentError('The array cannot be empty.');
    }

    return numbers
        .reduce((value, element) => value < element ? value : element);
  }


  void validateForm(List<TextEditingController> controllers, List<FocusNode>focuses){
    for(var element in controllers){
      if(element.text.isEmpty){
        focuses[controllers.indexOf(element)].requestFocus();
        return;
      }
    }
  }

  Future<void> copyToClipboard(context,String text) async {
   await Clipboard.setData(ClipboardData(text: text));
   AppWidgets().getSnackBar(title: "Info", message: "Copied to clipboard");
  }

  changeLocal(context,locale){
    EasyLocalization.of(context)!.setLocale(locale);
  }

  int roundToMultiple(int n, int multiple) {
    assert(n >= 0);
    assert(multiple > 0);
    return (n + (multiple ~/ 2)) ~/ multiple * multiple;
  }

  int roundToMostSignificantDigit(int n) {
    assert(n >= 0);

    var data = n;
    var numDigits = n.toString().length;

    if(numDigits >= 5){
      var magnitude = pow(4, numDigits - 4) as int;
      data = roundToMultiple(n, magnitude);
    }
    return data;
  }

  static appExitMethod(){
    Navigator.of(AppWidgets().globalContext).pop();
    if(Platform.isAndroid){
      SystemNavigator.pop();
    }
    else if(Platform.isIOS){
      // FlutterAppMinimizer.minimize();
    }
  }

  Future<void> urlLaunch(String? url,{errorMessage = "Error launching the url!"}) async {

    Uri url0 = Uri.parse(url.toString());

    if (!await launchUrl(url0)) {
      AppWidgets().getSnackBar(status: SnackBarStatus.error,message: errorMessage);
    }
  }

}
