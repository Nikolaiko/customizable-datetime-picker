import 'package:customizable_datetime_picker/sources/model/date_picker_divider_theme.dart';
import 'package:flutter/material.dart';

/// Default value of DatePicker's background color.
const defaultPickerBackground = Colors.white;

/// Default value of whether show title widget or not.
const showTitleDefaultValue = true;

/// Default value of DatePicker's height.
const double defaultPickerHeight = 160.0;

/// Default value of DatePicker's title height.
const double defaultPickerTitleHeight = 36.0;

/// Default value of DatePicker's column height.
const double defaultPickerItemHeight = 36.0;

/// Default value of DatePicker's item [TextStyle].
const TextStyle defaultItemTextStyle =
    TextStyle(color: Colors.black, fontSize: 16.0);

const Color defaultTextColor = Colors.black;

const double pickerSmallItemTextSize = 15;
const double pickerBigItemTextSize = 17;

///
const double defaultPickerSqueeze = 1.2;

///
const double defaultPickerDiameterRatio = 2;

/// To support both stable and beta channels until
/// 'DiagnosticableMixin' is officially deprecated.
class DateTimePickerTheme {
  final cancelDefault = const Text('OK');

  /// DateTimePicker theme.
  ///
  /// [backgroundColor] DatePicker's background color.
  /// [cancelTextStyle] Default cancel widget's [TextStyle].
  /// [confirmTextStyle] Default confirm widget's [TextStyle].
  /// [cancel] Custom cancel widget.
  /// [confirm] Custom confirm widget.
  /// [title] Custom title widget. If specify a title widget, the cancel and confirm widgets will not display. Must set [titleHeight] value for custom title widget.
  /// [showTitle] Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  /// [pickerHeight] The value of DatePicker's height.
  /// [titleHeight] The value of DatePicker's title height.
  /// [itemHeight] The value of DatePicker's column height.
  /// [itemTextStyle] The value of DatePicker's column [TextStyle].
  /// [diameterRatio] Diameter ratio of the picker.
  /// [squeeze] Squeeze of the picker.
  /// [dividerTheme] Theme for horizonatal dividers.
  const DateTimePickerTheme({
    this.backgroundColor = defaultPickerBackground,
    this.cancelTextStyle,
    this.confirmTextStyle,
    this.cancel,
    this.confirm,
    this.title,
    this.showTitle = showTitleDefaultValue,
    this.pickerHeight = defaultPickerHeight,
    this.titleHeight = defaultPickerTitleHeight,
    this.itemHeight = defaultPickerItemHeight,
    this.itemTextStyle = defaultItemTextStyle,
    this.squeeze = defaultPickerSqueeze,
    this.diameterRatio = defaultPickerDiameterRatio,
    this.dividerTheme = DatePickerDividerTheme.defaultPickerDividersTheme,
  });

  static const DateTimePickerTheme defaultPickerTheme = DateTimePickerTheme();

  /// DatePicker's background color.
  final Color backgroundColor;

  /// Default cancel widget's [TextStyle].
  final TextStyle? cancelTextStyle;

  /// Default confirm widget's [TextStyle].
  final TextStyle? confirmTextStyle;

  /// Custom cancel [Widget].
  final Widget? cancel;

  /// Custom confirm [Widget].
  final Widget? confirm;

  /// Custom title [Widget]. If specify a title widget, the cancel and confirm widgets will not display.
  final Widget? title;

  /// Whether display title widget or not. If set false, the default cancel and confirm widgets will not display, but the custom title widget will display if had specified one custom title widget.
  final bool showTitle;

  /// The value of DatePicker's height.
  final double pickerHeight;

  /// The value of DatePicker's title height.
  final double titleHeight;

  /// The value of DatePicker's column height.
  final double itemHeight;

  /// The value of DatePicker's column [TextStyle].
  final TextStyle itemTextStyle;

  /// The value of DatePicker's Divider Color [TextStyle].
  final DatePickerDividerTheme dividerTheme;

  ///
  final double squeeze;

  ///
  final double diameterRatio;
}
