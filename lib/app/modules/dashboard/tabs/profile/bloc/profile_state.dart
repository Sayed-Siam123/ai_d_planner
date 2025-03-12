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
  final int? totalGeneratedResponse,totalFavResponse;

  const ProfileState({this.profileStateStatus,this.profileName,this.totalGeneratedResponse = 0,this.totalFavResponse = 0});


  ProfileState copyWith({
    ProfileStateStatus? profileStateStatus,
    String? profileName,
    int? totalGeneratedResponse,
    int? totalFavResponse,
}){
    return ProfileState(
      profileStateStatus: profileStateStatus ?? this.profileStateStatus,
      profileName: profileName ?? this.profileName,
      totalFavResponse: totalFavResponse ?? this.totalFavResponse,
      totalGeneratedResponse: totalGeneratedResponse ?? this.totalGeneratedResponse
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [profileStateStatus,profileName,totalFavResponse,totalGeneratedResponse];
}
