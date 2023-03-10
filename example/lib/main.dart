import 'package:customizable_datetime_picker/date_picker_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const TextStyle pickerTextStyle = TextStyle(    
  color: Color(0xFF101010),
  fontSize: 20,
  fontWeight: FontWeight.w600
);

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
              const Divider(thickness: 8),
              const SizedBox(height: 20),
              const Text(
                "Simple date picker",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              CustomizableDatePickerWidget(),
              const Divider(thickness: 8),
              const SizedBox(height: 20),
              const Text(
                "Date Picker with theme",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              CustomizableDatePickerWidget(
                separatorWidget: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    ":",
                    style: pickerTextStyle,
                  ),
                ),
                locale: DateTimePickerLocale.jp,
                looping: true,
                initialDate: _dateTime,
                dateFormat: "dd-MMMM-yyyy",                            
                pickerTheme: const DateTimePickerTheme(                
                  itemTextStyle: pickerTextStyle,
                  backgroundColor: Color(0xFFEBEBEB),
                  itemHeight: 80,
                  pickerHeight: 300,
                  dividerTheme: DatePickerDividerTheme(
                    dividerColor: Color(0xFF00A962),
                    thickness: 3,
                    height: 2
                  )
                ),
                onChange: (dateTime, selectedIndex) => _dateTime = dateTime             
              ),
              const Divider(thickness: 8),
              const SizedBox(height: 20),
              const Text(
                "Time Picker with theme",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              CustomizableTimePickerWidget(
                separatorWidget: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    ":",
                    style: pickerTextStyle,
                  ),
                ),
                locale: DateTimePickerLocale.jp,                       
                timeFormat: "HH:mm",                            
                pickerTheme: const DateTimePickerTheme(                
                  itemTextStyle: pickerTextStyle,                  
                  itemHeight: 80,
                  pickerHeight: 300,
                  dividerTheme: DatePickerDividerTheme(
                    dividerColor: Color(0xFF00A962),
                    thickness: 3,
                    height: 2
                  )
                ),
                onChange: (dateTime, selectedIndex) => _dateTime = dateTime             
              ),
            ]
          )
        )
      )
    );
  }
}
