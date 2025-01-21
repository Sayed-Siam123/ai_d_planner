import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/modules/authentication/repository/authentication_respository.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:ai_d_planner/app/routes/app_routes.dart';
import 'package:bloc/bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationRepository? authenticationRepository;

  AuthenticationBloc() : super(AuthenticationState(authenticationStateStatus: AuthenticationStateStatus.init)) {

    authenticationRepository = AuthenticationRepository();

    on<InitiateSignup>(_initSignUp);
    on<InitiateLogin>(_initLogin);
  }

  _initSignUp(InitiateSignup event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      authenticationStateStatus: AuthenticationStateStatus.loading
    ));

    var response = await authenticationRepository?.signUp(event.email, event.password,event.userName);

    if(response != null){
      emit(state.copyWith(
          authenticationStateStatus: AuthenticationStateStatus.success
      ));
      _getBackMethod();
      AppWidgets().getSnackBar(message: "Signup Completed! Please Login",status: SnackBarStatus.success);
    } else{
      emit(state.copyWith(
          authenticationStateStatus: AuthenticationStateStatus.error
      ));
    }

  }
  _initLogin(InitiateLogin event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        authenticationStateStatus: AuthenticationStateStatus.loading
    ));

    emit(state.copyWith(
        authenticationStateStatus: AuthenticationStateStatus.success
    ));

    // var response = await authenticationRepository?.signUp(event.email, event.password,event.userName);
    //
    // if(response != null){
    //   emit(state.copyWith(
    //       authenticationStateStatus: AuthenticationStateStatus.success
    //   ));
    //   AppWidgets().getSnackBar(message: "Logged In Successfully",status: SnackBarStatus.success);
    // } else{
    //   emit(state.copyWith(
    //       authenticationStateStatus: AuthenticationStateStatus.error
    //   ));
    // }

  }

  void _getBackMethod() {
    toReplacementNamed(AppRoutes.login,args: PageRouteArg(
      to: AppRoutes.login,
      from: AppRoutes.signup,
      pageRouteType: PageRouteType.pushReplacement,
      isBackAction: true
    ));
  }
}
