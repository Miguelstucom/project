import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'dart:ui' as ui;

import 'package:project/settings/NumberFormatSymbolsExt.dart';

final defaultLocale = ui.window.locale.languageCode;
final defaultLanguage = ui.window.locale.countryCode;

String get defaultDeviceLanguage {
  String defLocale = defaultLocale;
  if (defaultLanguage != null) {
    defLocale += "-$defaultLanguage";
  }
  return defLocale;
}

Map<String, String> get internationalizationSettings {
  switch (defaultLocale) {
    case "es_ES":
      numberFormatSymbols['es_ES'] =
          (numberFormatSymbols['es_ES'] as NumberSymbols)
              .copyWith(currencySymbol: '€');
      return internEs;

    case "en_US":
      numberFormatSymbols[defaultLocale] =
          (numberFormatSymbols[defaultLocale] as NumberSymbols)
              .copyWith(currencySymbol: r'$');
      return internUSA;

    case "ja_JP":
      numberFormatSymbols["ja_JP"] =
          (numberFormatSymbols["ja_JP"] as NumberSymbols)
              .copyWith(currencySymbol: '¥');
      return internJap;
    default:
      return internEs;
  }
}

Map<String, String> get internEs => {'locale': 'es_ES', 'currency_symbol': '€'};

Map<String, String> get internUSA =>
    {'locale': 'en_US', 'currency_symbol': '\$'};

Map<String, String> get internJap =>
    {'locale': "ja_JP", 'currency_symbol': '\¥'};