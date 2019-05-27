import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

class Translations {
  Translations(Locale locale) {
    print("constructor"+locale.toString());
    print(DateTime.now().toIso8601String());
    print(DateTime.now().toUtc());
    print(DateTime.now().timeZoneName);
    print(DateTime.now().timeZoneOffset);
    print(DateTime.now().toLocal());
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  
  static Translations of(BuildContext context){
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle.loadString("locale/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

typedef void LocaleChangeCallback(Locale locale);
class APPLIC {
    // List of supported languages
    final List<String> supportedLanguages = ['en','zh'];

    // Returns the list of supported Locales
    Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

    // Function to be invoked when changing the working language
    LocaleChangeCallback onLocaleChanged;

    ///
    /// Internals
    ///
    static final APPLIC _applic = new APPLIC._internal();

    factory APPLIC(){
        return _applic;
    }

    APPLIC._internal();
}

APPLIC applic = new APPLIC();
//Translations aaaa = new Translations(new Locale("zh", ""));


class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => applic.supportedLanguages.contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) { /* print(locale);  */return Translations.load(locale);}

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}