import 'package:intl/intl.dart';

class TimestampConverter {
  static String formatFirestoreTimestamp(String timestampString) {
    // Replace the em dash with a regular hyphen
    timestampString = timestampString.replaceAll('–', '-');

    // Split the timestamp string by the separator '-'
    List<String> parts = timestampString.split(' - ');

    // Extract date and time parts
    String datePart = parts[0].trim();
    String timePart = parts[1].trim();

    // Combine date and time with a space in between
    String combinedDateTime = '$datePart $timePart';

    // Parse the combined date and time string into a DateTime object
    DateTime timestamp = DateTime.parse(combinedDateTime);

    // Format the DateTime object into a different format
    DateFormat formatter = DateFormat('MMM dd, yyyy - HH:mm');
    String formattedDateTime = formatter.format(timestamp);

    return formattedDateTime;
  }
}