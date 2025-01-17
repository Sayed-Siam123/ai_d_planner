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
  ];