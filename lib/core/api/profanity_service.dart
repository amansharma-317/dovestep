import 'package:profanity_filter/profanity_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ProfanityService {
  final ProfanityFilter _filter = ProfanityFilter();

  bool hasProfanity(String text) {
    return _filter.hasProfanity(text);
  }

  String censor(String text) {
    return _filter.censor(text);
  }
}

final profanityServiceProvider = Provider((ref) => ProfanityService());