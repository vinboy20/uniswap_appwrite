bool isProductExpired(String? bidEndDate, String? bidEndTime) {
  if (bidEndDate == null || bidEndTime == null) {
    return false; // If no date/time is set, consider it not expired
  }

  try {
    // Parse the date (e.g., "31/01/2025")
    final dateParts = bidEndDate.split('/');
    final day = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    // Parse the time (e.g., "6:30 PM")
    final timeParts = bidEndTime.split(' ');
    final hourMinute = timeParts[0].split(':');
    final hour = int.parse(hourMinute[0]) + (timeParts[1] == "PM" ? 12 : 0);
    final minute = int.parse(hourMinute[1]);

    // Create a DateTime object for the bid end
    final bidEndDateTime = DateTime(year, month, day, hour, minute);

    // Compare with the current time
    return DateTime.now().isAfter(bidEndDateTime);
  } catch (e) {
    print("Error parsing date or time: $e");
    return false; // If parsing fails, consider it not expired
  }
}