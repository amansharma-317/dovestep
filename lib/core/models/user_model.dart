import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup/core/models/assessment_model.dart';

class UserProfile {
  String userId;
  String username;
  String phone;
  String avatar;
  MentalHealthAssessment assessmentResponses; // Include mental health assessment responses
  final Timestamp createdAt;
  final Timestamp lastLogin;
  int? totalChats;
  int? totalTherapistBookings;

  UserProfile({
    required this.userId,
    required this.username,
    required this.assessmentResponses,
    required this.phone,
    required this.avatar,
    required this.createdAt,
    required this.lastLogin,
    this.totalChats,
    this.totalTherapistBookings,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'phone': phone,
      'avatar': avatar,
      'assessmentResponses': assessmentResponses.toMap(), // Assuming `toMap()` exists in MentalHealthAssessment
      'createdAt': createdAt,
      'lastLogin': lastLogin,
      'totalChats': totalChats,
      'totalTherapistBookings': totalTherapistBookings,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'],
      username: map['username'],
      phone: map['phone'],
      avatar: map['avatar'],
      assessmentResponses: MentalHealthAssessment.fromMap(map['assessmentResponses']),
      createdAt: map['createdAt'],
      lastLogin: map['lastLogin'],
      totalChats: map['totalChats'],
      totalTherapistBookings: map['totalTherapistBookings'],
    );
  }
}
