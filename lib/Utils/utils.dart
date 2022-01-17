// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(BuildContext context, String message,
      {Color color = Colors.black87}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  setSpeed(String sppedText) {
    switch (sppedText) {
      case "Slow":
        return 35;
      case "Medium":
        return 75;
      case "Fast":
        return 150;
      default:
        return 75;
    }
  }

  nextDraw() {
    DateTime now = DateTime.now();
    if (now
        .difference(DateTime(now.year, now.month, now.day, 9, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 9, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 9, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 9, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 9, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 9, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 9, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 9, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 10, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 10, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 10, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 10, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 10, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 10, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 10, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 10, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 11, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 11, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 11, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 11, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 11, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 11, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 11, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 11, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 12, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 12, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 12, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 12, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 12, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 12, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 12, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 12, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 13, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 13, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 13, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 13, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 13, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 13, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 13, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 13, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 14, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 14, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 14, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 14, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 14, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 14, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 14, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 14, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 15, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 15, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 15, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 15, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 15, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 15, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 15, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 15, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 16, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 16, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 16, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 16, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 16, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 16, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 16, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 16, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 17, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 17, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 17, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 17, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 17, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 17, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 17, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 17, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 18, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 18, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 18, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 18, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 18, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 18, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 18, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 18, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 19, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 19, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 19, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 19, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 19, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 19, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 19, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 19, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 20, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 20, 00, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 20, 15, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 20, 15, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 20, 30, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 20, 30, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 20, 45, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 20, 45, 0, 0);
    } else if (now
        .difference(DateTime(now.year, now.month, now.day, 21, 00, 0, 0))
        .isNegative) {
      return DateTime(now.year, now.month, now.day, 21, 00, 0, 0);
    } else {
      return DateTime(now.year, now.month, now.day + 1, 9, 00, 0, 0);
    }
  }

  Future setTime(String selectedTime) async {
    DateTime tempDate = DateTime.now();
    DateTime date;
    switch (selectedTime) {
      case "select Time":
        return;
      case "9:00 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 9, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "9:15 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 9, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "9:30 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 9, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "9:45 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 9, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "10:00 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 10, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "10:15 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 10, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "10:30 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 10, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "10:45 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 10, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "11:00 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 11, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "11:15 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 11, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "11:30 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 11, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "11:45 AM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 11, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "12:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 12, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "12:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 12, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "12:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 12, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "12:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 12, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "1:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 13, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "1:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 13, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "1:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 13, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "1:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 13, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "2:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 14, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "2:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 14, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "2:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 14, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "2:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 14, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "3:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 15, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "3:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 15, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "3:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 15, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "3:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 15, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "4:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 16, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "4:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 16, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "4:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 16, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "4:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 16, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "5:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 17, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "5:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 17, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "5:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 17, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "5:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 17, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "6:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 18, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "6:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 18, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "6:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 18, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "6:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 18, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "7:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 19, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "7:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 19, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "7:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 19, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "7:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 19, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "8:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 20, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "8:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 20, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "8:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 20, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "8:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 20, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "9:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 21, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      case "9:15 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 21, 15,
            tempDate.second, tempDate.millisecond);
        return date;
      case "9:30 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 21, 30,
            tempDate.second, tempDate.millisecond);
        return date;
      case "9:45 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 21, 45,
            tempDate.second, tempDate.millisecond);
        return date;
      case "10:00 PM":
        date = DateTime(tempDate.year, tempDate.month, tempDate.day, 22, 00,
            tempDate.second, tempDate.millisecond);
        return date;
      default:
        return;
    }
    // print(date.toIso8601String());
  }
}
