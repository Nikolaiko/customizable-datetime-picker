import 'package:customizable_datetime_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime _dateTime = DateTime.now(); 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Date time picker example'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Simple picker with default settings",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              CustomizableDatePickerWidget(),
              const Divider(height: 3),
              const Text(
                "Picker with theme",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              CustomizableDatePickerWidget(
                initialDate: _dateTime,
                dateFormat: "dd-MMMM-yyyy",                            
                pickerTheme: const DateTimePickerTheme(                
                  itemTextStyle: TextStyle(    
                    color: Color(0xFF101010),
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                  backgroundColor: Colors.lightBlueAccent,
                  itemHeight: 80,
                  pickerHeight: 300,
                  dividerTheme: DatePickerDividerTheme(
                    dividerColor: Color(0xFF0073A5),
                    thickness: 3,
                    height: 2
                  )
                ),
                onChange: (dateTime, selectedIndex) => _dateTime = dateTime             
              )
            ]
          )
        )
      )
    );
  }
}
