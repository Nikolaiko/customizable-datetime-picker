import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:customizable_datetime_picker/sources/helpers/range_helper.dart';
import 'package:customizable_datetime_picker/sources/i18n/date_picker_i18n.dart';
import 'package:customizable_datetime_picker/sources/model/date_picker_constants.dart';
import 'package:customizable_datetime_picker/sources/model/date_picker_theme.dart';
import 'package:customizable_datetime_picker/sources/model/date_time_formatter.dart';
import 'package:customizable_datetime_picker/sources/widget/date_picker_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// DatePicker widget.
class CustomizableDatePickerWidget extends StatefulWidget {
  CustomizableDatePickerWidget({
    Key? key,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.dateFormat = defaultDateFormat,
    this.locale = pickerLocaleDefault,
    this.pickerTheme = DateTimePickerTheme.defaultPickerTheme,    
    this.onChange,
    this.looping = false,
    this.separatorWidget
  }) : super(key: key) {
    DateTime minTime = firstDate ?? DateTime.parse(datePickerMinDateTime);
    DateTime maxTime = lastDate ?? DateTime.parse(datePickerMaxDateTime);
    assert(minTime.compareTo(maxTime) < 0);
  }

  final DateTime? firstDate, lastDate, initialDate;
  final String? dateFormat;
  final DateTimePickerLocale? locale;
  final DateTimePickerTheme pickerTheme;
  final Widget? separatorWidget;

  final DateValueCallback? onChange;
  final bool looping;

  @override
  State<StatefulWidget> createState() => _CustomizableDatePickerWidgetState();
}

class _CustomizableDatePickerWidgetState extends State<CustomizableDatePickerWidget> {
  late DateTime _minDateTime, _maxDateTime;
  int? _currentYear, _currentMonth, _currentDay;
  List<int>? _yearRange, _monthRange, _dayRange;

  FixedExtentScrollController? _yearScrollCtrl;
  FixedExtentScrollController? _monthScrollCtrl;
  FixedExtentScrollController? _dayScrollCtrl;

  late Map<String, FixedExtentScrollController?> _scrollCtrlMap;
  late Map<String, List<int>?> _valueRangeMap;

  bool _isChangeDateRange = false;  
  bool _lock = false;

  @override
  void initState() {
    DateTime initDateTime = widget.initialDate ?? DateTime.now();
    _currentYear = initDateTime.year;
    _currentMonth = initDateTime.month;
    _currentDay = initDateTime.day;

    _minDateTime = widget.firstDate ?? DateTime.parse(datePickerMinDateTime);
    _maxDateTime = widget.lastDate ?? DateTime.parse(datePickerMaxDateTime);

    _yearRange = RangeHelper.calculateYearRange(_minDateTime, _maxDateTime);
    _currentYear = min(max(_minDateTime.year, _currentYear!), _maxDateTime.year);

    _monthRange = RangeHelper.calculateMonthRange(
      _minDateTime, 
      _maxDateTime, 
      _currentYear
    );
    _currentMonth = _getCurrentMonth();

    _dayRange = RangeHelper.calculateDayRange(
      currentMonth: _currentMonth,
      currentYear: _currentYear,
      minDateTime: _minDateTime,
      maxDateTime: _maxDateTime
    );
    _currentDay = min(max(_dayRange!.first, _currentDay!), _dayRange!.last);

    _yearScrollCtrl = FixedExtentScrollController(
      initialItem: _currentYear! - _yearRange!.first
    );

    _monthScrollCtrl = FixedExtentScrollController(
      initialItem: _currentMonth! - _monthRange!.first
    );

    _dayScrollCtrl = FixedExtentScrollController(
      initialItem: _currentDay! - _dayRange!.first
    );

    _scrollCtrlMap = {
      'y': _yearScrollCtrl,
      'M': _monthScrollCtrl,
      'd': _dayScrollCtrl
    };

    _valueRangeMap = {
      'y': _yearRange, 
      'M': _monthRange, 
      'd': _dayRange
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: Colors.transparent, 
        child: _renderDatePickerWidget()
      ),
    );
  }

  Widget _renderDatePickerWidget() {
    List<Widget> pickers = [];
    List<String> formatArr =
      DateTimeFormatter.splitDateFormat(widget.dateFormat);
    
    for (String format in formatArr) {
      List<int> valueRange = _findPickerItemRange(format)!;

      Widget pickerColumn = _renderDatePickerColumnComponent(
        scrollCtrl: _findScrollCtrl(format),
        valueRange: valueRange,
        format: format,
        valueChanged: (value) => _onValueChange(value, format),
        fontSize: widget.pickerTheme.itemTextStyle.fontSize 
          ?? sizeByFormat(widget.dateFormat!)
      );
      pickers.add(pickerColumn);
      
      if (widget.separatorWidget != null && formatArr.last != format) {
        pickers.add(_renderSeparatorRow(widget.separatorWidget!));
      }
    }    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: pickers
    );
  }

  Widget _renderDatePickerColumnComponent(
      {
        required FixedExtentScrollController? scrollCtrl,
        required List<int> valueRange,
        required String format,
        required ValueChanged<int> valueChanged,
        double? fontSize
      }
    ) {
      EdgeInsets topInsets =  EdgeInsets.only(
        top: (widget.pickerTheme.pickerHeight / 2) 
        + (widget.pickerTheme.itemTextStyle.fontSize! / 2)
        + widget.pickerTheme.itemHeight * dividerPadding
      );
      EdgeInsets bottomInsets =  EdgeInsets.only(
        top: (widget.pickerTheme.pickerHeight / 2) 
        - (widget.pickerTheme.itemTextStyle.fontSize! / 2)
        - widget.pickerTheme.itemHeight * dividerPadding
      );
      return Expanded(
        flex: 1,
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              child: Container(
                padding: pickerPaddings,
                height: widget.pickerTheme.pickerHeight,
                decoration: BoxDecoration(
                  color: widget.pickerTheme.backgroundColor
                ),
                child: CupertinoPicker(
                  selectionOverlay: Container(),
                  backgroundColor: widget.pickerTheme.backgroundColor,
                  scrollController: scrollCtrl,
                  squeeze: widget.pickerTheme.squeeze,
                  diameterRatio: widget.pickerTheme.diameterRatio,
                  itemExtent: widget.pickerTheme.itemHeight,
                  onSelectedItemChanged: valueChanged,
                  looping: widget.looping,
                  children: List<Widget>.generate(
                    valueRange.last - valueRange.first + 1,
                    (index) {
                      return _renderDatePickerItemComponent(
                        valueRange.first + index,
                        format,
                        fontSize,
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              child: DatePickerDivider(
                dividerPaddings: bottomInsets,
                theme: widget.pickerTheme.dividerTheme
              )
            ),
            Positioned(
              child: DatePickerDivider(
                dividerPaddings: topInsets,
                theme: widget.pickerTheme.dividerTheme
              )
            ),
          ],
        ),
      );
  }

  Widget _renderDatePickerItemComponent(
    int value, 
    String format, 
    double? fontSize
  ) {
    var weekday = DateTime(_currentYear!, _currentMonth!, value).weekday;

    return Container(
      height: widget.pickerTheme.itemHeight,
      alignment: Alignment.center,
      child: AutoSizeText(
        DateTimeFormatter.formatDateTime(
          value, 
          format, 
          widget.locale, 
          weekday
        ),        
        style: widget.pickerTheme.itemTextStyle
      )
    );
  }

  Widget _renderSeparatorRow(Widget separator) {
    return Container(
      height: widget.pickerTheme.pickerHeight,
      color: widget.pickerTheme.backgroundColor,
      child: Center(      
        child: separator
      ),
    );
  }

  void _onSelectedChange() {
    if (widget.onChange != null) {
      DateTime dateTime = DateTime(_currentYear!, _currentMonth!, _currentDay!);
      widget.onChange!(dateTime, _calculateSelectIndexList());
    }
  }

  FixedExtentScrollController? _findScrollCtrl(String format) {
    FixedExtentScrollController? scrollCtrl;
    _scrollCtrlMap.forEach((key, value) {
      if (format.contains(key)) {
        scrollCtrl = value;
      }
    });
    return scrollCtrl;
  }
  
  List<int>? _findPickerItemRange(String format) {
    List<int>? valueRange;
    _valueRangeMap.forEach((key, value) {
      if (format.contains(key)) {
        valueRange = value;
      }
    });
    return valueRange;
  }

  void _onValueChange(int value, String format) {
    if (format.contains('y')) {
      _lock = true;
      _changeYearSelection(value);
      _lock = false;
    } else if (format.contains('M')) {
      if (_lock) {
        _lock = false;
        return;
      }
      _changeMonthSelection(value);
    } else if (format.contains('d')) {
      _changeDaySelection(value);
    }
  }

  double sizeByFormat(String format) {
    return (format.contains("-MMMM") || format.contains("MMMM-"))
      ? pickerSmallItemTextSize
      : pickerBigItemTextSize;
  }

  void _changeYearSelection(int index) {
    int year = _yearRange!.first + index;
    if (_currentYear != year) {
      _currentYear = year;
      _changeDateRange();
      _onSelectedChange();
    }
  }

  void _changeMonthSelection(int index) {
    _monthRange = RangeHelper.calculateMonthRange(
      _minDateTime, 
      _maxDateTime, 
      _currentYear
    );

    int month = _monthRange!.first + index;
    if (_currentMonth != month) {
      _currentMonth = month;

      _changeDateRange();
      _onSelectedChange();
    }
  }

  void _changeDaySelection(int index) {
    if (_isChangeDateRange) return;

    int dayOfMonth = _dayRange!.first + index;
    if (_currentDay != dayOfMonth) {
      _currentDay = dayOfMonth;
      _onSelectedChange();
    }
  }

  int? _getCurrentMonth() {
    int currMonth = _currentMonth!;
    List<int> monthRange = RangeHelper.calculateMonthRange(
      _minDateTime,
      _maxDateTime,
      _currentYear
    );

    currMonth = currMonth < monthRange.last
      ? max(currMonth, monthRange.first)
      : max(monthRange.last, monthRange.first);

    return currMonth;
  }
  
  void _changeDateRange() {
    if (_isChangeDateRange) return;
    _isChangeDateRange = true;

    List<int> monthRange = RangeHelper.calculateMonthRange(
      _minDateTime, 
      _maxDateTime, 
      _currentYear
    );

    bool monthRangeChanged = _monthRange!.first != monthRange.first ||
        _monthRange!.last != monthRange.last;

    if (monthRangeChanged) {      
      _currentMonth = _getCurrentMonth();
    }

    List<int> dayRange = RangeHelper.calculateDayRange(
      minDateTime: _minDateTime,
      maxDateTime: _maxDateTime,
      currentMonth: _currentMonth,
      currentYear: _currentYear
    );

    bool dayRangeChanged =
      _dayRange!.first != dayRange.first || 
      _dayRange!.last != dayRange.last;

    if (dayRangeChanged) {      
      _currentDay = max(min(_currentDay!, dayRange.last), dayRange.first);
    }

    setState(() {
      _monthRange = monthRange;
      _dayRange = dayRange;

      _valueRangeMap['M'] = monthRange;
      _valueRangeMap['d'] = dayRange;
    });

    if (monthRangeChanged) {
      // CupertinoPicker refresh data not working (https://github.com/flutter/flutter/issues/22999)
      int currMonth = _currentMonth!;
      _monthScrollCtrl!.jumpToItem(monthRange.last - monthRange.first);
      if (currMonth < monthRange.last) {
        _monthScrollCtrl!.jumpToItem(currMonth - monthRange.first);
      }
    }

    if (dayRangeChanged) {
      // CupertinoPicker refresh data not working (https://github.com/flutter/flutter/issues/22999)
      int currDay = _currentDay!;
      if (currDay < dayRange.last) {
        _dayScrollCtrl!.jumpToItem(currDay - dayRange.first);
      } else {
        _dayScrollCtrl!.jumpToItem(dayRange.last - dayRange.first);
      }
    }
    _isChangeDateRange = false;
  }

  List<int> _calculateSelectIndexList() {
    int yearIndex = _currentYear! - _minDateTime.year;
    int monthIndex = _currentMonth! - _monthRange!.first;
    int dayIndex = _currentDay! - _dayRange!.first;
    return [yearIndex, monthIndex, dayIndex];
  }
}
