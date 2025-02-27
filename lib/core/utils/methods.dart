import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

void pickDate(BuildContext context, Function(DateTime) onConfirm) {
  DatePicker.showDateTimePicker(
    context,
    showTitleActions: true,
    currentTime: DateTime.now(),
    minTime: DateTime.now().add(const Duration(minutes: 2)),
    onConfirm: onConfirm,
    locale: LocaleType.en,
  );
}

String formatDate(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}

String formatTime(DateTime dateTime) {
  String period = dateTime.hour >= 12 ? 'PM' : 'AM';
  int hour = dateTime.hour > 12
      ? dateTime.hour - 12
      : (dateTime.hour == 0 ? 12 : dateTime.hour);
  return "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period";
}

//******************PARSE METHOD*******************//
double? parseDouble(String val) {
  try {
    return double.tryParse(val);
  } catch (e) {
    return null;
  }
}
