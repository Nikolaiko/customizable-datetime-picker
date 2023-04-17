import 'package:auto_size_text/auto_size_text.dart';
import 'package:customizable_datetime_picker/date_picker_widget.dart';
import 'package:customizable_datetime_picker/sources/consts/semantic_labels.dart';
import 'package:customizable_datetime_picker/sources/model/date_picker_constants.dart';
import 'package:customizable_datetime_picker/sources/model/date_time_formatter.dart';
import 'package:customizable_datetime_picker/sources/widget/date_picker_divider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Customizable Time Picker
class CustomizableTimePickerWidget extends StatefulWidget {

  /// Initial time for the picker
  final DateTime? initialTime;

  /// Time format for the picker
  final String timeFormat;

  /// Localule used to render data
  final DateTimePickerLocale locale;

  /// Picker visual theme
  final DateTimePickerTheme pickerTheme;

  /// Function that will be called when value changes
  final DateValueCallback? onChange;

  /// Variable to set picker spiners looped or not
  final bool looping;

  /// Widget to placed between rows
  final Widget? separatorWidget;

  const CustomizableTimePickerWidget(
    {
      super.key,
      this.initialTime,
      this.timeFormat = defaultTimeFormat,
      this.locale = pickerLocaleDefault,
      this.pickerTheme = DateTimePickerTheme.defaultPickerTheme,    
      this.onChange,
      this.looping = false,
      this.separatorWidget
    }
  );

  @override
  State<CustomizableTimePickerWidget> createState() => _CustomizableTimePickerWidgetState();
}

class _CustomizableTimePickerWidgetState extends State<CustomizableTimePickerWidget> {
  late DateTime _startingDate;
  late FixedExtentScrollController _hoursScrollCtrl;
  late FixedExtentScrollController _minutesScrollCtrl;
  late FixedExtentScrollController _secondsScrollCtrl;

  late Map<String, FixedExtentScrollController?> _scrollCtrlMap;
  final Map<String, List<int>> _valueRangeMap = {
    'H': [0, 23], 
    'm': [0, 59], 
    's': [0, 59]
  };


  int _currentHour = 0, _currentMinute = 0, _currentSecond = 0;  

  @override
  void initState() {
    _startingDate = widget.initialTime ?? DateTime.now();
    _currentHour = _startingDate.hour;
    _currentMinute = _startingDate.minute;
    _currentSecond = _startingDate.second;  

    _hoursScrollCtrl = FixedExtentScrollController(
      initialItem: _startingDate.hour
    );

    _minutesScrollCtrl = FixedExtentScrollController(
      initialItem: _startingDate.minute
    );

    _secondsScrollCtrl = FixedExtentScrollController(
      initialItem: _startingDate.second
    );

    _scrollCtrlMap = {
      'H': _hoursScrollCtrl, 
      'm': _minutesScrollCtrl, 
      's': _secondsScrollCtrl
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: Colors.transparent, 
        child: _renderTimePickerWidget()
      ),
    );
  }

  Widget _renderTimePickerWidget() {
    List<Widget> pickers = [];
    List<String> formatArr =
      DateTimeFormatter.splitDateFormat(widget.timeFormat);
    
    int index = 0;
    for (String format in formatArr) {
      List<int> valueRange = _findPickerItemRange(format)!;

      Widget pickerColumn = _renderDatePickerColumnComponent(
        scrollCtrl: _findScrollCtrl(format),
        valueRange: valueRange,
        format: format,
        valueChanged: (value) => _onValueChange(value, format),
        semanticLabel: SemanticLabels.rowLabels[index],
        fontSize: widget.pickerTheme.itemTextStyle.fontSize
      );

      pickers.add(pickerColumn);

      if (widget.separatorWidget != null && formatArr.last != format) {
        pickers.add(_renderSeparatorRow(widget.separatorWidget!));
      }

      index += 1;
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
      required String semanticLabel,
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
                child: Semantics(
                  label: semanticLabel,
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
                          index,
                          format,
                          fontSize,
                        );
                      },
                    ),
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
    return Container(
      height: widget.pickerTheme.itemHeight,
      alignment: Alignment.center,
      child: AutoSizeText(
        DateTimeFormatter.formatDateTime(
          value, 
          format, 
          widget.locale, 
          _startingDate.weekday
        ),        
        style: widget.pickerTheme.itemTextStyle,
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

  void _onValueChange(int value, String format) {
    if (format.contains('H')) {
      _currentHour = value;      
    } else if (format.contains('m')) {
      _currentMinute = value;
    } else if (format.contains('s')) {
      _currentSecond = value;
    }
    _onSelectedChange();
  }

  void _onSelectedChange() {
    if (widget.onChange != null) {
      DateTime dateTime = DateTime(
        _startingDate.year,
        _startingDate.month,
        _startingDate.day,
        _currentHour,
        _currentMinute,
        _currentSecond
      );
      widget.onChange!(dateTime, _calculateSelectIndexList());
    }
  }

  List<int> _calculateSelectIndexList() {
    return [_currentHour, _currentMinute, _currentSecond];
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
  
}