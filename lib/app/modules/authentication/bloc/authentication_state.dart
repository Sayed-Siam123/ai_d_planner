
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
  final String? email;

  const AuthenticationState({this.authenticationStateStatus,this.fullName,this.email});

  AuthenticationState copyWith({
    AuthenticationStateStatus? authenticationStateStatus,
    String? fullName,
    String? email,
}){
    return AuthenticationState(
      authenticationStateStatus: authenticationStateStatus ?? this.authenticationStateStatus,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [authenticationStateStatus,fullName,email];



}
