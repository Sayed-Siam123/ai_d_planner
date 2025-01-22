import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryColorValue = 0xFF240DFF; //primaryColor
  ///primarySwatch [must] contain all shades(50-900).
  static const MaterialColor colorPrimarySwatch = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFBCCBE),
      200: Color(0xFFED967B),
      300: Color(0xFFF4734B),
      400: Color(0xFFEA6222),
      500: Color(_primaryColorValue),
      600: Color(0xFFFF5722),
      700: Color(0xFFFF440B),
      800: Color(0xFFE53500),
      900: Color(0xFFE32B0A),
    },
  );


  static const primaryColor = Color(0xFF55355C);
  // static const primaryColor = Color(0xFFD70365);

  //primaryColor.withOpacity(0.7) --> splash, authentication

  static const homeViewStatusBarColor = Color(0xFFEEE7F3);
  var primaryColorWithOpacity = const Color(0xFF076839).withOpacity(0.8);
  static const primaryAccentColor = Color(0xFF883C90);
  static const primaryLiteColor = Color(0xFF563078);
  static const secondaryColor = Color(0xFFC02231);
  static const backgroundColor = Color(0xFFF9F9F9);
  static const backgroundColorNew = Color(0xFFE2ECF4);
  static const accentColor = Color(0xFF703E97);
  static const errorColor = Color(0xFFED3675);
  static const timeOutColor = Color(0xFFFB2828);
  static const transparent = Color(0x00bd4efe);
  static final transparentPure = Colors.white.withOpacity(0.0);

  /// tour
  static const gradientColor1 = Color(0xFFC5E3FF);
  static const gradientColor2 = Color(0xFF155EEF);
  static const downloadBackgroundColor = Color(0xFFE0EBFF);
  static const vacationBackgroundColor = Color(0xFF548AF5);

  static const tabBarBg = Color(0xFFF6F9FF);
  static const borderColor = Color(0xFFB3CBFA);
  static const textFieldBorderColor = Color(0xFFEDEDED);

  static const greenBgColor = Color(0xFFEBFAD9);
  ///Core Color
  static const coreWidgetColor = Color(0xFF533F5A);
  static const termsColor = Color(0xFFEC662A);

  static const textColorGrey = Color(0xFF7E7E7E);
  static const textColorLiteGreen = Color(0xFF179848);
  static const textLiteGrey = Color(0xFF6A6A6A);
  static const liteBorderColor = Color(0xFFEEEEEE);
  static const tableHeaderColor = Color(0xFFF8F8F8);

  static const flightFilterSelectedColor = Color(0xFF0050F0);
  static const flightSearchBackgroundColor = Color(0xFFDEE6F2);
  //text color
  static const textColor = Color(0xFF3D3D3D);
  static const appBarTitleTextColor = Color(0xFF1D1D1D);
  static const textGray = Color(0xFF727272);
  static const bgGray = Color(0xFFeef2f8);
  static const textGrayShade2 = Color(0xFF444444);
  static const textGrayShade3 = Color(0xFF333333);
  static const textGrayShade4 = Color(0xFFE0E0E0);
  static const textGrayShade5 = Color(0xFFBBBBBB);
  static const textGrayShade6 = Color(0xFF949494);
  static const textGrayShade7 = Color(0xFF828282);

  static const textGreen = Color(0xFF12A84F);
  static const textGreenNew = Color(0xFF598F17);
  static const textYellow = Color(0xFFFFA800);
  static const textRed = Color(0xFFFF001D);
  static const deepBlue = Color(0xFF022C82);
  static const textBlue = Color(0xFF0054A6);

  static const dividerColor = Color(0xFFE5ECF9);

  static const purple = Color(0xFF5C3BFF);
  static const purpleDark = Color(0xFF000F9A);
  static const black = Color(0xFF091C32);
  static const blackPure = Color(0xFF000000);
  static const white = Color(0xFFF8F8F8);
  static const whitePure = Color(0xFFFFFFFF);
  static const gray = Color(0xFF52596E);
  static const grayDark = Color(0xFFD9D9D9);
  static const liteGray = Color(0xFFD9D9D9);
  static const grayDot = Color(0xffAFAFAF);
  static const liteGrayShadow = Color(0xFF60606040);
  static const countryPicker = Color(0xFFF2F9F9);
  static const liteGrayStepLine = Color(0xFF8FAABB);
  static const inputColor = Color(0x8052596E); //alpha 50%
  static const wrong = Color(0xFFC20707);
  static const green = Color(0xFF35C141);
  static const liteGreen = Color(0xFF56C674);
  static const darkGreen = Color(0xFF006A4D);
  static const liteShadow = Color(0xFF74747440);
  static const liteGreenBG = Color(0xFFC6F6D5);
  static const red = Color(0xFFFF1F00);
  static const darkRed = Color(0xFFC20707);
  static const infoBoxColor = Color(0xFFF5F9FF);
  static const warningRed = Color(0xFFF30C0C);
  static const timerColor = Color(0xFFFCD12A);
  static const orangeLite = Color(0xFF4D7BB7);
  static const yellow = Color(0xFFFFBD0D);
  static const orange = Color(0xFFFF7A0D);
  static const blue = Color(0xFF1DA1FF);

  static const selectedColor = Color(0xFF1F54C7);

  static const headerTextColor = Color(0xFF172B4D);
  static const appBarTextColor = Color(0xFF000000);
  static const underlineColor = Color(0xFFCCCCCC);
  static const textColorBlue = Color(0xFF2E38B6);
  static const fieldColor = Color(0xFFBFCEFF);
  static const questionListBackgroundColor = Color(0xFFF2F7F6);

  static const listBackgroundColor = Color(0xFFF7F7F7);
  static const listStrokeColor = Color(0xFFDDDDDD);
  static const listStrokeColorDark = Color(0xFFC3C3C3);

  /// [pie chart] color
  static const problemSolvingColor = Color(0xff9779FF);
  static const liteBlueColor = Color(0xff597df1);
  static const communicationSkillsColor = Color(0xff5C3BFF);

  static const gradientLeftColor = Color(0xB8FF0D0D);
  static const gradientRightColor = Color(0xFFFFBD0D);

  static const shimmerBaseColor = Color(0xFFD9D9D9);
  static const shimmerHighlightColor = Color(0xFFF6F6F6);

  static const dividerColor1 = Color(0xFFE0E0E0);
  static const dividerColor2 = Color(0xFFBDBDBD);
  static const dividerColor3 = Color(0xFFDDE1E8);
  static const orange1 = Color(0xFFF08100);
  static const tourTitleColor = Color(0xFF2B2B2D);
  static const tourDetailsColor = Color(0xFF666666);
  static const visaBookingTextColor = Color(0xFF403F3F);
  static const visaBookingButtonColor = Color(0xFFE2F0D9);
  static const visaBookingRejectedButtonColor = Color(0xFFffe5ee);
  static const visaBookingButtonTextColor = Color(0xFF507D2A);
  static const visaBookingRejectedButtonTextColor = Color(0xFFED3675);
  static const liteTextColor = Color(0xFF747474);
  static const cancelBackgroundColor = Color(0xFFFFECF2);
  static const profileHeaderBackgroundColor = Color(0xFFDBDEFF);

  static const unSelectedColor = Color(0xFFECECEC);

  static const bottomNavUnselectedColor = Color(0xFF9A9A9A);


//#F08100
  // Gradient
  static final whiteToTransparentGradient = LinearGradient(
    colors: [primaryLiteColor, primaryLiteColor,  primaryLiteColor.withOpacity(0.0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ); // Gradient
  static final accentColorToTransparentGradient = LinearGradient(
    colors: [
      Colors.white.withOpacity(0.0),
      accentColor.withOpacity(.9),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static final whiteToTransparentGradientHome = LinearGradient(
    colors: [
      Colors.white.withOpacity(0.0),
      accentColor.withOpacity(.5),
      accentColor
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const baseGradient = LinearGradient(
    colors: [
      gradientLeftColor,
      gradientRightColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const baseGradient2 = LinearGradient(
    colors: [
      gradientLeftColor,
      gradientRightColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const buttonGradient = RadialGradient(
    center: Alignment(-0.2, -1.620),
    radius: 2,
    colors: [
      primaryColor,
      primaryAccentColor,
      secondaryColor,
    ],
  );
  static const btnBGGradient = LinearGradient(
    colors: [
      Color(0xFF00A299),
      Color(0xFF0EB9AF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
