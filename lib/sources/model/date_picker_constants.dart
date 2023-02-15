import 'package:flutter/material.dart';

typedef DateValueCallback = Function(DateTime dateTime, List<int> selectedIndex);
typedef DateVoidCallback = Function();

const String datePickerMinDateTime = "1900-01-01 00:00:00";
const String datePickerMaxDateTime = "2100-12-31 23:59:59";
const String defaultDateFormat = 'yyyy-MMM-dd';
const String defaultTimeFormat = 'HH:mm:ss';
const String defaultDateTimePickerFormat = 'yyyyMMdd HH:mm:ss';

const EdgeInsets pickerPaddings = EdgeInsets.symmetric(horizontal: 7, vertical: 18);
const double dividerPadding = 0.2678571429;
