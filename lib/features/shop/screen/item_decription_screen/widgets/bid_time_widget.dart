import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uniswap/core/app_export.dart';

class TimeBal extends StatefulWidget {
  const TimeBal({
    super.key,
    required this.time,
    required this.date,
  });

  final String? date;
  final String? time;

  @override
  State<TimeBal> createState() => _TimeBalState();
}

class _TimeBalState extends State<TimeBal> {
  late DateTime targetDate;
  Duration timeLeft = Duration.zero;
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
        // Stop the timer if the countdown reaches zero
        if (timeLeft.isNegative) {
          _timer?.cancel();
          timeLeft = Duration.zero;
        }
      });
    });
  }

  DateTime parseDateTime(String? date, String? time) {
    if (date == null || time == null) {
      
      return DateTime.now().add(Duration(days: 0)); // Fallback to a default date
      // return DateTime.now(); // Fallback to a default date
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
      final hour = int.parse(hourMinute[0]) + (timeParts[1] == "PM" ? 12 : 0);
      final minute = int.parse(hourMinute[1]);

      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      print("Error parsing date or time: $e");
      return DateTime.now().add(Duration(days: 0)); // Fallback to a default date
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$days days $hours hours $minutes min $seconds seconds",
          style: CustomTextStyles.text12wBold,
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Text(
            "Left to bid",
            style: CustomTextStyles.text12w400cpink,
          ),
        ),
      ],
    );
  }
}