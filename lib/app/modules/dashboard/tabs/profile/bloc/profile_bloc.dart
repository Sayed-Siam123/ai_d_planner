import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_state.dart';
import 'package:bloc/bloc.dart';

import '../repository/profile_repository.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileRepository? profileRepository;

  ProfileBloc() : super(ProfileState(profileStateStatus: ProfileStateStatus.init)) {
    profileRepository = ProfileRepository();

    on<FetchProfileData>(_fetchProfileData);
  }

  // void _init(InitEvent event, Emitter<ProfileState> emit) async {
  //   emit(state.clone());
  // }

  void _fetchProfileData(FetchProfileData event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      profileStateStatus: ProfileStateStatus.loading
    ));

    var data = await profileRepository?.getProfileInfo();

    emit(state.copyWith(
        profileStateStatus: ProfileStateStatus.success,
      profileName: data![0].name,
    ));
  }
}
