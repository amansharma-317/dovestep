
import 'package:startup/feautures/therapist_directory/domain/entities/therapist_entity.dart';

abstract class TherapistRepository {
  Future<List<Therapist>> getTherapists();
  Future<List<String>> getAvailableTimeSlots(String therapistId, String date);
}