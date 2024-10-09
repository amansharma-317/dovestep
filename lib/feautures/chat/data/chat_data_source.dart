import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup/feautures/chat/domain/entities/chat_entity.dart';
import 'package:startup/feautures/chat/domain/entities/message_entity.dart';

class ChatDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> sendMessage(Message message, String chatId) async {
    try {
      print('started sending message in datasource');
      // Get the document ID
      final newDocRef = await _firestore.collection('chatrooms').doc(chatId).collection('messages').add({
        'text': message.text,
        'senderID': message.senderID,
        'receiverID': message.receiverID,
        'timestamp': message.timestamp,
        'isRead': false, // Assuming this field is part of your message model
      });
      print('message sent');

    // Use the document ID as a field in the document
      await newDocRef.update({'id': newDocRef.id});

    } catch (e) {
      print('Error sending message: $e');
      throw e;
    }
  }

  @override
  Stream<List<Message>> getMessages(String chatId, int pageSize, int pageNumber) async* {
    print(pageNumber);
    print('running');
    // Fetch the latest message
    final latestMessageSnapshot = await _firestore
        .collection('chatrooms')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (latestMessageSnapshot.docs.isNotEmpty) {
      final latestMessage = latestMessageSnapshot.docs.first;
      var latestMessageTimestamp = latestMessage['timestamp'];

      // Use the latest message timestamp to start the pagination query
      int startIndex = pageSize * pageNumber;

      yield* _firestore
          .collection('chatrooms')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          //.startAt([latestMessageTimestamp])
          //.limit(pageSize)
          .snapshots()
          .map((snapshot) {
        List<Message> messages =  snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          print(data['text'].toString());
          return Message(
            id: doc.id,
            text: data['text'],
            senderID: data['senderID'],
            receiverID: data['receiverID'],
            timestamp: data['timestamp'].toDate(),
            isRead: data['isRead'],
          );
        }).toList();

        latestMessageTimestamp = messages.isNotEmpty ? messages.last.timestamp : null;

        return messages;
      });
    } else {
      // No messages found
      yield [];
    }
  }

  @override
  Stream<List<Message>> getMessagesUsingPagination(String chatId, int pageSize, int pageNumber) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .startAfter([1 * 10])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Message(
          id: doc.id,
          text: data['text'],
          senderID: data['senderId'],
          receiverID: data['receiverId'],
          timestamp: data['timestamp'].toDate(),
          isRead: data['isRead'],
        );
      }).toList();
    });
  }

  Future<List<Chat>> getChats() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Query chatrooms where the participants array contains the current user's ID
      final querySnapshot = await _firestore
          .collection('chatrooms')
          .where('participants', arrayContains: currentUserId)
          .get();

      final List<Chat> chats = [];

      for (final doc in querySnapshot.docs) {
        final chatData = doc.data() as Map<String, dynamic>;
        final participants = List<String>.from(chatData['participants']);

        // Fetch last message for the chat
        final lastMessageQuerySnapshot = await doc.reference
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        Message? lastMessage;
        if (lastMessageQuerySnapshot.docs.isNotEmpty) {
          final lastMessageData = lastMessageQuerySnapshot.docs.first.data();
          lastMessage = Message.fromMap(lastMessageData);
        }

        final chat = Chat(
          chatId: doc.id, // Pass the chat ID
          participants: participants,
          lastMessage: lastMessage,
        );
        chats.add(chat);
      }

      return chats;
    } catch (e) {
      print('Error fetching chats: $e');
      throw e;
    }
  }






// implement mark messages as read feature
}