import 'package:startup/feautures/chat/domain/entities/chat_entity.dart';
import 'package:startup/feautures/chat/domain/entities/message_entity.dart';

abstract class ChatRepository {
  Future<void> sendMessage(Message message, String chatId);
  Stream<List<Message>> getMessages(String chatId, int pageSize, int pageNumber);
  Stream<List<Message>> getMessagesUsingPagination(String chatId, int pageSize, int pageNumber);
  Future<List<Chat>> getChats();
}
