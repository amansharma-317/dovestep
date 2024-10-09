import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup/core/api/notification_api.dart';

final notificationApiProvider = Provider((ref) => NotificationApi());
final isInChatScreenProvider = StateProvider((ref) => false);
final messageDataProvider = StateProvider((ref) => null);
final chatActiveTopicProvider = Provider((ref) => 'chat_notifications');
final chatActiveProvider = StateProvider((ref) => false);

