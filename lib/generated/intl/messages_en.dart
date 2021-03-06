// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(appName) =>
      "Something went wrong starting ${appName}, try restarting the application";

  static String m1(characters) =>
      "Passwords must be at least ${characters} characters long";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "actionDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "actionDeletePrompt": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete this transaction?"),
        "actionEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "addTransactionCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "addTransactionConfirm": MessageLookupByLibrary.simpleMessage("Add"),
        "appName": MessageLookupByLibrary.simpleMessage("mone.io"),
        "categoryEmoji": MessageLookupByLibrary.simpleMessage("Emoji"),
        "categoryName": MessageLookupByLibrary.simpleMessage("Name"),
        "errorReload": MessageLookupByLibrary.simpleMessage("Reload"),
        "errorUnknown": m0,
        "homeAddATransactionTooltip":
            MessageLookupByLibrary.simpleMessage("Add a transaction"),
        "homeAscendingSort":
            MessageLookupByLibrary.simpleMessage("Ascending sort order"),
        "homeDescendingSort":
            MessageLookupByLibrary.simpleMessage("Desceding sort order"),
        "homeDrawerSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "homeDrawerSignOut": MessageLookupByLibrary.simpleMessage("Sign out"),
        "homeDrawerStats": MessageLookupByLibrary.simpleMessage("Stats"),
        "homeHistory": MessageLookupByLibrary.simpleMessage("History"),
        "homeNoTransactionMessageHint": MessageLookupByLibrary.simpleMessage(
            "Hint: try adding some by tapping the plus button at the bottom!"),
        "homeNoTransactionMessageTitle": MessageLookupByLibrary.simpleMessage(
            "No transactions to see here!"),
        "homeRefresh":
            MessageLookupByLibrary.simpleMessage("Refresh transactions"),
        "homeSelectActionTitle":
            MessageLookupByLibrary.simpleMessage("Select action"),
        "homeSignOutPopupConfirm": MessageLookupByLibrary.simpleMessage("OK"),
        "homeSignOutPopupDismiss":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "homeSignOutPopupPrompt": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to sign out?"),
        "homeSortByAmount": MessageLookupByLibrary.simpleMessage("By name"),
        "homeSortByCategory":
            MessageLookupByLibrary.simpleMessage("By category"),
        "homeSortByDate": MessageLookupByLibrary.simpleMessage("By date"),
        "homeSortByTag": MessageLookupByLibrary.simpleMessage("By tag"),
        "homeSortByTooltip": MessageLookupByLibrary.simpleMessage("Sort by"),
        "homeThisMonth": MessageLookupByLibrary.simpleMessage("This month"),
        "homeThisWeek": MessageLookupByLibrary.simpleMessage("This week"),
        "homeToday": MessageLookupByLibrary.simpleMessage("Today"),
        "homeTotal": MessageLookupByLibrary.simpleMessage("Total"),
        "insertAmountPrompt":
            MessageLookupByLibrary.simpleMessage("Please insert an amount"),
        "insertCategoryPrompt":
            MessageLookupByLibrary.simpleMessage("Please select a category"),
        "insertCurrencyPrompt":
            MessageLookupByLibrary.simpleMessage("Please select a currency"),
        "insertDatePrompt":
            MessageLookupByLibrary.simpleMessage("Please enter a date"),
        "insertTimePrompt":
            MessageLookupByLibrary.simpleMessage("Please enter a time"),
        "loginCheckEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
            "Check your email for further instructions"),
        "loginContinue": MessageLookupByLibrary.simpleMessage("Login"),
        "loginEmailAddress":
            MessageLookupByLibrary.simpleMessage("E-mail address"),
        "loginEmailRequired": MessageLookupByLibrary.simpleMessage(
            "An e-mail is required to login"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginPasswordRequired": MessageLookupByLibrary.simpleMessage(
            "A password is required to login"),
        "loginPasswordReset":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "loginSignUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "settingsDarkThemeDescription":
            MessageLookupByLibrary.simpleMessage("Embrace the night"),
        "settingsDarkThemeTitle":
            MessageLookupByLibrary.simpleMessage("Dark theme"),
        "settingsFavoriteCurrencyDescription":
            MessageLookupByLibrary.simpleMessage(
                "This will be the default currency when you add a transaction"),
        "settingsFavoriteCurrencyTitle":
            MessageLookupByLibrary.simpleMessage("Favorite currency"),
        "settingsHumanReadableDescription":
            MessageLookupByLibrary.simpleMessage(
                "Use a readable format for amounts greater than 10\'000"),
        "settingsHumanReadableTitle":
            MessageLookupByLibrary.simpleMessage("Human readable"),
        "settingsSyncToCloudTitle":
            MessageLookupByLibrary.simpleMessage("Sync settings to cloud"),
        "signUpCredentialsLabel":
            MessageLookupByLibrary.simpleMessage("E-mail and password"),
        "signUpEmailRequired": MessageLookupByLibrary.simpleMessage(
            "An e-mail is required to sign up"),
        "signUpInformationLabel": MessageLookupByLibrary.simpleMessage(
            "Account information (optional)"),
        "signUpPasswordCaseError": MessageLookupByLibrary.simpleMessage(
            "Passwords must contain at least an uppercase letter"),
        "signUpPasswordLengthError": m1,
        "signUpPasswordRequired": MessageLookupByLibrary.simpleMessage(
            "A password is required to sign up"),
        "statisticsCategories":
            MessageLookupByLibrary.simpleMessage("Categories"),
        "statisticsCountBy": MessageLookupByLibrary.simpleMessage("Count by"),
        "statisticsCountByNumber":
            MessageLookupByLibrary.simpleMessage("Number"),
        "statisticsCurrencies":
            MessageLookupByLibrary.simpleMessage("Currencies"),
        "statisticsTitle": MessageLookupByLibrary.simpleMessage("Statistics"),
        "transactionAmount": MessageLookupByLibrary.simpleMessage("Amount"),
        "transactionCategory": MessageLookupByLibrary.simpleMessage("Category"),
        "transactionCategoryATM": MessageLookupByLibrary.simpleMessage("ATM"),
        "transactionCategoryAnimal":
            MessageLookupByLibrary.simpleMessage("Animals"),
        "transactionCategoryBills":
            MessageLookupByLibrary.simpleMessage("Bills"),
        "transactionCategoryBodyCare":
            MessageLookupByLibrary.simpleMessage("Body care"),
        "transactionCategoryClothing":
            MessageLookupByLibrary.simpleMessage("Clothing"),
        "transactionCategoryCrypto":
            MessageLookupByLibrary.simpleMessage("Cryptocurrencies"),
        "transactionCategoryEducation":
            MessageLookupByLibrary.simpleMessage("Education"),
        "transactionCategoryElectronic":
            MessageLookupByLibrary.simpleMessage("Electronics and software"),
        "transactionCategoryEntertainment":
            MessageLookupByLibrary.simpleMessage("Entertainment"),
        "transactionCategoryFamily":
            MessageLookupByLibrary.simpleMessage("Family"),
        "transactionCategoryFinancing":
            MessageLookupByLibrary.simpleMessage("Financing and loans"),
        "transactionCategoryFood": MessageLookupByLibrary.simpleMessage("Food"),
        "transactionCategoryGeneric":
            MessageLookupByLibrary.simpleMessage("Generic"),
        "transactionCategoryGift":
            MessageLookupByLibrary.simpleMessage("Gifts and donations"),
        "transactionCategoryHealth":
            MessageLookupByLibrary.simpleMessage("Health"),
        "transactionCategoryHobby":
            MessageLookupByLibrary.simpleMessage("Hobbies"),
        "transactionCategoryHome":
            MessageLookupByLibrary.simpleMessage("Home expenses"),
        "transactionCategoryInsurance":
            MessageLookupByLibrary.simpleMessage("Insurance"),
        "transactionCategoryInvestment":
            MessageLookupByLibrary.simpleMessage("Investments"),
        "transactionCategoryNone":
            MessageLookupByLibrary.simpleMessage("No category"),
        "transactionCategoryPrompt":
            MessageLookupByLibrary.simpleMessage("Select a category"),
        "transactionCategoryRefund":
            MessageLookupByLibrary.simpleMessage("Refunds"),
        "transactionCategoryRestaurants": MessageLookupByLibrary.simpleMessage(
            "Restaurants and coffee shops"),
        "transactionCategorySale":
            MessageLookupByLibrary.simpleMessage("Sales"),
        "transactionCategoryShopping":
            MessageLookupByLibrary.simpleMessage("Shopping"),
        "transactionCategorySport":
            MessageLookupByLibrary.simpleMessage("Sports"),
        "transactionCategoryTax":
            MessageLookupByLibrary.simpleMessage("Taxes and commissions"),
        "transactionCategoryTopup":
            MessageLookupByLibrary.simpleMessage("Top-ups"),
        "transactionCategoryTransport":
            MessageLookupByLibrary.simpleMessage("Transportation"),
        "transactionCategoryWorkSalary":
            MessageLookupByLibrary.simpleMessage("Work and salary"),
        "transactionCurrency": MessageLookupByLibrary.simpleMessage("Currency"),
        "transactionDate": MessageLookupByLibrary.simpleMessage("Date"),
        "transactionTag": MessageLookupByLibrary.simpleMessage("Tag"),
        "transactionTime": MessageLookupByLibrary.simpleMessage("Time"),
        "transactionUntitled": MessageLookupByLibrary.simpleMessage("Untitled"),
        "transactionViewInfoTitle":
            MessageLookupByLibrary.simpleMessage("General info"),
        "transactionViewUnsavedChangesApply":
            MessageLookupByLibrary.simpleMessage("Apply"),
        "transactionViewUnsavedChangesDiscard":
            MessageLookupByLibrary.simpleMessage("Discard"),
        "transactionViewUnsavedChangesPrompt":
            MessageLookupByLibrary.simpleMessage("Unsaved changes"),
        "transactionViewUnsavedChangesText":
            MessageLookupByLibrary.simpleMessage(
                "There are some unsaved changes.\nSave them now?"),
        "userPersonalBirthday":
            MessageLookupByLibrary.simpleMessage("Birthday"),
        "userPersonalName": MessageLookupByLibrary.simpleMessage("Name"),
        "userPersonalSurname": MessageLookupByLibrary.simpleMessage("Surname")
      };
}
