import 'package:equatable/equatable.dart';

abstract class GetStartedEvent extends Equatable {}

class ChangeSlideIndicator extends GetStartedEvent {

  final int? currentIndex;

  ChangeSlideIndicator({this.currentIndex});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}