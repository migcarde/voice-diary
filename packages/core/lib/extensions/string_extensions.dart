import 'dart:ui';

extension StringExtensions on String {
  Locale? getLocale(List<Locale> supportedLocales) {
    final localeIndex =
        supportedLocales.indexWhere((locale) => locale.toString() == this);

    if (localeIndex != -1) {
      return supportedLocales[localeIndex];
    }

    return null;
  }
}
