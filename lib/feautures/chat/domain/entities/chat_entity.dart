import 'package:startup/feautures/chat/domain/entities/message_entity.dart';

class Chat {
  final String chatId; // Add a field to store the chat ID
  final List<String> participants;
  final Message? lastMessage; // Add a field for the last message

  Chat({
    required this.chatId, // Add this line to the constructor
    required this.participants,
    required this.lastMessage, // Add this line to the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId, // Include chatId in the map
      'participants': participants,
      'lastMessage': lastMessage?.toMap(), // Convert lastMessage to a map
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map, String chatId) {
    return Chat(
      chatId: chatId, // Assign the provided chat ID to the chatId field
      participants: List<String>.from(map['participants'] ?? []),
      lastMessage: map['lastMessage'] != null ? Message.fromMap(map['lastMessage']) : null, // Create a Message object from the lastMessage map
    );
  }
}
