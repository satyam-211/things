import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:things/constants/constants.dart';
import 'package:uuid/uuid.dart';

class Utils {
  static String getRandomId() {
    return const Uuid().v4();
  }

  static String toReadableDate(DateTime date) {
    return DateFormat.yMMMd('en_us').format(date);
  }

  static String toReadableTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  static String toReadableDateAndTime(DateTime date) {
    final formattedDate = DateFormat.yMMMd('en_us').format(date);
    final formattedTime = DateFormat('h:mm a').format(date);
    return '$formattedTime $formattedDate';
  }

  static void showSnackbar(
    BuildContext context,
    String? message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? Constants.kError,
        ),
      ),
    );
  }
}
