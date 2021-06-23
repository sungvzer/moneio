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

  /// `Select action`
  String get homeSelectActionTitle {
    return Intl.message(
      'Select action',
      name: 'homeSelectActionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get actionEdit {
    return Intl.message(
      'Edit',
      name: 'actionEdit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get actionDelete {
    return Intl.message(
      'Delete',
      name: 'actionDelete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get actionCancel {
    return Intl.message(
      'Cancel',
      name: 'actionCancel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this transaction?`
  String get actionDeletePrompt {
    return Intl.message(
      'Are you sure you want to delete this transaction?',
      name: 'actionDeletePrompt',
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

  /// `Tag`
  String get transactionTag {
    return Intl.message(
      'Tag',
      name: 'transactionTag',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get transactionAmount {
    return Intl.message(
      'Amount',
      name: 'transactionAmount',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get transactionCurrency {
    return Intl.message(
      'Currency',
      name: 'transactionCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get transactionDate {
    return Intl.message(
      'Date',
      name: 'transactionDate',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get transactionTime {
    return Intl.message(
      'Time',
      name: 'transactionTime',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get transactionCategory {
    return Intl.message(
      'Category',
      name: 'transactionCategory',
      desc: '',
      args: [],
    );
  }

  /// `Select a category`
  String get transactionCategoryPrompt {
    return Intl.message(
      'Select a category',
      name: 'transactionCategoryPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Clothing`
  String get transactionCategoryClothing {
    return Intl.message(
      'Clothing',
      name: 'transactionCategoryClothing',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get transactionCategoryFood {
    return Intl.message(
      'Food',
      name: 'transactionCategoryFood',
      desc: '',
      args: [],
    );
  }

  /// `Animals`
  String get transactionCategoryAnimal {
    return Intl.message(
      'Animals',
      name: 'transactionCategoryAnimal',
      desc: '',
      args: [],
    );
  }

  /// `Insurance`
  String get transactionCategoryInsurance {
    return Intl.message(
      'Insurance',
      name: 'transactionCategoryInsurance',
      desc: '',
      args: [],
    );
  }

  /// `Bills`
  String get transactionCategoryBills {
    return Intl.message(
      'Bills',
      name: 'transactionCategoryBills',
      desc: '',
      args: [],
    );
  }

  /// `Home expenses`
  String get transactionCategoryHome {
    return Intl.message(
      'Home expenses',
      name: 'transactionCategoryHome',
      desc: '',
      args: [],
    );
  }

  /// `Body care`
  String get transactionCategoryBodyCare {
    return Intl.message(
      'Body care',
      name: 'transactionCategoryBodyCare',
      desc: '',
      args: [],
    );
  }

  /// `Electronics and software`
  String get transactionCategoryElectronic {
    return Intl.message(
      'Electronics and software',
      name: 'transactionCategoryElectronic',
      desc: '',
      args: [],
    );
  }

  /// `Family`
  String get transactionCategoryFamily {
    return Intl.message(
      'Family',
      name: 'transactionCategoryFamily',
      desc: '',
      args: [],
    );
  }

  /// `Financing and loans`
  String get transactionCategoryFinancing {
    return Intl.message(
      'Financing and loans',
      name: 'transactionCategoryFinancing',
      desc: '',
      args: [],
    );
  }

  /// `Entertainment`
  String get transactionCategoryEntertainment {
    return Intl.message(
      'Entertainment',
      name: 'transactionCategoryEntertainment',
      desc: '',
      args: [],
    );
  }

  /// `Investments`
  String get transactionCategoryInvestment {
    return Intl.message(
      'Investments',
      name: 'transactionCategoryInvestment',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get transactionCategoryEducation {
    return Intl.message(
      'Education',
      name: 'transactionCategoryEducation',
      desc: '',
      args: [],
    );
  }

  /// `Work and salary`
  String get transactionCategoryWorkSalary {
    return Intl.message(
      'Work and salary',
      name: 'transactionCategoryWorkSalary',
      desc: '',
      args: [],
    );
  }

  /// `Gifts and donations`
  String get transactionCategoryGift {
    return Intl.message(
      'Gifts and donations',
      name: 'transactionCategoryGift',
      desc: '',
      args: [],
    );
  }

  /// `Generic`
  String get transactionCategoryGeneric {
    return Intl.message(
      'Generic',
      name: 'transactionCategoryGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Refunds`
  String get transactionCategoryRefund {
    return Intl.message(
      'Refunds',
      name: 'transactionCategoryRefund',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants and coffee shops`
  String get transactionCategoryRestaurants {
    return Intl.message(
      'Restaurants and coffee shops',
      name: 'transactionCategoryRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get transactionCategoryHealth {
    return Intl.message(
      'Health',
      name: 'transactionCategoryHealth',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get transactionCategorySport {
    return Intl.message(
      'Sports',
      name: 'transactionCategorySport',
      desc: '',
      args: [],
    );
  }

  /// `Hobbies`
  String get transactionCategoryHobby {
    return Intl.message(
      'Hobbies',
      name: 'transactionCategoryHobby',
      desc: '',
      args: [],
    );
  }

  /// `Taxes and commissions`
  String get transactionCategoryTax {
    return Intl.message(
      'Taxes and commissions',
      name: 'transactionCategoryTax',
      desc: '',
      args: [],
    );
  }

  /// `Transportation`
  String get transactionCategoryTransport {
    return Intl.message(
      'Transportation',
      name: 'transactionCategoryTransport',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get transactionCategorySale {
    return Intl.message(
      'Sales',
      name: 'transactionCategorySale',
      desc: '',
      args: [],
    );
  }

  /// `Top-ups`
  String get transactionCategoryTopup {
    return Intl.message(
      'Top-ups',
      name: 'transactionCategoryTopup',
      desc: '',
      args: [],
    );
  }

  /// `ATM`
  String get transactionCategoryATM {
    return Intl.message(
      'ATM',
      name: 'transactionCategoryATM',
      desc: '',
      args: [],
    );
  }

  /// `Cryptocurrencies`
  String get transactionCategoryCrypto {
    return Intl.message(
      'Cryptocurrencies',
      name: 'transactionCategoryCrypto',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get transactionCategoryShopping {
    return Intl.message(
      'Shopping',
      name: 'transactionCategoryShopping',
      desc: '',
      args: [],
    );
  }

  /// `No category`
  String get transactionCategoryNone {
    return Intl.message(
      'No category',
      name: 'transactionCategoryNone',
      desc: '',
      args: [],
    );
  }

  /// `Untitled`
  String get transactionUntitled {
    return Intl.message(
      'Untitled',
      name: 'transactionUntitled',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statisticsTitle {
    return Intl.message(
      'Statistics',
      name: 'statisticsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get statisticsCategories {
    return Intl.message(
      'Categories',
      name: 'statisticsCategories',
      desc: '',
      args: [],
    );
  }

  /// `Currencies`
  String get statisticsCurrencies {
    return Intl.message(
      'Currencies',
      name: 'statisticsCurrencies',
      desc: '',
      args: [],
    );
  }

  /// `Count by`
  String get statisticsCountBy {
    return Intl.message(
      'Count by',
      name: 'statisticsCountBy',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get statisticsCountByNumber {
    return Intl.message(
      'Number',
      name: 'statisticsCountByNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please insert an amount`
  String get insertAmountPrompt {
    return Intl.message(
      'Please insert an amount',
      name: 'insertAmountPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Please select a currency`
  String get insertCurrencyPrompt {
    return Intl.message(
      'Please select a currency',
      name: 'insertCurrencyPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a date`
  String get insertDatePrompt {
    return Intl.message(
      'Please enter a date',
      name: 'insertDatePrompt',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a time`
  String get insertTimePrompt {
    return Intl.message(
      'Please enter a time',
      name: 'insertTimePrompt',
      desc: '',
      args: [],
    );
  }

  /// `Please select a category`
  String get insertCategoryPrompt {
    return Intl.message(
      'Please select a category',
      name: 'insertCategoryPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get addTransactionConfirm {
    return Intl.message(
      'Add',
      name: 'addTransactionConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get addTransactionCancel {
    return Intl.message(
      'Cancel',
      name: 'addTransactionCancel',
      desc: '',
      args: [],
    );
  }

  /// `General info`
  String get transactionViewInfoTitle {
    return Intl.message(
      'General info',
      name: 'transactionViewInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Emoji`
  String get categoryEmoji {
    return Intl.message(
      'Emoji',
      name: 'categoryEmoji',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get categoryName {
    return Intl.message(
      'Name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Unsaved changes`
  String get transactionViewUnsavedChangesPrompt {
    return Intl.message(
      'Unsaved changes',
      name: 'transactionViewUnsavedChangesPrompt',
      desc: '',
      args: [],
    );
  }

  /// `There are some unsaved changes.\nSave them now?`
  String get transactionViewUnsavedChangesText {
    return Intl.message(
      'There are some unsaved changes.\nSave them now?',
      name: 'transactionViewUnsavedChangesText',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get transactionViewUnsavedChangesApply {
    return Intl.message(
      'Apply',
      name: 'transactionViewUnsavedChangesApply',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get transactionViewUnsavedChangesDiscard {
    return Intl.message(
      'Discard',
      name: 'transactionViewUnsavedChangesDiscard',
      desc: '',
      args: [],
    );
  }

  /// `E-mail address`
  String get loginEmailAddress {
    return Intl.message(
      'E-mail address',
      name: 'loginEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPassword {
    return Intl.message(
      'Password',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `An e-mail is required to login`
  String get loginEmailRequired {
    return Intl.message(
      'An e-mail is required to login',
      name: 'loginEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `A password is required to login`
  String get loginPasswordRequired {
    return Intl.message(
      'A password is required to login',
      name: 'loginPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get loginPasswordReset {
    return Intl.message(
      'Forgot your password?',
      name: 'loginPasswordReset',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginContinue {
    return Intl.message(
      'Login',
      name: 'loginContinue',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for further instructions`
  String get loginCheckEmailForPasswordReset {
    return Intl.message(
      'Check your email for further instructions',
      name: 'loginCheckEmailForPasswordReset',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get loginSignUp {
    return Intl.message(
      'Sign up',
      name: 'loginSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Account information (optional)`
  String get signUpInformationLabel {
    return Intl.message(
      'Account information (optional)',
      name: 'signUpInformationLabel',
      desc: '',
      args: [],
    );
  }

  /// `E-mail and password`
  String get signUpCredentialsLabel {
    return Intl.message(
      'E-mail and password',
      name: 'signUpCredentialsLabel',
      desc: '',
      args: [],
    );
  }

  /// `A password is required to sign up`
  String get signUpPasswordRequired {
    return Intl.message(
      'A password is required to sign up',
      name: 'signUpPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must be at least {characters} characters long`
  String signUpPasswordLengthError(Object characters) {
    return Intl.message(
      'Passwords must be at least $characters characters long',
      name: 'signUpPasswordLengthError',
      desc: '',
      args: [characters],
    );
  }

  /// `Passwords must contain at least an uppercase letter`
  String get signUpPasswordCaseError {
    return Intl.message(
      'Passwords must contain at least an uppercase letter',
      name: 'signUpPasswordCaseError',
      desc: '',
      args: [],
    );
  }

  /// `An e-mail is required to sign up`
  String get signUpEmailRequired {
    return Intl.message(
      'An e-mail is required to sign up',
      name: 'signUpEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get userPersonalName {
    return Intl.message(
      'Name',
      name: 'userPersonalName',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get userPersonalSurname {
    return Intl.message(
      'Surname',
      name: 'userPersonalSurname',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get userPersonalBirthday {
    return Intl.message(
      'Birthday',
      name: 'userPersonalBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get errorReload {
    return Intl.message(
      'Reload',
      name: 'errorReload',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong starting {appName}, try restarting the application`
  String errorUnknown(Object appName) {
    return Intl.message(
      'Something went wrong starting $appName, try restarting the application',
      name: 'errorUnknown',
      desc: '',
      args: [appName],
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
