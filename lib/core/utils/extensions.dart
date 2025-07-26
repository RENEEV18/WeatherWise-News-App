// The Class Represents All String Extensions.
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
}
