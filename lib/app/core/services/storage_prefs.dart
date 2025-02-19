import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/helper/print_log.dart';

class StoragePrefs{

  //storage box name
  static const String auth = "user_value";

  //storage keys name
  static const String getStartedQues = "get_started_ques";
  static const String getStartedStatus = "get_started_status";

  // static final box = GetStorage(auth);


  static Future<String?> get(String? key,{boxName = auth}) async{

    late Box box;
    box = await initiateBox(boxName);

    var name = box.get('$key');
    return name.toString();
  }

  static set(String? key,value,{boxName = auth}) async{

    late Box box;
    box = await initiateBox(boxName);

    await box.put('$key', '$value');
  }

  static deleteByKey(String? key,{boxName = auth}) async{

    late Box box;
    box = await initiateBox(boxName);

    await box.delete('$key');
  }

  static clearAllFromBox({boxName = auth}) async{

    late Box box;
    box = await initiateBox(boxName);

    await box.deleteFromDisk();
  }

  static showAllDataInTheBox({boxName = auth}) async{
    Map mapData = {};
    late Box box;
    box = await initiateBox(boxName);

    for(int i = 0; i<box.values.length; i++){
      mapData.addAll({
        box.keys.elementAt(i).toString() : box.values.elementAt(i).toString()
      });
    }

    return mapData;

  }

  static Future<bool>? hasData(String? key,{boxName = auth}) async{
    bool result = false;
    late Box box;

    box = await initiateBox(boxName);

    if(box.get(key!) != null){
      result = true;
    } else{
      result = false;
    }

    return result;
  }

  static deleteBox({boxName = auth}) async{
    await Hive.deleteBoxFromDisk(boxName);
  }

  static initiateBox(boxName) async{
    late Box box;
    if(!Hive.isBoxOpen(boxName)){
      // printLog("Box is not opened, Opening Box");
      box = await Hive.openBox(boxName);
      // printLog("Box is opened");
    } else{
      // printLog("Box is already opened");
      box = Hive.box(boxName);
    }

    return box;
  }
}