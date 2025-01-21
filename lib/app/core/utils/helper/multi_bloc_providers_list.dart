import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_bloc.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_bloc.dart';
import 'package:ai_d_planner/app/services/bottom_nav_state/bloc/bottom_nav_cubit.dart';
import 'package:ai_d_planner/app/services/password_obscure_operation/bloc/password_obscure_ops_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../../binding/central_dependecy_injection.dart';
import '../../connection_manager/internet_cubit/internet_cubit.dart';

final List<SingleChildWidget> multiBlocProvidersList  = [
    BlocProvider<InternetCubit>(
      create: (context) => getIt<InternetCubit>(),
    ),
    BlocProvider<PasswordObscureCubit>(
      create: (context) => getIt<PasswordObscureCubit>(),
    ),
    BlocProvider<GetStartedBloc>(
      create: (context) => getIt<GetStartedBloc>(),
    ),
    BlocProvider<QuestionFlowBloc>(
      create: (context) => getIt<QuestionFlowBloc>(),
    ),
    BlocProvider<BottomNavStateCubit>(
      create: (context) => getIt<BottomNavStateCubit>(),
    ),
    BlocProvider<AuthenticationBloc>(
      create: (context) => getIt<AuthenticationBloc>(),
    ),
  ];