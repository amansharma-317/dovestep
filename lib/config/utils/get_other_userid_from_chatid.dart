String getOtherUserId(String chatId, String currentUserId) {
  // Split the chat ID into two user IDs
  List<String> userIds = chatId.split('-');

  // Determine which user ID is the other user
  String otherUserId = userIds[0] == currentUserId ? userIds[1] : userIds[0];

  return otherUserId;
}
