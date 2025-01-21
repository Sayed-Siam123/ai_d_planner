
import 'package:equatable/equatable.dart';

enum AuthenticationStateStatus{
  init,
  loading,
  success,
  error
}


class AuthenticationState extends Equatable{
  final AuthenticationStateStatus? authenticationStateStatus;

  const AuthenticationState({this.authenticationStateStatus});

  AuthenticationState copyWith({
    AuthenticationStateStatus? authenticationStateStatus,
}){
    return AuthenticationState(
      authenticationStateStatus: authenticationStateStatus ?? this.authenticationStateStatus
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [authenticationStateStatus];



}
