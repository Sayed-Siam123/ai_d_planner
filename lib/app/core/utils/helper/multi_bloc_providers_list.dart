import 'package:ai_d_planner/app/modules/authentication/bloc/authentication_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/explore/bloc/explore_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_bloc.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/tabs/change_password/bloc/change_password_cubit.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/questions/bloc/question_page_bloc.dart';
import 'package:ai_d_planner/app/modules/get_started/bloc/get_started_bloc.dart';
import 'package:ai_d_planner/app/modules/question_flow/bloc/question_flow_bloc.dart';
import 'package:ai_d_planner/app/services/bottom_nav_state/bloc/bottom_nav_cubit.dart';
import 'package:ai_d_planner/app/services/expansion/bloc/expansion_tile_bloc.dart';
import 'package:ai_d_planner/app/services/filter/bloc/filter_cubit.dart';
import 'package:ai_d_planner/app/services/password_obscure_operation/bloc/password_obscure_ops_cubit.dart';
import 'package:ai_d_planner/app/services/sorting/bloc/sorting_bloc.dart';
import 'package:ai_d_planner/app/services/subscription_purchase/bloc/subscription_purchase_bloc.dart';
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
    BlocProvider<SubscriptionPurchaseBloc>(
      create: (context) => getIt<SubscriptionPurchaseBloc>(),
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
    BlocProvider<QuestionPageBloc>(
      create: (context) => getIt<QuestionPageBloc>(),
    ),
    BlocProvider<ExploreBloc>(
      create: (context) => getIt<ExploreBloc>(),
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>(),
    ),
    BlocProvider<SortBloc>(
      create: (context) => getIt<SortBloc>(),
    ),
    BlocProvider<ExpansionBloc>(
      create: (context) => getIt<ExpansionBloc>(),
    ),
    BlocProvider<FilterCubit>(
      create: (context) => getIt<FilterCubit>(),
    ),
    BlocProvider<ChangePasswordCubit>(
      create: (context) => getIt<ChangePasswordCubit>(),
    ),
  ];