import 'dart:convert';

import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/utils/helper/print_log.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/modules/authentication/repository/authentication_respository.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:ai_d_planner/app/routes/app_routes.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationRepository? authenticationRepository;

  AuthenticationBloc() : super(AuthenticationState(authenticationStateStatus: AuthenticationStateStatus.init)) {

    authenticationRepository = AuthenticationRepository();

    on<InitiateSignup>(_initSignUp);
    on<InitiateLogin>(_initLogin);
    on<InitiateLoginWithApple>(_initLoginWithApple);
    on<Logout>(_initLogout);
  }

  _initSignUp(InitiateSignup event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      authenticationStateStatus: AuthenticationStateStatus.loading
    ));

    AppHelper().showLoader(dismissOnTap: false,hasMask: true);

    var response = await authenticationRepository?.signUp(event.email, event.password,event.userName,event.rcAppOriginalID);

    if(response != null){
      emit(state.copyWith(
          authenticationStateStatus: AuthenticationStateStatus.success
      ));
      _getForwardMethod();
      AppWidgets().getSnackBar(message: "Signup Completed!",status: SnackBarStatus.success);
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
  _initLoginWithApple(InitiateLoginWithApple event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
        authenticationStateStatus: AuthenticationStateStatus.loading
    ));

    AppHelper().showLoader(dismissOnTap: false,hasMask: true);

    try {
      final response = await signInWithAppleWorkWithIos(emit);

      if(response != null){

        emit(state.copyWith(
            authenticationStateStatus: AuthenticationStateStatus.success
        ));

        await Future.delayed(Duration(milliseconds: 300));

        await createOrUpdateProfile(userID: response.user!.id,userName: state.fullName.toString(),email: "",rcOriginalID: event.rcAppOriginalID);
        _getForwardMethod();
        AppWidgets().getSnackBar(message: "Logged In Successfully!",status: SnackBarStatus.success);
      }
      AppHelper().hideLoader();
    } on AuthException catch (e) {
      // Handle specific AuthException
      print(e.message);
      AppWidgets().getSnackBar(message: e.message,status: SnackBarStatus.error);
      emit(state.copyWith(
          authenticationStateStatus: AuthenticationStateStatus.error
      ));
      AppHelper().hideLoader();
      return null; // Return the error message to the caller
    } catch (e) {
      // Handle other exceptions
      emit(state.copyWith(
          authenticationStateStatus: AuthenticationStateStatus.error
      ));
      AppHelper().hideLoader();
      printLog("Unexpected error: $e");
      return null;
    }

    AppHelper().hideLoader();
  }

  Future<AuthResponse> signInWithAppleWorkWithIos(Emitter<AuthenticationState> emit) async {
    final SupabaseClient _supabase = Supabase.instance.client;

    final rawNonce = _supabase.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
          'Could not find ID Token from generated credential.');
    }

    AuthResponse authResponse = await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );


    emit(state.copyWith(
        fullName: "${credential.givenName ?? "No"} ${credential.familyName ?? "Name"}",
    ));

    return authResponse;

    // return [
    //   ,
    //   "${credential.givenName!} ${credential.familyName!}"
    // ];
  }
  // Future<bool> signInWithAppleWorkWithAndroid() async {
  //   final supabase = Supabase.instance.client;
  //
  //   return await supabase.auth.signInWithOAuth(
  //     OAuthProvider.apple,
  //     redirectTo: "https://bijnbvrxavxfnmxwwotv.supabase.co/auth/v1/callback",
  //     authScreenLaunchMode: LaunchMode.platformDefault
  //   );
  // }


  void _getBackMethod() {
    toReplacementNamed(AppRoutes.login,args: PageRouteArg(
      to: AppRoutes.login,
      from: AppRoutes.signup,
      pageRouteType: PageRouteType.pushReplacement,
      isBackAction: true
    ));
  }
  void _getForwardMethod() {
    toReplacementNamed(AppRoutes.dashboard,args: PageRouteArg(
      to: AppRoutes.dashboard,
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

  createOrUpdateProfile({userID,userName,email,rcOriginalID}) async{
    (await authenticationRepository!.getUserProfileByID(userID) && await authenticationRepository!.isRevenueCatIDLinkedToSameUUID(userID, rcOriginalID)) ? null
        : authenticationRepository?.createUserProfile(name: userName, role: "user", authId: userID,email: email,rcOriginalAppID: rcOriginalID);

    //authenticationRepository.createUserProfile(name: name, role: role, authId: authId)
  }
}
