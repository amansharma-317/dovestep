import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup/core/models/assessment_model.dart';

import '../models/user_model.dart';

abstract class UserDataSource {
  Future<UserProfile> fetchUserData();
  Future<UserProfile> fetchUserDataFromId(String userId);
}

class FirebaseUserDataSource implements UserDataSource {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  @override
  Future<UserProfile> fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final uid = currentUser.uid;
        final userData = await _usersCollection.doc(uid).get();
        if (userData.exists) {
          final avatar = userData.get('avatar') ?? '';
          final phone = userData.get('phone') ?? '';
          final username = userData.get('username') ?? '';
          final createdAt = userData.get('createdAt') as Timestamp?;
          final lastLogin = userData.get('lastLogin') as Timestamp?;
          print('hello');
          final mentalHealthAssessmentMap = userData.get('assessmentResponses') as Map<String, dynamic>;;
          final assessmentResponses =
          MentalHealthAssessment.fromMap(mentalHealthAssessmentMap);

          return UserProfile(
            userId: uid,
            username: username,
            phone: phone,
            avatar: avatar,
            createdAt: createdAt!,
            lastLogin: lastLogin!,
            assessmentResponses: assessmentResponses,
          );
        } else {
          throw Exception('User data not found.');
        }
      } else {
        throw Exception('No user currently logged in.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      throw e;
    }
  }

  @override
  Future<UserProfile> fetchUserDataFromId(String userId) async {
    try {
        final userData = await FirebaseFirestore.instance.collection('users').doc(userId).get();
        if (userData.exists) {
          final avatar = userData.get('avatar') ?? '';
          final phone = userData.get('phone') ?? '';
          final username = userData.get('username') ?? '';
          final createdAt = userData.get('createdAt') as Timestamp?;
          final lastLogin = userData.get('lastLogin') as Timestamp?;
          final mentalHealthAssessmentMap = userData.get('assessmentResponses') as Map<String, dynamic>? ?? {};
          final assessmentResponses = MentalHealthAssessment.fromMap(mentalHealthAssessmentMap);

          return UserProfile(
            userId: userId,
            username: username,
            phone: phone,
            avatar: avatar,
            createdAt: createdAt ?? Timestamp.now(),
            lastLogin: lastLogin ?? Timestamp.now(),
            assessmentResponses: assessmentResponses,
          );
        } else {
          throw Exception('User data not found.');
        }
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow; // Rethrow the exception to propagate it to the caller
    }
  }
}