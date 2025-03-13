// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:uniswap/core/app_export.dart';

// class TimeBid extends StatefulWidget {
//   const TimeBid({
//     super.key,
//     required this.time,
//     required this.date,
//   });

//   final String? date;
//   final String? time;

//   @override
//   State<TimeBid> createState() => _TimeBidState();
// }

// class _TimeBidState extends State<TimeBid> {
//   late DateTime targetDate;
//   Duration timeLeft = Duration.zero;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     // Parse the date and time into a DateTime object
//     targetDate = parseDateTime(widget.date, widget.time);
//     // Start the countdown timer
    
//     startTimer();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         timeLeft = targetDate.difference(DateTime.now());
//         // Stop the timer if the countdown reaches zero
//         if (timeLeft.isNegative) {
//           _timer?.cancel();
//           timeLeft = Duration.zero;
//         }
//       });
//     });
//   }

//   DateTime parseDateTime(String? date, String? time) {
//     if (date == null || time == null) {
//       // return DateTime.now().add(Duration(days: 0)); // Fallback to a default date
//       return DateTime.now(); // Fallback to a default date
//     }

//     try {
//       // Parse the date (31/01/2025)
//       final dateParts = date.split('/');
//       final day = int.parse(dateParts[0]);
//       final month = int.parse(dateParts[1]);
//       final year = int.parse(dateParts[2]);

//       // Parse the time (6:30 PM)
//       final timeParts = time.split(' ');
//       final hourMinute = timeParts[0].split(':');
//       final hour = int.parse(hourMinute[0]) + (timeParts[1] == "PM" ? 12 : 0);
//       final minute = int.parse(hourMinute[1]);

//       return DateTime(year, month, day, hour, minute);
//     } catch (e) {
//       print("Error parsing date or time: $e");
//       return DateTime.now().add(Duration(days: 1)); // Fallback to a default date
//     }
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final days = timeLeft.inDays;
//     final hours = timeLeft.inHours.remainder(24);
//     final minutes = timeLeft.inMinutes.remainder(60);
//     final seconds = timeLeft.inSeconds.remainder(60);

//     return Text(
//       "$days days $hours hours $minutes min $seconds seconds",
//       style: TextStyle(
//         color: Color(0xFFE11D48),
//         fontSize: 10.sp,
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class TimeBid extends StatefulWidget {
  const TimeBid({
    super.key,
    required this.time,
    required this.date,
  });

  final String? date;
  final String? time;

  @override
  State<TimeBid> createState() => _TimeBidState();
}

class _TimeBidState extends State<TimeBid> {
  late DateTime targetDate;
  Duration timeLeft = Duration.zero; // Initialize with a default value
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Parse the date and time into a DateTime object
    targetDate = parseDateTime(widget.date, widget.time);
    // Start the countdown timer
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft = targetDate.difference(DateTime.now());
        // Stop the timer if the countdown reaches zero or goes negative
        if (timeLeft.isNegative || timeLeft == Duration.zero) {
          _timer?.cancel();
          timeLeft = Duration.zero; // Set to zero to display 0 values
        }
      });
    });
  }

  DateTime parseDateTime(String? date, String? time) {
    if (date == null || time == null) {
      throw ArgumentError("Date and time must not be null");
    }

    try {
      // Parse the date (31/01/2025)
      final dateParts = date.split('/');
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      // Parse the time (6:30 PM)
      final timeParts = time.split(' ');
      final hourMinute = timeParts[0].split(':');
      int hour = int.parse(hourMinute[0]);
      final minute = int.parse(hourMinute[1]);

      // Handle 12-hour format (AM/PM)
      if (timeParts[1] == "PM" && hour != 12) {
        hour += 12;
      } else if (timeParts[1] == "AM" && hour == 12) {
        hour = 0;
      }

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      throw FormatException("Invalid date or time format: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = timeLeft.inDays;
    final hours = timeLeft.inHours.remainder(24);
    final minutes = timeLeft.inMinutes.remainder(60);
    final seconds = timeLeft.inSeconds.remainder(60);

    return Text(
      "$days days $hours hours $minutes min $seconds seconds",
      style: TextStyle(
        color: Color(0xFFE11D48),
        fontSize: 10.sp,
      ),
    );
  }
}

