import 'package:intl/intl.dart';

String getEventDateLabel(DateTime startDate, DateTime endDate) {
  final now = DateTime.now();

  if (endDate.isBefore(now)) {
    final difference = now.difference(endDate);

    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  // If it's in the future, return formatted start date
  return DateFormat('d MMM yyyy').format(startDate);
}

String eventDetailsFormatDateTime(DateTime dateTime) {
  final datePart = DateFormat('MM-dd').format(dateTime);
  final timePart = DateFormat('HH:mm').format(dateTime);
  return '$datePart at $timePart';
}
