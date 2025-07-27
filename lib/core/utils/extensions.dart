// The Class Represents All String Extensions.
import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  // Capitalizes the first letter of each word (Title Case)
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

// The Class Represents Some Helper Format Functions.
class HelperFormatFunctions {
  String checkValue(String? value) {
    if (value == null || value.isEmpty || value == 'null' || value == 'Null') {
      return 'No data';
    } else {
      return value;
    }
  }

  String formatDay(DateTime? dateTime) {
    if (dateTime == null) return '';
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][dateTime.weekday % 7];
  }

  String formatPublishedDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }
}
