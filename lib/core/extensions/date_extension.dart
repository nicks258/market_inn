import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension DateFormatExtensions on DateTime {
  String formatDateTime(String format) {
    try {
      return DateFormat(format).format(this);
    } on Exception catch (e) {
      log(e.toString());
      return DateFormat(format).format(DateTime.now());
    }
  }

  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    // final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return date.isBefore(dateTime);
  }

  bool isBetween(
      {required DateTime? fromDateTime, required DateTime? toDateTime}) {
    if (fromDateTime == null || toDateTime == null) {
      return false;
    }
    final date = this;

    final isAfter = date.isAfterOrEqualTo(fromDateTime);
    final isBefore = date.isBeforeOrEqualTo(toDateTime);
    if (isAfter && isBefore) {
      debugPrint("slot $this is between $fromDateTime - $toDateTime");
    }
    return isAfter && isBefore;
  }
}
