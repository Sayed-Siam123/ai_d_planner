import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor, {String? failedColor}) {
    try{
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      return int.parse(hexColor, radix: 16);
    }catch(e){
      return int.parse( failedColor?? "FFFFFFFF", radix: 16);
    }
  }

  HexColor(final String? hexColor,{final String? failedColor})
      : super(_getColorFromHex(hexColor ?? "#FFFFFF", failedColor: failedColor));
}
