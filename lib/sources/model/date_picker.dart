import 'package:customizable_datetime_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';

import 'date_picker_constants.dart';

enum DateTimePickerMode {
  /// Display DatePicker
  date,

  /// Display TimePicker
  time,

  /// Display DateTimePicker
  datetime,
}

class DatePicker {
  /// Gets the right [DateTimePickerLocale] by a language string
  ///
  /// languageCode: [languageCode] Locale's String language code
  static DateTimePickerLocale localeFromString(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return DateTimePickerLocale.zhCn;

      case 'pt':
        return DateTimePickerLocale.ptBr;

      case 'es':
        return DateTimePickerLocale.es;

      case 'ro':
        return DateTimePickerLocale.ro;

      case 'bn':
        return DateTimePickerLocale.bn;

      case 'ar':
        return DateTimePickerLocale.ar;

      case 'jp':
        return DateTimePickerLocale.jp;

      case 'ru':
        return DateTimePickerLocale.ru;

      case 'de':
        return DateTimePickerLocale.de;

      case 'ko':
        return DateTimePickerLocale.ko;

      case 'it':
        return DateTimePickerLocale.it;

      case 'hu':
        return DateTimePickerLocale.hu;

      case 'he':
        return DateTimePickerLocale.he;

      case 'id':
        return DateTimePickerLocale.id;

      case 'tr':
        return DateTimePickerLocale.tr;

      case 'nb':
        return DateTimePickerLocale.noNb;

      case 'nn':
        return DateTimePickerLocale.noNn;

      case 'fr':
        return DateTimePickerLocale.fr;

      case 'th':
        return DateTimePickerLocale.th;

      case 'nl':
        return DateTimePickerLocale.nl;

      case 'ht':
        return DateTimePickerLocale.ht;

      case 'sv':
        return DateTimePickerLocale.sv;

      case 'cz':
        return DateTimePickerLocale.cz;

      case 'pl':
        return DateTimePickerLocale.pl;

      default:
        return DateTimePickerLocale.enUs;
    }
  }

  /// Display date picker in bottom sheet.
  ///
  /// context: [BuildContext]
  /// firstDate: [DateTime] minimum date time
  /// lastDate: [DateTime] maximum date time
  /// initialDateTime: [DateTime] initial date time for selected
  /// dateFormat: [String] date format pattern
  /// locale: [DateTimePickerLocale] internationalization
  /// backgroundColor: [Color] background color of the dialog
  /// itemTextStyle: [TextStyle] item TextStyle of the picker
  /// titleText: [String] text of the dialog's title
  /// confirmText: [String] text of the dialog's confirm button
  /// cancelText: [String] text of the dialog's  cancel button
  static Future<DateTime?> showSimpleDatePicker(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
    String? dateFormat,
    DateTimePickerLocale locale = pickerLocaleDefault,
    DateTimePickerMode pickerMode = DateTimePickerMode.date,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? itemTextStyle,
    String? titleText,
    String? confirmText,
    String? cancelText,
    bool looping = false,
    bool reverse = false,
  }) {
    DateTime? selectedDate = initialDate;
    final List<Widget> listButtonActions = [
      TextButton(
        style: TextButton.styleFrom(foregroundColor: textColor),
        child: Text(confirmText ?? "OK"),
        onPressed: () {
          Navigator.pop(context, selectedDate);
        },
      ),
      TextButton(
        style: TextButton.styleFrom(foregroundColor: textColor),
        child: Text(cancelText ?? "Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ];

    // handle the range of datetime
    firstDate ??= DateTime.parse(datePickerMinDateTime);
    lastDate ??= DateTime.parse(datePickerMaxDateTime);

    // handle initial DateTime
    initialDate ??= DateTime.now();

    backgroundColor ??= DateTimePickerTheme.defaultPickerTheme.backgroundColor;
//    if (itemTextStyle == null)
//      itemTextStyle = DateTimePickerTheme.Default.itemTextStyle;

    textColor ??= DateTimePickerTheme.defaultPickerTheme.itemTextStyle.color;

    var datePickerDialog = AlertDialog(
      title: Text(
        titleText ?? "Select Date",
        style: TextStyle(color: textColor),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
      backgroundColor: backgroundColor,
      content: SizedBox(
        width: 300,
        child: CustomizableDatePickerWidget(
          firstDate: firstDate,
          lastDate: lastDate,
          initialDate: initialDate,
          dateFormat: dateFormat,
          locale: locale,
          pickerTheme: DateTimePickerTheme(
            backgroundColor: backgroundColor,
            itemTextStyle: itemTextStyle ?? TextStyle(color: textColor),
          ),
          onChange: ((DateTime date, list) {            
            selectedDate = date;
          }),
          looping: looping,
        ),
      ),
      actions:
          reverse ? listButtonActions.reversed.toList() : listButtonActions,
    );
    return showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) => datePickerDialog);
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.minDateTime,
    this.maxDateTime,
    this.initialDateTime,
    this.dateFormat,
    this.locale,
    this.pickerMode,
    this.pickerTheme,
    this.onCancel,
    this.onChange,
    this.onConfirm,
    this.theme,
    this.barrierLabel,
    RouteSettings? settings,
  }) : super(settings: settings);

  final DateTime? minDateTime, maxDateTime, initialDateTime;
  final String? dateFormat;
  final DateTimePickerLocale? locale;
  final DateTimePickerMode? pickerMode;
  final DateTimePickerTheme? pickerTheme;
  final VoidCallback? onCancel;
  final DateValueCallback? onChange;
  final DateValueCallback? onConfirm;

  final ThemeData? theme;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    double height = pickerTheme!.pickerHeight;
    if (pickerTheme!.title != null || pickerTheme!.showTitle) {
      height += pickerTheme!.titleHeight;
    }

    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(route: this, pickerHeight: height),
    );

    if (theme != null) {
      bottomSheet = Theme(data: theme!, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatelessWidget {
  final _DatePickerRoute route;
  final double _pickerHeight;

  const _DatePickerComponent({required this.route, required pickerHeight})
      : _pickerHeight = pickerHeight;

  @override
  Widget build(BuildContext context) {
    Widget pickerWidget = CustomizableDatePickerWidget(
      firstDate: route.minDateTime,
      lastDate: route.maxDateTime,
      initialDate: route.initialDateTime,
      dateFormat: route.dateFormat,
      locale: route.locale,
      pickerTheme: route.pickerTheme ?? DateTimePickerTheme.defaultPickerTheme,      
      onChange: route.onChange,      
    );
    return GestureDetector(
      child: AnimatedBuilder(
        animation: route.animation!,
        builder: (BuildContext context, Widget? child) {
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(route.animation!.value,
                  contentHeight: _pickerHeight),
              child: pickerWidget,
            ),
          );
        },
      ),
    );
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.contentHeight});

  final double progress;
  final double? contentHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: contentHeight!,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
