import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String text;
  final String senderID;
  final String receiverID;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.text,
    required this.senderID,
    required this.receiverID,
    required this.timestamp,
    required this.isRead,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      senderID: map['senderID'] ?? '',
      receiverID: map['receiverID'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'senderID': senderID,
      'receiverID': receiverID,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }
}
