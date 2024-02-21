import 'package:startup/feautures/chat/data/chat_data_source.dart';
import 'package:startup/feautures/chat/domain/chat_repository.dart';
import 'package:startup/feautures/chat/domain/entities/chat_entity.dart';
import 'package:startup/feautures/chat/domain/entities/message_entity.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource _dataSource;

  ChatRepositoryImpl(this._dataSource);

  @override
  Future<void> sendMessage(Message message, String chatId) async {
    await _dataSource.sendMessage(message, chatId);
  }

  @override
  Stream<List<Message>> getMessagesUsingPagination(String chatId, int pageSize, int pageNumber) {
    return _dataSource.getMessagesUsingPagination(chatId, pageSize, pageNumber);
  }

  @override
  Stream<List<Message>> getMessages(String chatId, int pageSize, int pageNumber) {
    print('hello');
    return _dataSource.getMessages(chatId, pageSize, pageNumber);
  }

  @override
  Future<List<Chat>> getChats() async {
    try {
      // Fetch chats from the data source
      final chats = await _dataSource.getChats();
      return chats;
    } catch (e) {
      // Handle errors
      throw Exception('Failed to fetch chats: $e');
    }
  }

}