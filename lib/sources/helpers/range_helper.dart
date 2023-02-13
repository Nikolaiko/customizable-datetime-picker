class RangeHelper {
  static const List<int> _solarMonthsOf31Days = <int>[1, 3, 5, 7, 8, 10, 12];

  static List<int> calculateYearRange(
    DateTime minDateTime,
    DateTime maxDateTime
  ) {
    return [minDateTime.year, maxDateTime.year];
  }

  static List<int> calculateMonthRange(
    DateTime minDateTime,
    DateTime maxDateTime,
    int? currentYear
  ) {
    int minMonth = 1, maxMonth = 12;
    int minYear = minDateTime.year;
    int maxYear = maxDateTime.year;

    if (minYear == currentYear) {      
      minMonth = minDateTime.month;
    }
    if (maxYear == currentYear) {      
      maxMonth = maxDateTime.month;
    }
    return [minMonth, maxMonth];
  }

  static List<int> calculateDayRange(
    {
      required DateTime minDateTime,
      required DateTime maxDateTime,
      required int? currentYear,
      required int? currentMonth,      
    }
  ) {
    int minDay = 1, maxDay = _calculateDayCountOfMonth(currentMonth, currentYear);
    int minYear = minDateTime.year;
    int maxYear = maxDateTime.year;
    int minMonth = minDateTime.month;
    int maxMonth = maxDateTime.month;

    if (minYear == currentYear && minMonth == currentMonth) {      
      minDay = minDateTime.day;
    }
    if (maxYear == currentYear && maxMonth == currentMonth) {    
      maxDay = maxDateTime.day;
    }
    return [minDay, maxDay];
  }
  
  static int _calculateDayCountOfMonth(
    int? currentMonth,
    int? currentYear
  ) {
    if (currentMonth == 2) {
      return _isLeapYear(currentYear!) ? 29 : 28;
    } else if (_solarMonthsOf31Days.contains(currentMonth)) {
      return 31;
    }
    return 30;
  }

  static bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }
}