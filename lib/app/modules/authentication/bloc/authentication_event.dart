import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{}

class InitiateSignup extends AuthenticationEvent {

  final String? userName,email,password;

  InitiateSignup({this.userName, this.email, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [userName,email,password];

}

class InitiateLogin extends AuthenticationEvent {

  final String? email,password;

  InitiateLogin({this.email, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}

class InitiateLoginWithApple extends AuthenticationEvent {

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class Logout extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}