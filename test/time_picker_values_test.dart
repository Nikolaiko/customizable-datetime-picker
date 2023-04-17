import 'package:customizable_datetime_picker/date_picker_widget.dart';
import 'package:customizable_datetime_picker/sources/consts/semantic_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  const double testPickerHeight = 500;
  const MediaQueryData testMediaQuery = MediaQueryData(size: Size(1200, 4000));
  DateTime testTime = DateTime.now();  

  testWidgets('Time picker hours default value working', (tester) async {
    DateTime? updatingValue;

    await tester.pumpWidget(
      MediaQuery(
        data: testMediaQuery,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: CustomizableTimePickerWidget(
            initialTime: testTime,
            pickerTheme: const DateTimePickerTheme(
              pickerHeight: testPickerHeight
            ),
            onChange: (dateTime, selectedIndex) {              
              updatingValue = dateTime;
            }
          ),
        ),
      )
    );

    Finder secondRowFinder = find.bySemanticsLabel(SemanticLabels.rowLabels[1]);
    await tester.drag(secondRowFinder, const Offset(0.0, -300));
    await tester.pumpAndSettle();

    Finder thirdRowFinder = find.bySemanticsLabel(SemanticLabels.rowLabels[2]);
    await tester.drag(thirdRowFinder, const Offset(0.0, -300));
    await tester.pumpAndSettle();

    expect(updatingValue, isNotNull);
    expect(updatingValue!.hour, testTime.hour);
  });

  testWidgets('Time picker minutes default value working', (tester) async {
    DateTime? updatingValue;

    await tester.pumpWidget(
      MediaQuery(
        data: testMediaQuery,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: CustomizableTimePickerWidget(
            initialTime: testTime,
            pickerTheme: const DateTimePickerTheme(
              pickerHeight: testPickerHeight
            ),
            onChange: (dateTime, selectedIndex) {              
              updatingValue = dateTime;
            }
          ),
        ),
      )
    );

    Finder firstRowFinder = find.bySemanticsLabel(SemanticLabels.rowLabels[0]);
    await tester.drag(firstRowFinder, const Offset(0.0, -300));
    await tester.pumpAndSettle();

    Finder thirdRowFinder = find.bySemanticsLabel(SemanticLabels.rowLabels[2]);
    await tester.drag(thirdRowFinder, const Offset(0.0, -300));
    await tester.pumpAndSettle();

    expect(updatingValue, isNotNull);
    expect(updatingValue!.minute, testTime.minute);
  });

  testWidgets('Time picker seconds default value working', (tester) async {
    DateTime? updatingValue;

    await tester.pumpWidget(
      MediaQuery(
        data: testMediaQuery,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: CustomizableTimePickerWidget(
            initialTime: testTime,
            pickerTheme: const DateTimePickerTheme(
              pickerHeight: testPickerHeight
            ),
            onChange: (dateTime, selectedIndex) {              
              updatingValue = dateTime;
            }
          ),
        ),
      )
    );

    Finder secondRowFinder = find.bySemanticsLabel(SemanticLabels.rowLabels[1]);
    await tester.drag(secondRowFinder, const Offset(0.0, -300));
    await tester.pumpAndSettle();

    Finder firstRowFinder = find.bySemanticsLabel(SemanticLabels.rowLabels[0]);
    await tester.drag(firstRowFinder, const Offset(0.0, -300));
    await tester.pumpAndSettle();

    expect(updatingValue, isNotNull);
    expect(updatingValue!.second, testTime.second);
  });
}