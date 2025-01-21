import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pausable_timer/pausable_timer.dart';

import '../../../core/utils/helper/print_log.dart';
import 'timer_bloc_state.dart';

class TimerCubit extends Cubit<TimerCubitState> {

  late PausableTimer timer;

  TimerCubit() : super(TimerCubitState(
    status: TimerBlocStateStatus.init,
    timeInSecond: 0,
  ));


  void startTimer(int? timeInSecond, {String? showTime = "00:10",VoidCallback? onTimeComplete = null,isOtpTimer = false}) {
    emit(state.copyWith(
      status: TimerBlocStateStatus.start,
      timeInSecond: timeInSecond,
      showTime: showTime,
      resendOtp: false,
    ));
    _startTimer(onTimeComplete: onTimeComplete,isOtpTimer: isOtpTimer);
  }

  void pauseTimer() {
    emit(state.copyWith(
      status: TimerBlocStateStatus.pause,
    ));
    _pauseTimer();
  }

  void resumeTimer() {
    emit(state.copyWith(
      status: TimerBlocStateStatus.resume,
    ));
    _resumeTimer();
  }

  void stopTimer() {
    emit(state.copyWith(
      status: TimerBlocStateStatus.stop,
      resendOtp: true,
    ));
    _stopTimer();
  }

  _startTimer({VoidCallback? onTimeComplete,isOtpTimer = false}) async {

    String? showTime = state.showTime.toString();

    var remainSeconds = state.timeInSecond!-1;

    var totalTime = state.timeInSecond!-1; //10 min == 600 || 1 min == 60

    try{
      timer = PausableTimer.periodic(
        const Duration(seconds: 1),
            () {

          if (remainSeconds == 0) {
            stopTimer();

            emit(state.copyWith(
              status: TimerBlocStateStatus.stop,
              timeInSecond: state.timeInSecond,
              showTime: showTime,
              resendOtp: isOtpTimer ? true : false,
              runningTime: showTime.toString(),
            ));

            if(onTimeComplete != null){
              onTimeComplete.call();
            }
            // back();
            // back();
          } else {
            int minutes = remainSeconds ~/ 60;
            int seconds = (remainSeconds % 60);

            showTime = "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";

            remainSeconds = totalTime - timer.tick;

            emit(state.copyWith(
              status: TimerBlocStateStatus.running,
              timeInSecond: state.timeInSecond,
              showTime: showTime,
              resendOtp: false,
              runningTime: showTime.toString(),
            ));
          }
        },
      );

      timer.start();
    } catch (e){
      printLog("Timer exception: ${e.toString()}");
    }
  }

  _stopTimer() {
    try{
      timer.reset();
      timer.cancel();
    } catch (e){
      printLog("Timer exception: ${e.toString()}");
    }
  }

  _pauseTimer() {
    try{
      if(timer.isActive){
        timer.pause();
      }
    } catch (e){
      printLog("Timer exception: ${e.toString()}");
    }
  }

  _resumeTimer() {
    try{
      if(timer.isPaused){
        timer.start();
        printLog(timer.tick);
      }
    } catch (e){
      printLog("Timer exception: ${e.toString()}");
    }
  }

}
