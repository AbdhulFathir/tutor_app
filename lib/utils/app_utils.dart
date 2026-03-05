class AppUtils {


  static String getDate(String rawString) {
    if (rawString.isEmpty) return "";

    // 1. Check if it's a stringified Firestore Timestamp
    if (rawString.contains("Timestamp(seconds=")) {
      final RegExp regExp = RegExp(r'seconds=(\d+)');
      final match = regExp.firstMatch(rawString);

      if (match != null && match.groupCount >= 1) {
        final int seconds = int.parse(match.group(1)!);
        final DateTime date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
        // Formats to: 28/2/2026
        return "${date.day}/${date.month}/${date.year}";
      }
    }

    // 2. Fallback: Check if it's a standard ISO-8601 string
    DateTime? parsedDate = DateTime.tryParse(rawString);
    if (parsedDate != null) {
      return "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
    }

    // 3. Return the original string if all parsing fails
    return rawString;
  }

}