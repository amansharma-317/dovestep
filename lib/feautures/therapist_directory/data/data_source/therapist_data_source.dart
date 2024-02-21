import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup/feautures/therapist_directory/domain/entities/therapist_entity.dart';

class TherapistDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<List<Therapist>> getTherapists() async {
    try {
      final CollectionReference therapistsCollection = _firestore.collection('therapists');
      QuerySnapshot therapistDocs = await therapistsCollection.get();

      return therapistDocs.docs.map((doc) => Therapist.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error fetching therapists: $e');
      throw e;
    }
  }

  @override
  Future<List<String>> getAvailableTimeSlots(String therapistId, String date) async {
    try {
      // Replace this with your actual implementation to fetch available time slots.
      // For simplicity, let's assume you have a hardcoded list.
      final snapshot = await _firestore.collection('therapists').doc(therapistId).get();
      if (snapshot.exists) {
        print('hello');
        final therapistData = snapshot.data() as Map<String, dynamic>;

        // Assuming 'availability' is a field in your Firestore document
        final availability = therapistData['availability'] as Map<String, dynamic>;
        print(availability);
        // Get the available time slots for the specified date
        final availableTimeSlots = availability[date] ?? [];

        final filteredTimeSlots = availableTimeSlots.whereType<String>().toList();
        print(filteredTimeSlots);
        return filteredTimeSlots;
      } else {
        // Therapist not found
        throw Exception('Therapist not found');
      }
    } catch (e) {
      // Handle the error as needed
      rethrow;
    }
  }
}