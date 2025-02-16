import 'package:ai_d_planner/app/core/utils/helper/app_helper.dart';
import 'package:ai_d_planner/app/core/widgets/app_widgets.dart';
import 'package:ai_d_planner/app/data/models/GetPlanResponseModel.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/utils/helper/print_log.dart';
import '../../../../splash/bloc/splash_event.dart';
import '../../questions/repository/response_supabase_repository.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {

  ResponseSupaBaseRepository? responseSupaBaseRepository;
  bool ascending = true;

  ExploreBloc() : super(ExploreState(exploreStateStatus: ExploreStateStatus.init)) {
    responseSupaBaseRepository = ResponseSupaBaseRepository();
    on<FetchAllPlans>(_fetchAllPlans);
    on<ChangeStatusFav>(_changeStatusFav);
    on<DeletePlan>(_deletePlan);
    on<SortPlansByDateEvent>(_sortPlansByDateEvent);
  }

  // void _init(InitEvent event, Emitter<ExploreState> emit) async {
  //   emit(state.clone());
  // }

  _fetchAllPlans(FetchAllPlans event, Emitter<ExploreState> emit) async{
    emit(state.copyWith(
      exploreStateStatus: ExploreStateStatus.loading
    ));

    AppHelper().showLoader(hasMask: true);

    await _getAllPlans(emit);

    AppHelper().hideLoader();
  }

  _getAllPlans(Emitter<ExploreState> emit) async{
    List<GetPlanResponseModel> favList = [];
    List<GetPlanResponseModel> upcoming = [];
    List<GetPlanResponseModel> passed = [];

    var plans = await responseSupaBaseRepository?.getAllPlans();

    for(var plan in plans!){
      if(plan.isFav!){
        favList.add(plan);
      }else{
        if(_getDateFromAPI(plan.dateDateTime!)!.isAfter(DateTime.now())){
          upcoming.add(plan);
        } else{
          passed.add(plan);
        }
      }
    }

    emit(state.copyWith(
        exploreStateStatus: ExploreStateStatus.success,
        favList: favList,
        upcomingList: upcoming,
        passedList: passed
    ));
  }

  _changeStatusFav(ChangeStatusFav event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(
        exploreStateStatus: ExploreStateStatus.loading
    ));

    AppHelper().showLoader(hasMask: true,dismissOnTap: true);

    await responseSupaBaseRepository?.changeFavStatus(
        id: event.planID,
        status: event.status
    );

    await _getAllPlans(emit);

    AppHelper().hideLoader();
  }

  void _deletePlan(DeletePlan event, Emitter<ExploreState> emit) async {
    emit(state.copyWith(
        exploreStateStatus: ExploreStateStatus.loading
    ));

    AppHelper().showLoader(hasMask: true);

    await responseSupaBaseRepository?.deletePlan(
        id: event.planID,
    );

    await _getAllPlans(emit);

    AppHelper().hideLoader();
  }

  void _sortPlansByDateEvent(SortPlansByDateEvent event, Emitter<ExploreState> emit) async {
    // Get current lists from state
    List<GetPlanResponseModel> favList = List.from(state.favList ?? []);
    List<GetPlanResponseModel> upcoming = List.from(state.upcomingList ?? []);
    List<GetPlanResponseModel> passed = List.from(state.passedList ?? []);

    // Sort the lists
    favList = sortPlans(favList, ascending: event.ascending);
    upcoming = sortPlans(upcoming, ascending: event.ascending);
    passed = sortPlans(passed, ascending: event.ascending);

    ascending = !ascending;

    // Emit the sorted lists
    emit(state.copyWith(
      exploreStateStatus: ExploreStateStatus.success,
      favList: favList,
      upcomingList: upcoming,
      passedList: passed,
    ));
  }

  List<GetPlanResponseModel> sortPlans(List<GetPlanResponseModel> plans, {bool ascending = true}) {
    plans.sort((a, b) {
      DateTime? dateA = _getDateFromAPI(a.dateDateTime!);
      DateTime? dateB = _getDateFromAPI(b.dateDateTime!);

      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;

      return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    return plans;
  }

  DateTime? _getDateFromAPI(String? dateTime) {
    // Parse the input string
    DateFormat inputFormat = DateFormat("dd-MMM-yyyy, hh:mm a");
    DateTime parsedDate = inputFormat.parse(dateTime!);
    return parsedDate;
  }

}
