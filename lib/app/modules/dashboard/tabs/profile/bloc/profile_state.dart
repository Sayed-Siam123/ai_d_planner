import 'package:equatable/equatable.dart';

enum ProfileStateStatus{
  init,
  loading,
  success,
  error
}

class ProfileState extends Equatable{
  final ProfileStateStatus? profileStateStatus;
  final String? profileName;

  const ProfileState({this.profileStateStatus,this.profileName});


  ProfileState copyWith({
    ProfileStateStatus? profileStateStatus,
    String? profileName,
}){
    return ProfileState(
      profileStateStatus: profileStateStatus ?? this.profileStateStatus,
      profileName: profileName ?? this.profileName
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [profileStateStatus,profileName];
}
