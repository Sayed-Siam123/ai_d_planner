import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_bloc.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_bloc.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/utils/helper/print_log.dart';

questionsDI(GetIt? getIt){
  getIt?.registerLazySingleton<QuestionPageBloc>(() {
    printLog("registerLazySingleton: QuestionPageBloc",level: "t");
    return QuestionPageBloc();
  });
}