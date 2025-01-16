import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceID{
  static Future<String?> getDeviceId() async {
    String? deviceID = "";

    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceID = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.id; // unique ID on Android
    }

    return deviceID;
  }
}