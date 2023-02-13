import 'package:customizable_datetime_picker/sources/model/date_picker_divider_theme.dart';
import 'package:flutter/material.dart';

class DatePickerDivider extends StatelessWidget {
  final EdgeInsets dividerPaddings;
  final DatePickerDividerTheme theme;

  const DatePickerDivider(
    {
      super.key,
      required this.theme,
      this.dividerPaddings = EdgeInsets.zero
    }
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sidePaddings = screenSize.width * 0.02;
    return Container(
      margin: dividerPaddings,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[          
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sidePaddings),
              child: Divider(
                color: theme.dividerColor,
                height: theme.height,
                thickness: theme.thickness,
              ),
            ),
          ),          
        ],
      )
    );
  }
}