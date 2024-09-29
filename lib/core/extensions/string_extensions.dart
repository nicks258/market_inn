// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/cupertino.dart';

extension StringExtensions on String {
  DateTime toDateTime() {
    try {
      return DateTime.parse(this);
    } on Exception catch (e) {
      debugPrint("error on $this");
      log(e.toString());
      return DateTime.now();
    }
  }
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
