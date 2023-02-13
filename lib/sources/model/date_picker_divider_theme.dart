import 'package:flutter/material.dart';

class DatePickerDividerTheme {
  
  static const DatePickerDividerTheme defaultPickerDividersTheme 
    = DatePickerDividerTheme();

  static const Color defaultDividerColor = Colors.black;
  static const double defaultDividerHeight = 1;
  static const double defaultDividerThickness = 1;

  final Color dividerColor;
  final double height;
  final double thickness;

  const DatePickerDividerTheme(
    {
      this.dividerColor = defaultDividerColor,
      this.height = defaultDividerHeight,
      this.thickness = defaultDividerThickness
    }
  );
}