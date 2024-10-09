import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/widgets/timer.dart';

final timerDurationProvider = StateProvider<Duration>((_) => Duration(seconds: 30));
final timerStateProvider = StateProvider<TimerState>((_) => TimerState.stopped);
final timerControllerProvider = Provider((ref) => TimerController(ref));

enum TimerState { running, stopped }

final isResendTimerFinishedProvider = StateProvider<bool>((ref) => false);