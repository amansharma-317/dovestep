import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String bookingId;
  final String userId;
  final String therapistId;
  final DateTime dateTime;
  final String status;
  final String paymentStatus;
  final double totalAmount;
  final Timestamp createdAt;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.therapistId,
    required this.dateTime,
    required this.status,
    required this.paymentStatus,
    required this.totalAmount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'therapistId': therapistId,
      'dateTime': dateTime,
      'status': status,
      'paymentStatus': paymentStatus,
      'totalAmount': totalAmount,
      'createdAt': createdAt,
    };
  }

  static Booking fromMap(Map<String, dynamic> map) {
    return Booking(
      bookingId: map['bookingId'],
      userId: map['userId'],
      therapistId: map['therapistId'],
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      status: map['status'],
      paymentStatus: map['paymentStatus'],
      totalAmount: map['totalAmount'],
      createdAt: map['createdAt'] as Timestamp,
    );
  }
}
