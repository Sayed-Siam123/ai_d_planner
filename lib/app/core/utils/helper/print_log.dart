import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// [Level]s to control logging output. Logging can be enabled to include all
/// levels above certain [Level].
///
const showAllDebug = true;
const singleKey = "112324";


var logger = Logger(
  filter: kReleaseMode ? ProductionFilter() : DevelopmentFilter(),
  printer: PrettyPrinter(
      printEmojis: true,
      printTime: true
    )
);

var loggerTrace = Logger(
  level:  Level.trace,
  filter: kReleaseMode ? ProductionFilter() : DevelopmentFilter(),
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
    printTime: true,
    levelColors: {
      Level.trace : const AnsiColor.fg(214)
    }
  )
);

//todo change level to enum
printLog(massage, {String level = "i", key = "1"}) {
  // verbose,
  // debug,
  // info,
  // warning,
  // error,
  // wtf,
  // nothing,
  if (kDebugMode) {
    if (showAllDebug && singleKey != key) {
      switch (level) {
        case "t":
          {
            loggerTrace.t("\$\$\$\$\$$massage\$\$\$\$\$");
          }
          break;

        case "i":
          {
            logger.i("-----$massage-----");
          }
          break;

        case "w":
          {
            logger.w(massage);
          }
          break;

        case "e":
          {
            logger.e(massage);
          }
          break;
        case "d":
          {
            logger.d(massage);
          }
          break;
        case "f":
          {
            logger.f(massage);
          }
          break;

        default:
          {
            logger.d(massage);
          }
          break;
      }
    }
  }
}
