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
    on<FilterPlansEvent>(_filterPlans);
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

  _filterPlans(FilterPlansEvent event, Emitter<ExploreState> emit) async{

    await _getAllPlans(emit);

    List<GetPlanResponseModel> favList = List.from(state.favList ?? []);
    List<GetPlanResponseModel> upcoming = List.from(state.upcomingList ?? []);
    List<GetPlanResponseModel> passed = List.from(state.passedList ?? []);

    List<GetPlanResponseModel> filteredFavList = [];
    List<GetPlanResponseModel> filteredUpcoming = [];
    List<GetPlanResponseModel> filteredPassed = [];

    filteredFavList.addAll(filterList(event,favList));
    filteredUpcoming.addAll(filterList(event,upcoming));
    filteredPassed.addAll(filterList(event,passed));

    // Emit the filtered lists
    emit(state.copyWith(
      exploreStateStatus: ExploreStateStatus.success,
      favList: filteredFavList,
      upcomingList: filteredUpcoming,
      passedList: filteredPassed,
    ));
  }

  List<GetPlanResponseModel> filterList(FilterPlansEvent event,List<GetPlanResponseModel>? list) {
    // Early return if the list is null or empty
    if (list == null || list.isEmpty) {
      printLog("Filter list is null or empty. Returning empty list.");
      return [];
    }

    return list.where((plan) {
      // Log the plan being processed
      printLog("Processing plan: ${plan.dateDateTime}, ${plan.location}");

      // If either start date or location is not provided, exclude the plan
      // if (event.startDate == null || event.location == null || event.location!.isEmpty) {
      //   printLog("Start date or location is not provided. Excluding plan.");
      //   return false;
      // }

      // Check if the plan matches the start date
      bool matchesDate = _matchesStartDate(plan.dateDateTime, event.startDate);

      // Check if the plan matches the location
      bool matchesLocation = _matchesLocation(plan.location, event.location);

      // Log the match results
      printLog("Matches Date: $matchesDate, Matches Location: $matchesLocation");

      // Return true only if both date and location match
      return (event.startDate != null && event.location != null) ? (matchesDate && matchesLocation) : (matchesDate || matchesLocation);
    }).toList();
  }

  // Helper function to check if the plan matches the start date
  bool _matchesStartDate(String? planDateString, DateTime? startDate) {
    if (startDate == null) {
      // If no start date is provided, it is not a match
      return false;
    }

    DateTime? planDate = _getDateFromAPI(planDateString);
    if (planDate == null) {
      // If the plan date is invalid, consider it a mismatch
      return false;
    }

    // Compare only year, month, and day (ignore time)
    return planDate.year == startDate.year &&
        planDate.month == startDate.month &&
        planDate.day == startDate.day;
  }

// Helper function to check if the plan matches the location
  bool _matchesLocation(String? planLocation, String? eventLocation) {
    if (eventLocation == null || eventLocation.isEmpty) {
      // If no location is provided, it is not a match
      return false;
    }

    if (planLocation == null || planLocation.isEmpty) {
      // If the plan location is invalid, consider it a mismatch
      return false;
    }

    // Perform case-insensitive comparison
    return planLocation.toLowerCase() == eventLocation.toLowerCase() || planLocation.toLowerCase().contains(eventLocation.toLowerCase());
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
