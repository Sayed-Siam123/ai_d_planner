import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_state.dart';
import 'package:bloc/bloc.dart';

import '../../questions/repository/response_supabase_repository.dart';
import '../repository/profile_repository.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  ProfileRepository? profileRepository;
  ResponseSupaBaseRepository? responseSupaBaseRepository;

  ProfileBloc() : super(ProfileState(profileStateStatus: ProfileStateStatus.init)) {
    profileRepository = ProfileRepository();
    responseSupaBaseRepository = ResponseSupaBaseRepository();

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
    var plans = await responseSupaBaseRepository?.getAllPlans();

    emit(state.copyWith(
        profileStateStatus: ProfileStateStatus.success,
      profileName: data?[0].name ?? "No Name",
      totalGeneratedResponse:  plans?.length ?? 0,
      totalFavResponse: _getFavLengthFromPlans(plans) ?? 0,
    ));
  }

  int? _getFavLengthFromPlans(List<GetPlanResponseModel>? plans) {
    int totalFavLength = 0;

    for(var plan in plans!){
      if(plan.isFav == true){
        totalFavLength++;
      }
    }

    return totalFavLength;
  }
}
