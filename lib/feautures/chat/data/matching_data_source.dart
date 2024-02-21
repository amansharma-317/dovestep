import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup/core/models/assessment_model.dart';
import 'dart:math';

import 'package:startup/feautures/chat/domain/entities/match_user_result.dart';

class MatchingDataSource {
  @override
  //This future will run periodically
  Future<MatchUserResult> matchUser(MentalHealthAssessment currentUserAssessment) async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Add the user to the chat queue if not already present
        final isUserAddedToQueue = await addUserToChatQueue();

        if (!isUserAddedToQueue) {
          return MatchUserResult(success: false, errorMessage: 'You are already in the Chat Queue.');
        }
        // Find potential matches (Here, three things are being returned :- the assessment, the userId, and the distance)
        List<_AssessmentDistanceWithUserId>? nearestNeighbours = await getKNearestNeighbors(currentUserAssessment, 5);
        // Choose the best match (returns the userId of the user to be matched with)
        String? selectedMatchUserId = _chooseBestMatch(currentUserAssessment, nearestNeighbours);

        if (selectedMatchUserId != null) {
          final userIds = [currentUser.uid, selectedMatchUserId];
          userIds.sort();  // Sort in alphabetical order
          final chatRoomId = userIds.join('-');  // Combine

          final chatroomDoc = _firestore.collection('chatrooms').doc(chatRoomId);
          final docExists = await chatroomDoc.get().then((doc) => doc.exists);
          if (docExists) {
            return MatchUserResult(success: false, errorMessage: 'Your chatroom already exists.');
          } else {
            // Create chatroom
            await chatroomDoc.set({
              'participants': [currentUser.uid, selectedMatchUserId]
            });

            // Remove users from the chat queue
            QuerySnapshot currentUserDocs = await _firestore
                .collection('chatQueue')
                .where('userId', isEqualTo: currentUser.uid)
                .get();

            for (DocumentSnapshot doc in currentUserDocs.docs) {
              await doc.reference.delete();
            }

            QuerySnapshot selectedMatchUserDocs = await _firestore
                .collection('chatQueue')
                .where('userId', isEqualTo: selectedMatchUserId)
                .get();

            for (DocumentSnapshot doc in selectedMatchUserDocs.docs) {
              await doc.reference.delete();
            }


            return MatchUserResult(success: true);
          }
        } else {
          return MatchUserResult(success: false, errorMessage: 'No suitable match found.');
        }
      } else {
        return MatchUserResult(success: false, errorMessage: 'No User currently logged in.');
      }
    } catch (e) {
      return MatchUserResult(success: false, errorMessage: e.toString());
    }
  }

  String? _chooseBestMatch(MentalHealthAssessment user, List<_AssessmentDistanceWithUserId>? candidates) {
    if (candidates == null || candidates.isEmpty) {
      return null;
    }
    // For simplicity, let's choose the nearest neighbor as the best match
    return candidates[1].userId;
  }


  @override
  Future<bool> addUserToChatQueue() async {
    print('Adding user to chat queue started');
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final currentUserId = currentUser.uid;

        // Check if the user is already in the queue before adding
        final existingUser = await _firestore
            .collection('ChatQueue')
            .where('userId', isEqualTo: currentUserId)
            .get();

        if (existingUser.docs.isEmpty) {
          // User is not in the queue, add them
          Map<String, dynamic> data = {
            'userId': currentUserId,
          };
          await _firestore.collection('ChatQueue').add(data);
          print('User added to the chat queue.');
          return true;
        } else {
          print('User is already in the chat queue.');
          return false;
        }
      } else {
        print('No user currently logged in');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<List<_AssessmentAndUserId>> fetchAllAssessmentsAndTheirUserIdsFromQueue() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      // Fetch userIds from the ChatQueue
      QuerySnapshot queueSnapshot = await _firestore.collection('ChatQueue').get();
      List<String> allUserIdsInQueue = queueSnapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['userId'] as String).toList();

      // Fetch assessments for each userId
      final assessmentsAndUserIds = await Future.wait(allUserIdsInQueue.map((userId) async {
        DocumentSnapshot userDocumentSnapshot = await _firestore.collection('users').doc(userId).get();
        Map<String, dynamic> assessmentResponses = (userDocumentSnapshot.data()! as Map<String, dynamic>)['assessmentResponses'] as Map<String, dynamic>;
        MentalHealthAssessment assessment = MentalHealthAssessment.fromMap(assessmentResponses);

        return _AssessmentAndUserId(assessment: assessment, userId: userId);
      }));

      return assessmentsAndUserIds;
    } catch (e) {
      print('Error fetching assessments from the queue: $e');
      throw e;
    }
  }


  @override
  Future<List<_AssessmentDistanceWithUserId>> getKNearestNeighbors(MentalHealthAssessment user, int k) async {
    // Logic to fetch k nearest neighbors using the KNN algorithm
    final List<_AssessmentAndUserId> allAssessments = await fetchAllAssessmentsAndTheirUserIdsFromQueue();
    // Calculate distances from the user's assessment to all other assessments
    final List<_AssessmentDistanceWithUserId> listOfAssessmentAndDistances = allAssessments
        .map((assessmentWithUserId) => _AssessmentDistanceWithUserId(
      assessment: assessmentWithUserId.assessment,
      distance: _calculateDistance(user, assessmentWithUserId.assessment),
      userId: assessmentWithUserId.userId,
    ))
        .toList();



    // Sort the assessments by distance in ascending order
    listOfAssessmentAndDistances.sort((a, b) => a.distance.compareTo(b.distance));

    return listOfAssessmentAndDistances;
  }

  double _calculateDistance(MentalHealthAssessment user, MentalHealthAssessment assessment) {
    final List<int> userFeatures = [
      user.moodStability,
      user.stressLevels,
      user.emotionalResilience,
      user.selfEsteem,
      user.qualityOfSleep,
    ];

    final List<int> assessmentFeatures = [
      assessment.moodStability,
      assessment.stressLevels,
      assessment.emotionalResilience,
      assessment.selfEsteem,
      assessment.qualityOfSleep,
    ];

    final List<int> weights = [4, 5, 3, 2, 4]; // Adjust weights as per your requirements

    double sum = 0.0;
    for (int i = 0; i < userFeatures.length; i++) {
      sum += weights[i] *
          (userFeatures[i] - assessmentFeatures[i]) *
          (userFeatures[i] - assessmentFeatures[i]);
    }

    return sum;
  }

// Helper class to store assessment and distance

}

class _AssessmentDistanceWithUserId {
  final MentalHealthAssessment assessment;
  final double distance;
  final String userId;

  _AssessmentDistanceWithUserId({required this.assessment, required this.distance, required this.userId});
}

class _AssessmentAndUserId {
  final MentalHealthAssessment assessment;
  final String userId;

  _AssessmentAndUserId({required this.assessment, required this.userId});
}

class _UserIdsandDistances {
  final double distance;
  final String userId;

  _UserIdsandDistances({required this.distance, required this.userId});
}





