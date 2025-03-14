import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:ai_d_planner/app/data/models/page_route_arguments.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_event.dart';
import 'package:ai_d_planner/app/modules/dashboard/tabs/profile/bloc/profile_state.dart';
import 'package:ai_d_planner/app/routes/app_pages.dart';
import 'package:ai_d_planner/app/routes/app_routes.dart';
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
    on<UpdateNameData>(_updateNameData);
  }

  // void _init(InitEvent event, Emitter<ProfileState> emit) async {
  //   emit(state.clone());
  // }

  _fetchProfileData(FetchProfileData event, Emitter<ProfileState> emit) async {
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

  _updateNameData(UpdateNameData event, Emitter<ProfileState> emit) async{
    emit(state.copyWith(
        profileStateStatus: ProfileStateStatus.loading
    ));
    AppHelper().showLoader();
    var data = await profileRepository?.updateUserName(event.username!);

    if(data!){
      await _fetchProfileData(FetchProfileData(), emit);

      back(
        pageRouteArgs: PageRouteArg(
          from: AppRoutes.changeUserName,
          to: AppRoutes.settings,
          isBackAction: true,
          pageRouteType: PageRouteType.goNamed
        )
      );
      AppHelper().hideLoader();
      AppWidgets().getSnackBar(
        message: "Name updated successfully",
      );
    } else{
      AppHelper().hideLoader();
      AppWidgets().getSnackBar(
        message: "Something wrong, please try again later",
      );
    }

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
