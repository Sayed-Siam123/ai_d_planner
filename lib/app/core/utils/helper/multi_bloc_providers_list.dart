import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../../binding/central_dependecy_injection.dart';
import '../../connection_manager/internet_cubit/internet_cubit.dart';

final List<SingleChildWidget> multiBlocProvidersList  = [
    BlocProvider<InternetCubit>(
      create: (context) => getIt<InternetCubit>(),
    ),
  ];