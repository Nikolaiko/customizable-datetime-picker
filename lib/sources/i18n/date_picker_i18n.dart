import 'dart:math';

part 'strings_ar.dart';

part 'strings_bn.dart';

part 'strings_de.dart';

part 'strings_en_us.dart';

part 'strings_es.dart';

part 'strings_he.dart';

part 'strings_hu.dart';

part 'strings_id.dart';

part 'strings_it.dart';

part 'strings_jp.dart';

part 'strings_ko.dart';

part 'strings_no_nb.dart';

part 'strings_no_nn.dart';

part 'strings_pt_br.dart';

part 'strings_ro.dart';

part 'strings_ru.dart';

part 'strings_tr.dart';

part 'strings_zh_cn.dart';

part 'strings_fr.dart';

part 'strings_th.dart';

part 'strings_lt.dart';

part 'strings_nl.dart';

part 'strings_ht.dart';

part 'strings_sv.dart';

part 'strings_cz.dart';

part 'strings_pl.dart';

abstract class StringsI18n {
  const StringsI18n();

  /// Get the done widget text
  String getDoneText();

  /// Get the cancel widget text
  String getCancelText();

  /// Get the name of month
  List<String> getMonths();

  /// Get the full name of week
  List<String> getWeeksFull();

  /// Get the short name of week
  List<String>? getWeeksShort();
}

enum DateTimePickerLocale {
  /// English (EN) United States
  enUs,

  /// Chinese (ZH) Simplified
  zhCn,

  /// Portuguese (PT) Brazil
  ptBr,

  /// Spanish (ES)
  es,

  /// Romanian (RO)
  ro,

  /// Bengali (BN)
  bn,

  /// Arabic (AR)
  ar,

  /// Japanese (JP)
  jp,

  /// Russian (RU)
  ru,

  /// German (DE)
  de,

  /// Korea (KO)
  ko,

  /// Italian (IT)
  it,

  /// Hungarian (HU)
  hu,

  /// Hebrew (HE)
  he,

  /// Indonesian (ID)
  id,

  /// Turkish (TR)
  tr,

  /// Norwegian Bokmål (NO)
  noNb,

  /// Norwegian Nynorsk (NO)
  noNn,

  /// French (FR)
  fr,

  /// Thai (TH)
  th,

  /// Lithuaniana (LT)
  lt,

  /// Dutch (NL)
  nl,

  /// Haitian Creole (HT)
  ht,

  /// Swedish (SV)
  sv,

  /// Czech (CZ)
  cz,

  /// Polish (PL)
  pl,
}

/// Default value of date locale
const DateTimePickerLocale pickerLocaleDefault =
    DateTimePickerLocale.enUs;

const Map<DateTimePickerLocale, StringsI18n> datePickerI18n = {
  DateTimePickerLocale.enUs: _StringsEnUs(),
  DateTimePickerLocale.zhCn: _StringsZhCn(),
  DateTimePickerLocale.ptBr: _StringsPtBr(),
  DateTimePickerLocale.es: _StringsEs(),
  DateTimePickerLocale.ro: _StringsRo(),
  DateTimePickerLocale.bn: _StringsBn(),
  DateTimePickerLocale.ar: _StringsAr(),
  DateTimePickerLocale.jp: _StringsJp(),
  DateTimePickerLocale.ru: _StringsRu(),
  DateTimePickerLocale.de: _StringsDe(),
  DateTimePickerLocale.ko: _StringsKo(),
  DateTimePickerLocale.it: _StringsIt(),
  DateTimePickerLocale.hu: _StringsHu(),
  DateTimePickerLocale.he: _StringsHe(),
  DateTimePickerLocale.id: _StringsId(),
  DateTimePickerLocale.tr: _StringsTr(),
  DateTimePickerLocale.noNb: _StringsNoNb(),
  DateTimePickerLocale.noNn: _StringsNoNn(),
  DateTimePickerLocale.nl: _StringsNl(),
  DateTimePickerLocale.fr: _StringsFr(),
  DateTimePickerLocale.th: _StringsTh(),
  DateTimePickerLocale.lt: _StringsLt(),
  DateTimePickerLocale.ht: _StringsHt(),
  DateTimePickerLocale.sv: _StringsSv(),
  DateTimePickerLocale.cz: _StringsCz(),
  DateTimePickerLocale.pl: _StringsPl(),
};

class DatePickerI18n {
  /// Get done button text
  static String getLocaleDone(DateTimePickerLocale locale) {
    StringsI18n i18n = datePickerI18n[locale] ??
        datePickerI18n[pickerLocaleDefault]!;
    return i18n.getDoneText();
  }

  /// Get cancel button text
  static String getLocaleCancel(DateTimePickerLocale locale) {
    StringsI18n i18n = datePickerI18n[locale] ??
        datePickerI18n[pickerLocaleDefault]!;
    return i18n.getCancelText();
  }

  /// Get locale month array
  static List<String> getLocaleMonths(DateTimePickerLocale? locale) {
    StringsI18n i18n = datePickerI18n[locale!] ??
        datePickerI18n[pickerLocaleDefault]!;
    List<String> months = i18n.getMonths();
    if (months.isNotEmpty) {
      return months;
    }
    return datePickerI18n[pickerLocaleDefault]!.getMonths();
  }

  /// Get locale week array
  static List<String>? getLocaleWeeks(DateTimePickerLocale? locale,
      [bool isFull = true]) {
    StringsI18n? i18n = datePickerI18n[locale!] ??
        datePickerI18n[pickerLocaleDefault];
    if (isFull) {
      List<String> weeks = i18n!.getWeeksFull();
      if (weeks.isNotEmpty) {
        return weeks;
      }
      return datePickerI18n[pickerLocaleDefault]!.getWeeksFull();
    }

    List<String>? weeks = i18n!.getWeeksShort();
    if (weeks != null && weeks.isNotEmpty) {
      return weeks;
    }

    List<String> fullWeeks = i18n.getWeeksFull();
    if (fullWeeks.isNotEmpty) {
      return fullWeeks
          .map((item) => item.substring(0, min(3, item.length)))
          .toList();
    }
    return datePickerI18n[pickerLocaleDefault]!.getWeeksShort();
  }
}
