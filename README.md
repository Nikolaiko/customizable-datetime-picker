# customizable_datetime_picker

Customizable Datetime Picker for Flutter projects. You can customize different parts of the picker like format locale divider color and many others.

<p>
  <img src="https://media.giphy.com/media/8GPikjiC1SVQiWk2Tq/giphy.gif"?raw=true"
    alt="An animated image of the datepicker" height="400"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://media.giphy.com/media/iATbwkKNK982AAWlac/giphy.gif?raw=true"
   alt="An animated image of the datepicker" height="400"/>
</p>

## Features

Use this plugin in your Flutter app to:

* Display Cupertino style DatePicker with customizable parts.
* You need to change even small parts of the pciker, like color and thickness of the dividers. Picker item height and background color.
* You need to select Locale and date format. 

## Usage

You can use this widget with deafult parameters just like this:
```dart
CustomizableDatePickerWidget()
```
Or you can use *DateTimePickerTheme* and *DatePickerDividerTheme* to define design of the picker. And provide needed parameters to customize logic of the picker (datetime format, range of dates and so on):
```dart
CustomizableDatePickerWidget(
  locale: DateTimePickerLocale.jp,
  looping: true,
  initialDate: _dateTime,
  dateFormat: "dd-MMMM-yyyy",                            
  pickerTheme: const DateTimePickerTheme(                
    itemTextStyle: TextStyle(    
      color: Color(0xFF101010),
      fontSize: 20,
      fontWeight: FontWeight.w600
    ),
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
)
```                                                         
More details in [example](https://github.com/Nikolaiko/DrawOnImagePlugin/tree/main/example).
