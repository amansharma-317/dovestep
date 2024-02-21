import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup/config/utils/random.dart';
import 'package:startup/core/models/assessment_model.dart';

abstract class AssessmentDataSource {
  Future<bool> saveAssessmentResponses(List<int> responses);
  Future<List<int>?> getAssessmentResponses();
}

class FirebaseUserDataSource implements AssessmentDataSource {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users'); // Adjust the collection name

  Future<bool> saveAssessmentResponses(List<int> responses) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser!;
      if (currentUser != null) {
        final String randomUsername = generateRandomUsername();
        final String randomAvatarSvgUrl = generateRandomAvatar();
        String uId = currentUser.uid;
        String phone = currentUser.phoneNumber!;

        final assessment = MentalHealthAssessment(
          moodStability: responses[0],
          stressLevels: responses[1],
          emotionalResilience: responses[2],
          selfEsteem: responses[3],
          qualityOfSleep: responses[4],
        );

        Map<String, dynamic> userData = {
          'username': randomUsername,
          'avatar': randomAvatarSvgUrl,
          'assessmentResponses': assessment,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'totalChats': 0,
          'totalTherapistBookings': 0,
          'uId': uId,
          'phone': phone,
        };
        await _usersCollection.doc(uId).set(userData);
        return true;
      } else {
        print('no user currently logged in');
        return false;
      }
    } catch (e) {
      print('Error saving assessment responses: $e');
      throw e;
    }
  }

  Future<List<int>?> getAssessmentResponses() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String uId = currentUser.uid;
        DocumentSnapshot userData = await _usersCollection.doc(uId).get();

        if (userData.exists) {
          final assessmentMap = userData.get('assessmentResponses') as Map<String, dynamic>?;

          if (assessmentMap != null) {
            // Convert map values to a list of integers
            List<int> responses = assessmentMap.values.map((value) => value as int).toList();
            print('hi');
            return responses;
          } else {
            print('Assessment data not found for the current user.');
          }
        } else {
          print('User data does not exist for the current user.');
        }
      } else {
        print('No user currently logged in.');
      }
      return null; // Return null outside of the conditional checks
    } catch (e) {
      print('Error fetching assessment responses: $e');
      throw e;
    }
  }

}