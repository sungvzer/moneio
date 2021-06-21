import 'dart:ui';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat, Intl;
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/helpers/colors.dart';
import 'package:moneio/helpers/constants.dart';
import 'package:moneio/helpers/auth/auth_helpers.dart';
import 'package:moneio/helpers/categories.dart';
import 'package:moneio/helpers/strings.dart';
import 'package:moneio/models/currencies.dart';
import 'package:moneio/models/transaction.dart' as UserTransaction;
import 'package:moneio/widgets/labelled_form_field.dart';
import 'package:moneio/generated/l10n.dart';

class AddTransactionPage extends StatefulWidget {
  static final String id = '/home/add_transaction';

  AddTransactionPage();

  @override
  AddTransactionPageState createState() => AddTransactionPageState();
}

class AddTransactionPageState extends State<AddTransactionPage> {
  @override
  Widget build(BuildContext context) {
    if (Constants.morePrinting) {
      debugPrint("AddTransactionPageState.build: Adding PreferenceRead...");
    }
    BlocProvider.of<PreferenceBloc>(context)
        .add(PreferenceRead("", defaultSettings));
    return BlocBuilder<PreferenceBloc, PreferenceState>(
      builder: (context, state) {
        Map<String, dynamic> settings = {};
        if (state is PreferenceReadState ||
            (state is PreferenceWriteState && state.success)) {
          // TODO: Handle settings not existing
          if (state is PreferenceReadState) {
            try {
              settings = Map<String, dynamic>.from(state.readValue);
            } catch (e) {
              debugPrint(
                  "Call an ambulance call an ambulance, but not for me!");
              return CircularProgressIndicator();
            }
          } else {
            settings = (state as PreferenceWriteState).updatedPreferences;
            if (settings == {}) throw UnimplementedError();
          }
          if (morePrinting) {
            debugPrint(
                "AddTransactionPageState.build: preferences: ${settings.toString()}");
          }
        }
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: _TransactionForm(settings["favorite_currency"]!),
              physics: BouncingScrollPhysics(),
              clipBehavior: Clip.none,
            ),
          ),
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            centerTitle: true,
            title: Title(
              title: Localization.of(context).appName,
              color: ColorPalette.Black,
              child: Text(
                Localization.of(context).appName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TransactionForm extends StatelessWidget {
  final String _userFavoriteCurrency;

  _TransactionForm(this._userFavoriteCurrency);

  final GlobalKey<FormState> transactionFormKey =
      GlobalKey<FormState>(debugLabel: "TransactionForm");
  final Map<String, TextEditingController> _controllers = {
    "amount": TextEditingController(),
    "tag": TextEditingController(),
    "date": TextEditingController(
        text: DateFormat("dd/MM/yyyy").format(DateTime.now())),
    "time":
        TextEditingController(text: DateFormat("HH:mm").format(DateTime.now())),
    "emoji": TextEditingController()
  };

  @override
  Widget build(BuildContext context) {
    String _selectedCategory = "";
    InputDecoration _decoration = InputDecoration(
      errorMaxLines: 3,
      contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 20, right: 20),
    );

    String _selectedCurrency = _userFavoriteCurrency;
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: transactionFormKey,
        child: Column(
          children: <Widget>[
            LabelledFormField(
              Localization.of(context).transactionTag,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: _decoration.copyWith(
                  labelText: Localization.of(context).transactionUntitled,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: Theme.of(context).textTheme.bodyText2!,
                ),
                controller: _controllers["tag"],
                style: Theme.of(context).textTheme.bodyText2!,
                autocorrect: true,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: LabelledFormField(
                    Localization.of(context).transactionAmount,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: _decoration,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(symbol: ""),
                      ],
                      controller: _controllers["amount"],
                      validator: (value) {
                        if (value == null) return null;
                        if (value.isEmpty)
                          return Localization.of(context).insertAmountPrompt;
                        value = value.replaceAll(',', "");
                        if (double.parse(value) == 0.0)
                          return Localization.of(context).insertAmountPrompt;
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: LabelledFormField(
                    Localization.of(context).transactionCurrency,
                    child: DropdownButtonFormField(
                      value: _selectedCurrency,
                      validator: (str) => str == null
                          ? Localization.of(context).insertCurrencyPrompt
                          : null,
                      decoration: _decoration,
                      isExpanded: true,
                      onChanged: (value) {
                        if (value is String?) if (value != null)
                          _selectedCurrency = value.trim();
                      },
                      style: Theme.of(context).textTheme.bodyText2!,
                      items: currenciesWithoutNone().map((e) {
                        return DropdownMenuItem(
                            value: currencyCode(e),
                            child: Text(
                                currencySymbol(e) + ' - ' + currencyCode(e)));
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelledFormField(
                        Localization.of(context).transactionDate,
                        child: TextFormField(
                          decoration: _decoration,
                          validator: (value) {
                            return value == null || value == ""
                                ? Localization.of(context).insertDatePrompt
                                : null;
                          },
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2!,
                          readOnly: true,
                          controller: _controllers["date"],
                          onTap: () => showDatePicker(
                            locale: Locale(Intl.getCurrentLocale()),
                            context: context,
                            firstDate: DateTime(1900, 1, 1),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          ).then((value) {
                            final DateFormat f = DateFormat("dd/MM/yyyy");
                            var controller = _controllers["date"];
                            if (controller == null) return;
                            if (value == null) {
                              controller.text = "";
                              return;
                            }
                            controller.text = f.format(value);
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelledFormField(
                        Localization.of(context).transactionTime,
                        child: TextFormField(
                          decoration: _decoration,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2!,
                          readOnly: true,
                          controller: _controllers["time"],
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              var controller = _controllers["time"];
                              if (controller == null) return;
                              if (value == null) {
                                controller.text = "";
                                return;
                              }
                              controller.text = value.format(context);
                            });
                          },
                          validator: (value) {
                            if (value == "")
                              return Localization.of(context).insertTimePrompt;

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            LabelledFormField(
              Localization.of(context).transactionCategory,
              child: DropdownButtonFormField(
                decoration: _decoration,
                isExpanded: true,
                onChanged: (value) {
                  _selectedCategory = value.toString().trim();
                },
                validator: (str) => str == null
                    ? Localization.of(context).insertCategoryPrompt
                    : null,
                style: Theme.of(context).textTheme.bodyText2!,
                items: getCategoriesMenuItems(),
                hint: Center(
                  child: Text(
                    Localization.of(context).insertCategoryPrompt,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text(
                      Localization.of(context).addTransactionConfirm,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(100, 0)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).backgroundColor,
                      ),
                      // foregroundColor: MaterialStateProperty.all<Color>(
                      //     ColorPalette.ImperialPrimer),
                    ),
                    onPressed: () {
                      if (transactionFormKey.currentState!.validate()) {
                        int amountNumber;

                        Map<String, dynamic> map = {};
                        String tag = _controllers["tag"]!.text.trim(),
                            date = _controllers["date"]!.text.trim(),
                            time = _controllers["time"]!.text.trim(),
                            amount = _controllers["amount"]!.text.trim(),
                            currency = _selectedCurrency;

                        TimeOfDay parsedTime = parseTimeString(time);
                        bool isNegative = false;
                        List<int> dateList = [];

                        for (var entry in date.split('/')) {
                          dateList.add(int.parse(entry));
                        }

                        tag = tag.isNotEmpty ? tag : "Untitled";
                        if (amount.contains('-')) isNegative = true;
                        amount = amount.replaceAll(RegExp(r"\D"), "");
                        amountNumber = int.parse(amount);

                        if (isNegative) amountNumber *= -1;
                        // Initialize map
                        map["amount"] = amountNumber;
                        map["tag"] = tag;
                        map["category"] =
                            Constants.getCategory(_selectedCategory).toMap();
                        map["date"] = DateTime(dateList[2], dateList[1],
                                dateList[0], parsedTime.hour, parsedTime.minute)
                            .toIso8601String();
                        map["currency"] = currency;

                        BlocProvider.of<FirestoreBloc>(context).add(
                          FirestoreWrite(
                            type: FirestoreWriteType.AddSingleUserTransaction,
                            data: UserTransaction.Transaction.fromMap(map),
                            userId: loggedUID!,
                          ),
                        );

                        if (Constants.morePrinting) {
                          debugPrint("Data:\n$map");
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    child: Text(
                      Localization.of(context).addTransactionCancel,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(100, 0)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).backgroundColor,
                      ),
                      // backgroundColor:
                      //     MaterialStateProperty.all<Color>(Colors.white),
                      // foregroundColor: MaterialStateProperty.all<Color>(
                      //     ColorPalette.ImperialPrimer),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
