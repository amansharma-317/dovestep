import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/timer_provider.dart';

class TimerController extends StateNotifier<Timer?> {
  final Ref ref;

  TimerController(this.ref) : super(null);


  void startTimer() {
    final duration = ref.read(timerDurationProvider);
    state?.cancel();
    state = Timer.periodic(Duration(seconds: 1), (timer) {
      final currentDuration = ref.read(timerDurationProvider);
      if (currentDuration == Duration.zero) {
        timer.cancel();
        ref.read(timerStateProvider.notifier).state = TimerState.stopped;
        // Add your logic for handling timer completion here (e.g., navigate to a new page, show a message)
      } else {
        ref.read(timerDurationProvider.notifier).state = currentDuration - Duration(seconds: 1);
      }
    });
    ref.read(timerStateProvider.notifier).state = TimerState.running;
  }

  void stopTimer() {
    // No pause functionality, so comment out this method
    // state?.cancel();
    // ref.read(timerStateProvider.notifier).state = TimerState.stopped;
  }

  @override
  void disposed() {
    state?.cancel();
    super.dispose();
  }
}
