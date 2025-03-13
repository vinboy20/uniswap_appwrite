import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount); //Customize the currency locale and symbol as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    //assuming 10 digit USA phone number format
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }

    // add more custom phone number formatting if needed
    return phoneNumber;
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {
    //remove any non digit characters from the phone num
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    //extract the country code from digits only
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    //add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode)');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write('');
      }
      i = end;
    }
    return internationalFormatPhoneNumber(phoneNumber);
  }

  static formattedPrice(num? price) {
    if (price == null) return '₦0';
    return '₦${NumberFormat('#,##0', 'en_US').format(price)}';
  }

  static formattedStringPrice(String? startPrice) {
    if (startPrice == null || startPrice.isEmpty) return '₦0';

    // Convert the string to a num
    final num? price = num.tryParse(startPrice);

    // If parsing fails, default to 0
    if (price == null) return '₦0';

    // Format the number
    return '₦${NumberFormat('#,##0', 'en_US').format(price)}';
  }

  // Usage:
  // Text(formattedPrice(product?.startPrice))

  static formattedDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  // Add this function to your code
static formatDateTime(DateTime dateTime) {
  // Define the format
  final DateFormat formatter = DateFormat('MMMM d, h:mm a');

  // Format the DateTime
  String formatted = formatter.format(dateTime);

  // Add the ordinal suffix (e.g., 1st, 2nd, 3rd, 4th, etc.)
  final String day = dateTime.day.toString();
  String suffix = _getOrdinalSuffix(int.parse(day));

  // Replace the day with the day + suffix
  formatted = formatted.replaceFirst(day, '$day$suffix');

  return formatted;
}

// Helper function to get the ordinal suffix
static String _getOrdinalSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
  
}
