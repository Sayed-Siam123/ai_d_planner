import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_bloc.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/helper/print_log.dart';

questionFlowDI(GetIt? getIt){
  getIt?.registerLazySingleton<QuestionFlowBloc>(() {
    printLog("registerLazySingleton: QuestionFlowBloc",level: "t");
    return QuestionFlowBloc();
  });
}