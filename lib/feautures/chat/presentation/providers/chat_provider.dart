import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/feautures/chat/data/chat_data_source.dart';
import 'package:startup/feautures/chat/data/chat_repository_impl.dart';
import 'package:startup/feautures/chat/domain/chat_repository.dart';
import 'package:startup/feautures/chat/domain/entities/chat_entity.dart';
import 'package:startup/feautures/chat/domain/entities/message_entity.dart';
import 'package:startup/feautures/chat/domain/entities/send_message_params.dart';
import 'package:startup/feautures/chat/domain/params/pagination_params.dart';

final chatDataSourceProvider = Provider<ChatDataSource>((ref) {
  return ChatDataSource();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final dataSource = ref.read(chatDataSourceProvider);
  return ChatRepositoryImpl(dataSource);
});

final sendMessageProvider = FutureProvider.autoDispose.family<void, SendMessageParams>((ref, params) async {
  final repository = ref.read(chatRepositoryProvider);

  if (params.message.text.isNotEmpty) {
    await repository.sendMessage(params.message, params.chatId); // Assuming sendMessage method takes chatId and message
  } else {
    print('no text in the message to send');
  }
});

final messagesProvider = StreamProvider.family<List<Message>, String>((ref, chatId) {
  final pageSize = ref.watch(pageSizeProvider.notifier).state;
  final pageNumber = ref.watch(pageNumberProvider.notifier).state;
  final repository = ref.read(chatRepositoryProvider);
  return repository.getMessages(chatId, pageSize, pageNumber);
});

final pageSizeProvider = StateProvider<int>((ref) => 12);
final pageNumberProvider = StateProvider<int>((ref) => 1);

final messagesUsingPaginationProvider = StreamProvider.family<List<Message>, PaginationParams>((ref, params) {
  final repository = ref.read(chatRepositoryProvider);
  print(params.pageNumber);
  return repository.getMessagesUsingPagination(params.chatId, params.pageSize, params.pageNumber);
});

final chatsProvider = FutureProvider<List<Chat>>((ref) {
  final repository = ref.read(chatRepositoryProvider);
  return repository.getChats();
});


