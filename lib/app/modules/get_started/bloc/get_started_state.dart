import 'package:equatable/equatable.dart';

enum GetStartedStateStatus{
  init,
  loading,
  loaded,
  error
}

class GetStartedState extends Equatable{
  final GetStartedStateStatus? getStartedStateStatus;
  final int? swiperCurrentIndex;

  GetStartedState({this.getStartedStateStatus,this.swiperCurrentIndex});

  GetStartedState copyWith({
    GetStartedStateStatus? getStartedStateStatus,
    int? swiperCurrentIndex
}){
    return GetStartedState(
      getStartedStateStatus: getStartedStateStatus ?? this.getStartedStateStatus,
      swiperCurrentIndex: swiperCurrentIndex ?? this.swiperCurrentIndex
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [getStartedStateStatus,swiperCurrentIndex];




}
