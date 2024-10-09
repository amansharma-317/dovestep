import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshNotifier extends StateNotifier<bool> {
  RefreshNotifier() : super(false);

  void triggerRefresh() {
    state = true;
  }

  void resetRefresh() {
    state = false;
  }
}

final refreshNotifierProvider = StateNotifierProvider<RefreshNotifier, bool>((ref) {
  return RefreshNotifier();
});
