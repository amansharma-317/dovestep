import 'package:startup/feautures/therapist_directory/data/data_source/therapist_data_source.dart';
import 'package:startup/feautures/therapist_directory/domain/entities/therapist_entity.dart';
import 'package:startup/feautures/therapist_directory/domain/repository/therapist_repository.dart';

class TherapistRepositoryImpl implements TherapistRepository {
  final TherapistDataSource therapistDataSource;

  TherapistRepositoryImpl({required this.therapistDataSource,});

  @override
  Future<List<Therapist>> getTherapists() async {
    try {
      final posts = await therapistDataSource.getTherapists();
      return posts;
    } catch (e) {
      print('Error in repository: $e');
      // Handle or rethrow the exception as needed
      throw e;
    }
  }

  @override
  Future<List<String>> getAvailableTimeSlots(String therapistId, String date) async {
    try {
      return await therapistDataSource.getAvailableTimeSlots(therapistId, date);
    } catch (e) {
      print('Error in repo_impl ' + e.toString());
      throw e;
    }
  }
}