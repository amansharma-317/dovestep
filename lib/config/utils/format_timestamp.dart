import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(String timestamp) {
  DateTime now = DateTime.now();

  // Split the timestamp string into date and time parts
  List<String> parts = timestamp.split(' – ');
  String dateString = parts[0];
  String timeString = parts[1];

  // Split the date into year, month, and day
  List<String> dateParts = dateString.split('-');
  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);

  // Split the time into hour and minute
  List<String> timeParts = timeString.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  DateTime postTime = DateTime(year, month, day, hour, minute);

  Duration difference = now.difference(postTime);

  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'just now';
  }
}

String timeAgo(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}min${difference.inMinutes == 1 ? '' : 's'}';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h${difference.inHours == 1 ? '' : ''}';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}d${difference.inDays == 1 ? '' : ''}';
  } else {
    return '${(difference.inDays / 7).floor()} w${(difference.inDays / 7).floor() == 1 ? '' : ''}';
  }
}

String formatTimestampForChatScreen(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (now.year == timestamp.year &&
      now.month == timestamp.month &&
      now.day == timestamp.day) {
    return DateFormat.jm().format(timestamp); // Today's message, display time only
  } else {
    return DateFormat('MMM d, h:mm a').format(timestamp); // Older message, display date and time
  }
}



