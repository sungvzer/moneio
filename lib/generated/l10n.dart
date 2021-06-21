// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Localization {
  Localization();

  static Localization? _current;

  static Localization get current {
    assert(_current != null,
        'No instance of Localization was loaded. Try to initialize the Localization delegate before accessing Localization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localization();
      Localization._current = instance;

      return instance;
    });
  }

  static Localization of(BuildContext context) {
    final instance = Localization.maybeOf(context);
    assert(instance != null,
        'No instance of Localization present in the widget tree. Did you add Localization.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localization? maybeOf(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  /// `mone.io`
  String get appName {
    return Intl.message(
      'mone.io',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get homeTotal {
    return Intl.message(
      'Total',
      name: 'homeTotal',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get homeToday {
    return Intl.message(
      'Today',
      name: 'homeToday',
      desc: '',
      args: [],
    );
  }

  /// `This week`
  String get homeThisWeek {
    return Intl.message(
      'This week',
      name: 'homeThisWeek',
      desc: '',
      args: [],
    );
  }

  /// `This month`
  String get homeThisMonth {
    return Intl.message(
      'This month',
      name: 'homeThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get homeHistory {
    return Intl.message(
      'History',
      name: 'homeHistory',
      desc: '',
      args: [],
    );
  }

  /// `No transactions to see here!`
  String get homeNoTransactionMessageTitle {
    return Intl.message(
      'No transactions to see here!',
      name: 'homeNoTransactionMessageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hint: try adding some by tapping the plus button at the bottom!`
  String get homeNoTransactionMessageHint {
    return Intl.message(
      'Hint: try adding some by tapping the plus button at the bottom!',
      name: 'homeNoTransactionMessageHint',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get homeSortByTooltip {
    return Intl.message(
      'Sort by',
      name: 'homeSortByTooltip',
      desc: '',
      args: [],
    );
  }

  /// `By tag`
  String get homeSortByTag {
    return Intl.message(
      'By tag',
      name: 'homeSortByTag',
      desc: '',
      args: [],
    );
  }

  /// `By date`
  String get homeSortByDate {
    return Intl.message(
      'By date',
      name: 'homeSortByDate',
      desc: '',
      args: [],
    );
  }

  /// `By name`
  String get homeSortByAmount {
    return Intl.message(
      'By name',
      name: 'homeSortByAmount',
      desc: '',
      args: [],
    );
  }

  /// `By category`
  String get homeSortByCategory {
    return Intl.message(
      'By category',
      name: 'homeSortByCategory',
      desc: '',
      args: [],
    );
  }

  /// `Refresh transactions`
  String get homeRefresh {
    return Intl.message(
      'Refresh transactions',
      name: 'homeRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Ascending sort order`
  String get homeAscendingSort {
    return Intl.message(
      'Ascending sort order',
      name: 'homeAscendingSort',
      desc: '',
      args: [],
    );
  }

  /// `Desceding sort order`
  String get homeDescendingSort {
    return Intl.message(
      'Desceding sort order',
      name: 'homeDescendingSort',
      desc: '',
      args: [],
    );
  }

  /// `Add a transaction`
  String get homeAddATransactionTooltip {
    return Intl.message(
      'Add a transaction',
      name: 'homeAddATransactionTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get homeDrawerStats {
    return Intl.message(
      'Stats',
      name: 'homeDrawerStats',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get homeDrawerSettings {
    return Intl.message(
      'Settings',
      name: 'homeDrawerSettings',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get homeDrawerSignOut {
    return Intl.message(
      'Sign out',
      name: 'homeDrawerSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out?`
  String get homeSignOutPopupPrompt {
    return Intl.message(
      'Are you sure you want to sign out?',
      name: 'homeSignOutPopupPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get homeSignOutPopupDismiss {
    return Intl.message(
      'Cancel',
      name: 'homeSignOutPopupDismiss',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get homeSignOutPopupConfirm {
    return Intl.message(
      'OK',
      name: 'homeSignOutPopupConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Human readable`
  String get settingsHumanReadableTitle {
    return Intl.message(
      'Human readable',
      name: 'settingsHumanReadableTitle',
      desc: '',
      args: [],
    );
  }

  /// `Use a readable format for amounts greater than 10'000`
  String get settingsHumanReadableDescription {
    return Intl.message(
      'Use a readable format for amounts greater than 10\'000',
      name: 'settingsHumanReadableDescription',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get settingsDarkThemeTitle {
    return Intl.message(
      'Dark theme',
      name: 'settingsDarkThemeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Embrace the night`
  String get settingsDarkThemeDescription {
    return Intl.message(
      'Embrace the night',
      name: 'settingsDarkThemeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Favorite currency`
  String get settingsFavoriteCurrencyTitle {
    return Intl.message(
      'Favorite currency',
      name: 'settingsFavoriteCurrencyTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will be the default currency when you add a transaction`
  String get settingsFavoriteCurrencyDescription {
    return Intl.message(
      'This will be the default currency when you add a transaction',
      name: 'settingsFavoriteCurrencyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Sync settings to cloud`
  String get settingsSyncToCloudTitle {
    return Intl.message(
      'Sync settings to cloud',
      name: 'settingsSyncToCloudTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'it'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localization> load(Locale locale) => Localization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
