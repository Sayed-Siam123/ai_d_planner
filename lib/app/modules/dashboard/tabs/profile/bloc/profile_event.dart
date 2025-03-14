import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable{}

class FetchProfileData extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateNameData extends ProfileEvent {

  final String? username;
  UpdateNameData({this.username});
  @override
  // TODO: implement props
  List<Object?> get props => [username];
}