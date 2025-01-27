import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
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
    on<Logout>(_initLogout);
  }

  _initSignUp(InitiateSignup event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      authenticationStateStatus: AuthenticationStateStatus.loading
    ));

    AppHelper().showLoader(dismissOnTap: false,hasMask: true);

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

    AppHelper().hideLoader();
  }
  _initLogin(InitiateLogin event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        authenticationStateStatus: AuthenticationStateStatus.loading
    ));

    AppHelper().showLoader(dismissOnTap: false,hasMask: true);

    //Here code
    var response = await authenticationRepository?.signInUser(event.email!, event.password!);

    if(response != null){
      emit(state.copyWith(
          authenticationStateStatus: AuthenticationStateStatus.success
      ));
      _getForwardMethod();
      AppWidgets().getSnackBar(message: "Logged In Successfully!",status: SnackBarStatus.success);
    }

    AppHelper().hideLoader();
  }

  _initLogout(Logout event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        authenticationStateStatus: AuthenticationStateStatus.loading
    ));

    AppHelper().showLoader(dismissOnTap: false,hasMask: true);

    //Here code
    await authenticationRepository?.logout();

    emit(state.copyWith(
        authenticationStateStatus: AuthenticationStateStatus.success
    ));
    _getLogoutMovementMethod();
    AppWidgets().getSnackBar(message: "Logged Out Successfully!",status: SnackBarStatus.success);

    AppHelper().hideLoader();
  }

  void _getBackMethod() {
    toReplacementNamed(AppRoutes.login,args: PageRouteArg(
      to: AppRoutes.login,
      from: AppRoutes.signup,
      pageRouteType: PageRouteType.pushReplacement,
      isBackAction: true
    ));
  }

  void _getForwardMethod() {
    toReplacementNamed(AppRoutes.getStarted,args: PageRouteArg(
      to: AppRoutes.getStarted,
      from: AppRoutes.login,
      pageRouteType: PageRouteType.pushReplacement,
      isFromDashboardNav: false,
    ));
  }

  void _getLogoutMovementMethod() {
    toReplacementNamed(AppRoutes.login,args: PageRouteArg(
      to: AppRoutes.login,
      from: AppRoutes.dashboard,
      pageRouteType: PageRouteType.pushReplacement,
      isFromDashboardNav: false,
    ));
  }
}
