import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';
import 'package:startup/feautures/therapist_directory/data/data_source/therapist_data_source.dart';
import 'package:startup/feautures/therapist_directory/data/repository_impl/therapist_repository_impl.dart';
import 'package:startup/feautures/therapist_directory/domain/entities/therapist_entity.dart';
import 'package:startup/feautures/therapist_directory/domain/repository/therapist_repository.dart';

final therapistRepositoryProvider = Provider<TherapistRepository>((ref) {
  return TherapistRepositoryImpl(therapistDataSource: TherapistDataSource());
});

final therapistsProvider = FutureProvider<List<Therapist>>((ref) async {
  final repository = ref.watch(therapistRepositoryProvider);
  return await repository.getTherapists();
});

final availableTimeSlotsProvider = FutureProvider.family<List<String>, String>(
      (ref, therapistId) async {
        final date = ref.watch(selectedDateProvider.notifier).state;
        print('inside availability provider ' + date);

    try {
      final snapshot = await ref.read(therapistRepositoryProvider).getAvailableTimeSlots(therapistId, date);
      return snapshot;
    } catch (e) {
      throw Exception('Failed to fetch available time slots: $e');
    }
  },
);

final selectedDateProvider = StateProvider<String>((ref) => DateFormat('yyyy-MM-dd').format(DateTime.now()));




///////////////////////////////////////////////////////////////////////////////////////////////////////////
// for future purposes
final filteredTherapistsProvider = FutureProvider.family.autoDispose<List<Therapist>, String?>((ref, expertise) async {
  final repository = ref.read(therapistRepositoryProvider);
  return repository.getTherapists();
});