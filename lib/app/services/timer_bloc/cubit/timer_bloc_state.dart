enum TimerBlocStateStatus {
  init,
  start,
  running,
  pause,
  resume,
  stop
}


class TimerCubitState {
  final TimerBlocStateStatus? status;
  final int? timeInSecond;
  final String? showTime,runningTime;

  final bool? resendOtp;


  TimerCubitState({
    this.status,
    this.timeInSecond,
    this.showTime = "00:00",
    this.runningTime = "00:00",
    this.resendOtp = false,
  });

  TimerCubitState copyWith({
    TimerBlocStateStatus? status,
    int? timeInSecond,
    String? showTime,
    String? runningTime,
    bool? resendOtp,
  }) {
    return TimerCubitState(
      status: status ?? this.status,
      timeInSecond: timeInSecond ?? this.timeInSecond,
      showTime: showTime ?? this.showTime,
      resendOtp: resendOtp ?? this.resendOtp,
      runningTime: runningTime ?? this.runningTime,
    );
  }
}
