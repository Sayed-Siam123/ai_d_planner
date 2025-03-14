import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{}

class InitiateSignup extends AuthenticationEvent {

  final String? userName,email,password,rcAppOriginalID;

  InitiateSignup({this.userName, this.email, this.password,this.rcAppOriginalID});

  @override
  // TODO: implement props
  List<Object?> get props => [userName,email,password,rcAppOriginalID];

}

class InitiateLogin extends AuthenticationEvent {

  final String? email,password;

  InitiateLogin({this.email, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}

class InitiateLoginWithApple extends AuthenticationEvent {

  final String? rcAppOriginalID;

  InitiateLoginWithApple({this.rcAppOriginalID});

  @override
  // TODO: implement props
  List<Object?> get props => [rcAppOriginalID];

}

class Logout extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}