
import 'package:equatable/equatable.dart';

enum AuthenticationStateStatus{
  init,
  loading,
  success,
  error
}


class AuthenticationState extends Equatable{
  final AuthenticationStateStatus? authenticationStateStatus;
  final String? fullName;

  const AuthenticationState({this.authenticationStateStatus,this.fullName});

  AuthenticationState copyWith({
    AuthenticationStateStatus? authenticationStateStatus,
    String? fullName,
}){
    return AuthenticationState(
      authenticationStateStatus: authenticationStateStatus ?? this.authenticationStateStatus,
      fullName: fullName ?? this.fullName,
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [authenticationStateStatus,fullName];



}
