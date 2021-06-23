// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(appName) =>
      "Qualcosa è andato storto avviando ${appName}, prova a riavviare l\'app";

  static String m1(characters) =>
      "Le password devono essere lunghe almeno ${characters} caratteri";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionCancel": MessageLookupByLibrary.simpleMessage("Annulla"),
        "actionDelete": MessageLookupByLibrary.simpleMessage("Elimina"),
        "actionDeletePrompt": MessageLookupByLibrary.simpleMessage(
            "Sei sicuro di voler eliminare questa transazione?"),
        "actionEdit": MessageLookupByLibrary.simpleMessage("Modifica"),
        "addTransactionCancel": MessageLookupByLibrary.simpleMessage("Annulla"),
        "addTransactionConfirm":
            MessageLookupByLibrary.simpleMessage("Aggiungi"),
        "appName": MessageLookupByLibrary.simpleMessage("mone.io"),
        "categoryEmoji": MessageLookupByLibrary.simpleMessage("Emoji"),
        "categoryName": MessageLookupByLibrary.simpleMessage("Nome"),
        "errorReload": MessageLookupByLibrary.simpleMessage("Riavvia"),
        "errorUnknown": m0,
        "homeAddATransactionTooltip":
            MessageLookupByLibrary.simpleMessage("Aggiungi una transazione"),
        "homeAscendingSort":
            MessageLookupByLibrary.simpleMessage("Ordine ascendente"),
        "homeDescendingSort":
            MessageLookupByLibrary.simpleMessage("Ordine discendente"),
        "homeDrawerSettings":
            MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "homeDrawerSignOut": MessageLookupByLibrary.simpleMessage("Esci"),
        "homeDrawerStats": MessageLookupByLibrary.simpleMessage("Statistiche"),
        "homeHistory": MessageLookupByLibrary.simpleMessage("Cronologia"),
        "homeNoTransactionMessageHint": MessageLookupByLibrary.simpleMessage(
            "Suggerimento: prova ad aggiungerne alcune premendo il tasto in basso!"),
        "homeNoTransactionMessageTitle":
            MessageLookupByLibrary.simpleMessage("Nessuna transazione qui!"),
        "homeRefresh":
            MessageLookupByLibrary.simpleMessage("Ricarica transazioni"),
        "homeSelectActionTitle":
            MessageLookupByLibrary.simpleMessage("Scegli un\'azione"),
        "homeSignOutPopupConfirm": MessageLookupByLibrary.simpleMessage("OK"),
        "homeSignOutPopupDismiss":
            MessageLookupByLibrary.simpleMessage("Annulla"),
        "homeSignOutPopupPrompt":
            MessageLookupByLibrary.simpleMessage("Sei sicuro di voler uscire?"),
        "homeSortByAmount":
            MessageLookupByLibrary.simpleMessage("Ordina per importo"),
        "homeSortByCategory":
            MessageLookupByLibrary.simpleMessage("Ordina per categoria"),
        "homeSortByDate":
            MessageLookupByLibrary.simpleMessage("Ordina per data"),
        "homeSortByTag":
            MessageLookupByLibrary.simpleMessage("Ordina per etichetta"),
        "homeSortByTooltip": MessageLookupByLibrary.simpleMessage("Ordina per"),
        "homeThisMonth": MessageLookupByLibrary.simpleMessage("Questo mese"),
        "homeThisWeek":
            MessageLookupByLibrary.simpleMessage("Questa settimana"),
        "homeToday": MessageLookupByLibrary.simpleMessage("Oggi"),
        "homeTotal": MessageLookupByLibrary.simpleMessage("Totale"),
        "insertAmountPrompt":
            MessageLookupByLibrary.simpleMessage("Inserisci un importo"),
        "insertCategoryPrompt":
            MessageLookupByLibrary.simpleMessage("Seleziona una categoria"),
        "insertCurrencyPrompt":
            MessageLookupByLibrary.simpleMessage("Seleziona una valuta"),
        "insertDatePrompt":
            MessageLookupByLibrary.simpleMessage("Inserisci una data"),
        "insertTimePrompt":
            MessageLookupByLibrary.simpleMessage("Inserisci un\'ora"),
        "loginCheckEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
            "Controlla la tua e-mail per ulteriori istruzioni"),
        "loginContinue": MessageLookupByLibrary.simpleMessage("Accedi"),
        "loginEmailAddress":
            MessageLookupByLibrary.simpleMessage("Indirizzo e-mail"),
        "loginEmailRequired": MessageLookupByLibrary.simpleMessage(
            "È necessaria un\'e-mail per accedere"),
        "loginPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "loginPasswordRequired": MessageLookupByLibrary.simpleMessage(
            "È necessaria una password per accedere"),
        "loginPasswordReset": MessageLookupByLibrary.simpleMessage(
            "Hai dimenticato la password?"),
        "loginSignUp": MessageLookupByLibrary.simpleMessage("Registrati"),
        "settingsDarkThemeDescription":
            MessageLookupByLibrary.simpleMessage("Accogli la notte"),
        "settingsDarkThemeTitle":
            MessageLookupByLibrary.simpleMessage("Tema scuro"),
        "settingsFavoriteCurrencyDescription": MessageLookupByLibrary.simpleMessage(
            "Questa sarà la valuta predefinita quando aggiungerai una transazione"),
        "settingsFavoriteCurrencyTitle":
            MessageLookupByLibrary.simpleMessage("Valuta preferita"),
        "settingsHumanReadableDescription": MessageLookupByLibrary.simpleMessage(
            "Utilizza un formato leggibile per importi maggiori di 10\'000"),
        "settingsHumanReadableTitle":
            MessageLookupByLibrary.simpleMessage("Formato leggibile"),
        "settingsSyncToCloudTitle": MessageLookupByLibrary.simpleMessage(
            "Sincronizza le impostazioni col cloud"),
        "signUpCredentialsLabel":
            MessageLookupByLibrary.simpleMessage("E-mail e password"),
        "signUpEmailRequired": MessageLookupByLibrary.simpleMessage(
            "È necessaria un\'e-mail per registrarsi"),
        "signUpInformationLabel": MessageLookupByLibrary.simpleMessage(
            "Informazioni personali (opzionali)"),
        "signUpPasswordCaseError": MessageLookupByLibrary.simpleMessage(
            "Le password devono contenere almeno un carattere maiuscolo"),
        "signUpPasswordLengthError": m1,
        "signUpPasswordRequired": MessageLookupByLibrary.simpleMessage(
            "È necessaria una password per registrarsi"),
        "statisticsCategories":
            MessageLookupByLibrary.simpleMessage("Categorie"),
        "statisticsCountBy": MessageLookupByLibrary.simpleMessage("Conta per"),
        "statisticsCountByNumber":
            MessageLookupByLibrary.simpleMessage("Numero"),
        "statisticsCurrencies": MessageLookupByLibrary.simpleMessage("Valute"),
        "statisticsTitle": MessageLookupByLibrary.simpleMessage("Statistiche"),
        "transactionAmount": MessageLookupByLibrary.simpleMessage("Importo"),
        "transactionCategory":
            MessageLookupByLibrary.simpleMessage("Categoria"),
        "transactionCategoryATM":
            MessageLookupByLibrary.simpleMessage("Bancomat"),
        "transactionCategoryAnimal":
            MessageLookupByLibrary.simpleMessage("Animali"),
        "transactionCategoryBills":
            MessageLookupByLibrary.simpleMessage("Bollette"),
        "transactionCategoryBodyCare":
            MessageLookupByLibrary.simpleMessage("Cura del corpo"),
        "transactionCategoryClothing":
            MessageLookupByLibrary.simpleMessage("Abbigliamento"),
        "transactionCategoryCrypto":
            MessageLookupByLibrary.simpleMessage("Criptovalute"),
        "transactionCategoryEducation":
            MessageLookupByLibrary.simpleMessage("Istruzione"),
        "transactionCategoryElectronic":
            MessageLookupByLibrary.simpleMessage("Elettronica e software"),
        "transactionCategoryEntertainment":
            MessageLookupByLibrary.simpleMessage("Intrattenimento"),
        "transactionCategoryFamily":
            MessageLookupByLibrary.simpleMessage("Famiglia"),
        "transactionCategoryFinancing":
            MessageLookupByLibrary.simpleMessage("Finanza e prestiti"),
        "transactionCategoryFood": MessageLookupByLibrary.simpleMessage("Cibo"),
        "transactionCategoryGeneric":
            MessageLookupByLibrary.simpleMessage("Generali"),
        "transactionCategoryGift":
            MessageLookupByLibrary.simpleMessage("Regali e donazioni"),
        "transactionCategoryHealth":
            MessageLookupByLibrary.simpleMessage("Salute"),
        "transactionCategoryHobby":
            MessageLookupByLibrary.simpleMessage("Hobby"),
        "transactionCategoryHome":
            MessageLookupByLibrary.simpleMessage("Spese casalinghe"),
        "transactionCategoryInsurance":
            MessageLookupByLibrary.simpleMessage("Assicurazione"),
        "transactionCategoryInvestment":
            MessageLookupByLibrary.simpleMessage("Investimenti"),
        "transactionCategoryNone":
            MessageLookupByLibrary.simpleMessage("Nessuna categoria"),
        "transactionCategoryPrompt":
            MessageLookupByLibrary.simpleMessage("Seleziona una categoria"),
        "transactionCategoryRefund":
            MessageLookupByLibrary.simpleMessage("Rimborsi"),
        "transactionCategoryRestaurants":
            MessageLookupByLibrary.simpleMessage("Ristoranti e bar"),
        "transactionCategorySale":
            MessageLookupByLibrary.simpleMessage("Vendite"),
        "transactionCategoryShopping":
            MessageLookupByLibrary.simpleMessage("Shopping"),
        "transactionCategorySport":
            MessageLookupByLibrary.simpleMessage("Sport"),
        "transactionCategoryTax":
            MessageLookupByLibrary.simpleMessage("Tasse e commissioni"),
        "transactionCategoryTopup":
            MessageLookupByLibrary.simpleMessage("Ricariche"),
        "transactionCategoryTransport":
            MessageLookupByLibrary.simpleMessage("Trasporto"),
        "transactionCategoryWorkSalary":
            MessageLookupByLibrary.simpleMessage("Lavoro e stipendi"),
        "transactionCurrency": MessageLookupByLibrary.simpleMessage("Valuta"),
        "transactionDate": MessageLookupByLibrary.simpleMessage("Data"),
        "transactionTag": MessageLookupByLibrary.simpleMessage("Etichetta"),
        "transactionTime": MessageLookupByLibrary.simpleMessage("Ora"),
        "transactionUntitled":
            MessageLookupByLibrary.simpleMessage("Senza etichetta"),
        "transactionViewInfoTitle":
            MessageLookupByLibrary.simpleMessage("Informazioni generali"),
        "transactionViewUnsavedChangesApply":
            MessageLookupByLibrary.simpleMessage("Salva"),
        "transactionViewUnsavedChangesDiscard":
            MessageLookupByLibrary.simpleMessage("Ignora modifiche"),
        "transactionViewUnsavedChangesPrompt":
            MessageLookupByLibrary.simpleMessage("Modifiche non salvate"),
        "transactionViewUnsavedChangesText":
            MessageLookupByLibrary.simpleMessage(
                "Ci sono modifiche non salvate.\nSalvarle ora?"),
        "userPersonalBirthday":
            MessageLookupByLibrary.simpleMessage("Data di nascita"),
        "userPersonalName": MessageLookupByLibrary.simpleMessage("Nome"),
        "userPersonalSurname": MessageLookupByLibrary.simpleMessage("Cognome")
      };
}
