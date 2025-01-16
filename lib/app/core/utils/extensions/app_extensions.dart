import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// To learn more about [Extension] methods follow https://dart.dev/guides/language/extension-methods
///[Implementing] extension methods
///Use the following syntax to create an extension:
/*
  extension <extension name> on <type> {
  (<member definition>)*
 }
*/

/// Can be used with only [Static] types
/// You can’t invoke extension methods on variables of type [dynamic] but [var].
/// -[ie] dynamic d = '2';
/// print(d.parseInt()); // Runtime exception: [NoSuchMethodError]

/// -[ie] someString.toInt() instead of int.parse(someString)
extension IntParsing on String {
  int toInt() {
    return int.parse(this);
  }
}

/// -[ie] "the quick brown fox".getFirstWord()
/// [output] the
extension GetFirstWord on String {
  String getFirstWord() {
    // return split(' ')[0];// you can get word of sentence by index
    return split(' ').first;
  }
}

extension GetLastWord on String {
  String getLastWord() {
    return split(' ').last;
  }
}

extension FlagImageFromCode on String{
  ///Get the flag image path of a country with the countryCode.
  ///
  ///The code will be converted to lowerCase from the extension and return the path of the asset image.
  ///
  ///Example:
  ///
  ///```dart
  /// "BD".toFlagImagePath;
  ///```
  String get toFlagImagePath => "assets/flags/${this.toLowerCase()}.png";
}

extension GetDateTimeFromDateFormat on String {
  ///Get `DateTime` from Formatted Date.
  ///
  ///returns `null` if parse failed.
  ///
  ///Default format is `yMMMEd`
  DateTime? tryParseDateTime({String? formatPattern}) {
    try {
      if (formatPattern != null)
        return DateFormat(formatPattern).parse(this);
      else
        return DateFormat.yMMMEd().parse(this);
    } catch (e) {
      return null;
    }
  }
}

extension AddCommaOnNumbers on String {
  String addCommaOnNumbers() {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    // RegExp reg = RegExp(r'(\d{\u09E7,\u09E9)(?=(\d{\u09E9)+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    return replaceAllMapped(reg, mathFunc);
  }
}

extension JsonObjectToStringList on String {
  /* String cities = "'NY':true, 'LA':false, 'EA':true, 'WA':false, 'Tokyo':false";
  List<String> nC=cities.split(",");
  for(var v in nC){
  if(v.substring(v.indexOf(":")+1)=="false"){
  print(v.substring(0,v.indexOf(":")));
  }
  }*/

  // Output:
  // 'LA'
  // 'WA'
  // 'Tokyo'
  List<String> getJsonObjectToStringList() {
    List<String> string = split(",");
    List<String> list = [];
    if (kDebugMode) {
      print("other education".toCapitalized());
    }
    for (var v in string) {
      if (v.substring(v.indexOf(":") + 1).contains("false")) {
        String cleanString = (v
                .substring(0, v.indexOf(":"))
                .replaceAll("_", " ")
                .replaceAll("youth", ""))
            .toString();

        if (kDebugMode) {
          print(
              "cleanString: ${cleanString.toUpperCase().toString().substring(2).toLowerCase()}");
        }
        if (cleanString.contains("username") ||
            cleanString.contains("hide mobile") ||
            cleanString.contains("hide address") ||
            cleanString.contains("other aspiration") ||
            cleanString.contains("user type code")) {
        } else {
          list.add(cleanString);
        }
      } else {
        if (kDebugMode) {
          print("getJsonObjectToStringList error");
        }
      }
    }

    return list;
  }
}

extension on Duration {
  String format() => '$this'.split('.')[0].padLeft(8, '0');
}

extension Capitalized on String {
  String toCapitalized() => this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase();
}

extension StringCasingExtension on String {
  String toCapitalizedSentence() => this.length > 0 ? this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase() : '';
// String yourStringModifyingMethod() => write your logic here to modify the string as per your need;
}

extension RestApiTimeStamp on DateTime {
  String toRestApiTimeStamp() {
    final df = DateFormat('yyyyMMddhhmmss');
    return df.format(this);
  }
// String yourStringModifyingMethod() => write your logic here to modify the string as per your need;
}

extension CommonTimeStamp on DateTime {
  String toCommonTimeStamp() {
    final df = DateFormat('dd-MMM-yyyy');
    return df.format(this);
  }
}

extension MaskAccountNumber on String {
  String toMaskedAccountNumber() {

    List<String> parts = this.split('-');

    for (int i = 0; i < parts.length - 1; i++) {
      parts[i] = parts[i].replaceAll(RegExp(r'\d'), 'X');
    }

    return parts.join('-');
  }
}

