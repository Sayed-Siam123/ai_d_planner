import 'package:get_it/get_it.dart';

import '../core/connection_manager/binding/network_dependecy_injection.dart';

GetIt getIt = GetIt.instance;

dependencySetup() async{
  await networkSetup(getIt);
}

isRegistered({object}){
  return getIt.isRegistered(instance: object);
}

unregister({object}){
  return getIt.unregister(instance: object);
}