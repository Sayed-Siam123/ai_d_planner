import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../constants/local_constants.dart';

class DateTimeHelper {
  DateTime getDateOfYearAndMonth(int year, int month) {
    String dateStr = "$year-$month-${getDaysInMonth(year, month)}";
    return DateTime.parse(dateStr);
  }

  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }

  String getCurrentDate(
      {isWeekDayNameOnly = false,
      dateTime,
      isDateOnly = true,
      isPrevDate = false,
      isNextDate = false}) {
    if (isWeekDayNameOnly) {
      return DateFormat('EEEE').format(DateTime.now());
    } else if (isDateOnly) {
      var dateTime = isPrevDate
          ? DateTime.now().subtract(const Duration(days: 1))
          : isNextDate
              ? DateTime.now().add(const Duration(days: 1))
              : DateTime.now();
      return DateFormat('dd MMM, yyyy').format(dateTime);
    }
    return DateFormat('EE, dd MMM, yyyy').format(DateTime.now());
  }

  String getFormattedDate(dateTime) {
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  String getFullFormattedDate(dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String getFlightFormattedDate(dateTime) {
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  String getFormattedTime(context,dateTime) {
    return DateFormat('hh.mm a',LocalConstants.getCurrentLocale(context)).format(dateTime);
  }

  String getFlightFormattedTimeForCalculation(dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  String calculateTimeDuration(String startTime, String endTime) {
    List<String> startParts = startTime.split(':');
    List<String> endParts = endTime.split(':');

    int startHour = int.parse(startParts[0]);
    int startMinute = int.parse(startParts[1]);

    int endHour = int.parse(endParts[0]);
    int endMinute = int.parse(endParts[1]);

    int durationHour;
    int durationMinute;

    if (endMinute >= startMinute) {
      durationHour = endHour - startHour;
      durationMinute = endMinute - startMinute;
    } else {
      durationHour = endHour - startHour - 1;
      durationMinute = 60 - startMinute + endMinute;
    }

    // printLog('Duration: $durationHour hour(s) $durationMinute minute(s)');

    String totalTime = "";

    if (durationHour == 0) {
      totalTime = '$durationMinute min';
    } else if (durationMinute == 0) {
      totalTime = '$durationHour hr';
    } else {
      totalTime = '$durationHour hr $durationMinute min';
    }
    return totalTime;
  }

  /* bool isSpecificDayPeriod({required DepartureTime departureTimeType, required String datetime}) {
    var hour = DateTime.parse(datetime).hour;
    if (departureTimeType == DepartureTime.all) {
      if (kDebugMode) {
        debugPrint('all ${hour}');
      }
      return true;
    } else if (departureTimeType == DepartureTime.morning &&
        hour > 6 &&
        hour < 12) {
      if (kDebugMode) {
        debugPrint('m');
      }
      return true;
    } else if (departureTimeType == DepartureTime.afterNoon &&
        hour > 12 &&
        hour < 18) {
      if (kDebugMode) {
        debugPrint('af');
      }
      return true;
    } else if (departureTimeType == DepartureTime.evening &&
        hour > 18 &&
        hour < 24) {
      if (kDebugMode) {
        debugPrint('e');
      }
      return true;
    } else if (departureTimeType == DepartureTime.night &&
        hour > 00 &&
        hour < 6) {
      if (kDebugMode) {
        debugPrint('n');
      }
      return true;
    }
    return false;
  }*/

  num? getDateSpecificMin(departure, arrival) {
    DateTime departureTime = DateTime.parse(departure.toString());
    DateTime arrivalTime = DateTime.parse(arrival.toString());

    Duration diff = arrivalTime.difference(departureTime);

    return diff.inMinutes;
  }

  minuteToHourMinuteConversion(num? minutes) {
    num? hours = minutes! ~/ 60;
    num? remainingMinutes = minutes % 60;

    if (hours != 0) {
      return "${hours}h ${remainingMinutes > 9 ? remainingMinutes : "0$remainingMinutes"}m";
    } else {
      return "${remainingMinutes > 9 ? remainingMinutes : "0$remainingMinutes"}m";
    }
  }

  webTimeFormatWithTAndZ(DateTime? time) {
    DateTime date = DateTime.utc(time!.year, time.month, time.day, time.hour, time.minute, time.second);
    return date.toIso8601String();
  }

  String convertDateFormatShareTripStyle(String inputDate) {
    // Parse the input date
    DateTime parsedDate = DateFormat("dd MMM yyyy").parse(inputDate);

    // Format the date as "dd MMM 'yy"
    String formattedDate = DateFormat("dd MMM''yy").format(parsedDate);

    return formattedDate;
  }

  static isBeforeDate({DateTime? fromDate, DateTime? toDate}){
    bool? status = false;
    if(toDate!.isBefore(fromDate!)){
      status = true;
    }

    return status;
  }
}
