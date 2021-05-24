import 'package:animate_icons/animate_icons.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/helpers/auth/auth_helpers.dart';
import 'package:moneio/models/arguments/transaction_argument.dart';
import 'package:moneio/models/transaction.dart';

enum _FieldName {
  Tag,
  Amount,
  Date,
  Time,
  Currency,
  Category,
}

Map<_FieldName, String> _formValues = {};

class TransactionView extends StatefulWidget {
  static final String id = '/home/transaction_view';

  TransactionView();

  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  bool didMakeChanges = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CrossFadeState fadeState = CrossFadeState.showFirst;
  final controller = AnimateIconController();
  late Transaction _transaction;
  bool didReadTransaction = false;

  TimeOfDay _parseTimeString(String time) {
    // We consider time to never be null because of
    // the form validator that doesn't allow this.
    time = time.toUpperCase().trim();

    final RegExp twelveHourRegEx = RegExp(r"AM|PM");
    final List<String> splitTime =
        time.replaceAll(twelveHourRegEx, "").split(':');

    TimeOfDay parsedTime;
    bool isAM = false, isPM = false, isTwelveHour = false;
    int hour, minute;

    if (morePrinting) debugPrint("Got string: $time");

    isTwelveHour = time.contains(twelveHourRegEx);

    hour = int.parse(splitTime[0]);
    minute = int.parse(splitTime[1]);

    if (isTwelveHour) {
      isPM = time.contains(RegExp(r"PM"));
      isAM = !isPM;

      if (isAM && hour == 12) hour = 0;

      if (isPM && hour != 12) hour += 12;
    }
    parsedTime = TimeOfDay(hour: hour, minute: minute);
    return parsedTime;
  }

  @override
  Widget build(BuildContext context) {
    NavigatorState nav = Navigator.of(context);
    TransactionArgument? arg;

    if (!didReadTransaction) {
      try {
        arg = ModalRoute.of(context)!.settings.arguments as TransactionArgument;
        _transaction = arg.transaction;
        didReadTransaction = true;
      } catch (e) {
        nav.pop();
        return Container();
      }
    }
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<FirestoreBloc>(context).add(FirestoreWrite(
                    type: FirestoreWriteType.EditSingleUserTransaction,
                    userId: loggedUID!,
                    data: _transaction));
                Navigator.pop(context);
              },
            ),
            title: Title(
              color: Theme.of(context).primaryColor,
              title: "mone.io",
              child: Text(
                "mone.io: ${_transaction.tag}",
                style: Theme.of(context).textTheme.headline6!,
              ),
            ),
            actions: [
              AnimateIcons(
                startIcon: Icons.edit,
                endIcon: Icons.done,
                onStartIconPress: () {
                  setState(() {
                    fadeState = CrossFadeState.showSecond;
                  });
                  return true;
                },
                onEndIconPress: () {
                  FormState? state = formKey.currentState;
                  if (state == null) {
                    debugPrint("_TransactionViewState.build: Form is no more.");
                    return false;
                  }
                  bool valid = state.validate();

                  if (!valid) {
                    return false;
                  }
                  setState(() {
                    state.save();
                    int amountNumber;
                    Map<String, dynamic> map = {};

                    String tag = _formValues[_FieldName.Tag]!.trim(),
                        date = _formValues[_FieldName.Date]!.trim(),
                        time = _formValues[_FieldName.Time]!.trim(),
                        amount = _formValues[_FieldName.Amount]!.trim(),
                        currency = _formValues[_FieldName.Currency]!.trim(),
                        category = _formValues[_FieldName.Category]!.trim();
                    List<int> dateList = [];

                    TimeOfDay parsedTime = _parseTimeString(time);

                    bool isNegative = amount.contains('-');

                    for (var entry in date.split('/')) {
                      dateList.add(int.parse(entry));
                    }

                    tag = tag.isNotEmpty ? tag : "Untitled";

                    amount = amount.replaceAll(RegExp(r"\D"), "");
                    amountNumber = int.parse(amount);

                    if (isNegative) amountNumber *= -1;
                    // Initialize map
                    map["amount"] = amountNumber;
                    map["tag"] = tag;
                    map["category"] = categories[category]!.toMap();
                    map["date"] = DateTime(dateList[2], dateList[1],
                            dateList[0], parsedTime.hour, parsedTime.minute)
                        .toIso8601String();
                    map["currency"] = currency;

                    // Keep the id because it is indeed the same transaction for database concerns
                    map["id"] = _transaction.id;

                    final transaction = Transaction.fromMap(map);
                    _transaction = transaction;
                    fadeState = CrossFadeState.showFirst;
                    debugPrint(
                        "_TransactionViewState.build: fadeState switching to view.");
                  });
                  return true;
                },
                controller: controller,
                // TODO: Use IconTheme instead
                startIconColor: Theme.of(context).textTheme.headline6!.color,
                endIconColor: Theme.of(context).textTheme.headline6!.color,
                duration: Duration(milliseconds: 300),
              ),
              IconButton(
                tooltip: "Delete",
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Delete"),
                      content: Text(
                        "Are you sure you want to delete this transaction?",
                      ),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text("Delete"),
                          onPressed: () {
                            debugPrint(
                                "_TransactionViewState: deleting ${_transaction.id}");
                            BlocProvider.of<FirestoreBloc>(context).add(
                              FirestoreWrite(
                                userId: loggedUID!,
                                type: FirestoreWriteType
                                    .RemoveSingleUserTransaction,
                                data: _transaction.id,
                              ),
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          body: AnimatedCrossFade(
            firstChild: TransactionViewBody(_transaction),
            secondChild: TransactionEditBody(_transaction, formKey),
            crossFadeState: fadeState,
            duration: Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }
}

class TransactionViewBody extends StatelessWidget {
  final Transaction transaction;
  TransactionViewBody(this.transaction);

  @override
  Widget build(BuildContext context) {
    final ThemeData currentTheme = Theme.of(context);

    final ListTile titleTile,
        amountTile,
        currencyTile,
        nameTile,
        emojiTile,
        dateTile;

    titleTile = ListTile(
      leading: Text(
        "Tag",
        style: currentTheme.textTheme.bodyText1,
      ),
      title: Text(
        transaction.tag,
        textAlign: TextAlign.right,
        style: currentTheme.textTheme.bodyText2,
      ),
    );
    amountTile = ListTile(
      leading: Text(
        "Amount",
        style: currentTheme.textTheme.bodyText1,
      ),
      title: Text(
        transaction.getSeparatedAmountString(sign: true),
        textAlign: TextAlign.right,
        style: currentTheme.textTheme.bodyText2,
      ),
    );
    currencyTile = ListTile(
      leading: Text(
        "Currency",
        style: currentTheme.textTheme.bodyText1,
      ),
      title: Text(
        transaction.getCurrencySymbol() + ' ' + transaction.currency,
        textAlign: TextAlign.right,
        style: currentTheme.textTheme.bodyText2,
      ),
    );
    nameTile = ListTile(
      leading: Text(
        "Name",
        style: currentTheme.textTheme.bodyText1,
      ),
      title: Text(
        transaction.category.name,
        textAlign: TextAlign.right,
        style: currentTheme.textTheme.bodyText2,
      ),
    );
    emojiTile = ListTile(
      leading: Text(
        "Emoji",
        style: currentTheme.textTheme.bodyText1,
      ),
      title: Text(
        transaction.category.hasEmoji ? transaction.category.emoji : "None",
        textAlign: TextAlign.right,
        style: currentTheme.textTheme.bodyText2,
      ),
    );

    final DateTime date = transaction.date;
    String formattedDateString = "${date.day.toString().padLeft(2, '0')}/";
    formattedDateString += "${date.month.toString().padLeft(2, '0')}/";
    formattedDateString += "${date.year.toString().padLeft(4, '0')} ";
    formattedDateString += "${date.hour.toString().padLeft(2, '0')}:";
    formattedDateString += "${date.minute.toString().padLeft(2, '0')}";

    dateTile = ListTile(
      leading: Text(
        "Date",
        style: currentTheme.textTheme.bodyText1,
      ),
      title: Text(
        formattedDateString,
        textAlign: TextAlign.right,
        style: currentTheme.textTheme.bodyText2,
      ),
    );

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "General info",
                style: currentTheme.textTheme.headline5,
              ),
            ),
            Divider(
              thickness: 1,
            ),
            titleTile,
            amountTile,
            currencyTile,
            dateTile,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Category",
                style: currentTheme.textTheme.headline5,
              ),
            ),
            Divider(
              thickness: 1,
            ),
            nameTile,
            emojiTile,
          ],
        ),
      ),
    );
  }
}

class TransactionEditBody extends StatefulWidget {
  final Transaction transaction;
  final GlobalKey<FormState> formKey;
  TransactionEditBody(this.transaction, this.formKey);

  @override
  _TransactionEditBodyState createState() => _TransactionEditBodyState(formKey);
}

class _TransactionEditBodyState extends State<TransactionEditBody> {
  final tagController = TextEditingController();
  final amountController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  GlobalKey<FormState> formKey;

  _TransactionEditBodyState(this.formKey);

  String selectedCurrency = "";
  String selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    final ThemeData currentTheme = Theme.of(context);
    final Transaction transaction = widget.transaction;
    tagController.text = transaction.tag;
    selectedCurrency = transaction.currency;
    selectedCategory = transaction.category.uniqueID;
    String amountControllerText = "";
    if (transaction.amount < 0) {
      amountControllerText += '-';
    }
    amountControllerText += transaction.getSeparatedAmountString();
    amountController.text = amountControllerText;

    dateController.text = DateFormat("dd/MM/yyyy").format(transaction.date);
    timeController.text =
        TimeOfDay.fromDateTime(transaction.date).format(context);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Edit",
                  style: currentTheme.textTheme.headline5,
                ),
              ),
              Divider(
                thickness: 1,
              ),
              TextFormField(
                onSaved: (s) {
                  if (s == null) return;
                  _formValues[_FieldName.Tag] = s;
                },
                style: Theme.of(context).textTheme.bodyText2!,
                decoration: InputDecoration(
                  labelText: "Tag",
                  hintText: "Untitled",
                ),
                controller: tagController,
              ),
              TextFormField(
                onSaved: (s) {
                  if (s == null) return;
                  _formValues[_FieldName.Amount] = s;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Amount"),
                style: Theme.of(context).textTheme.bodyText2!,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyTextInputFormatter(symbol: ""),
                ],
                controller: amountController,
                validator: (value) {
                  if (value == null) return null;
                  if (value.isEmpty) return "Please enter an amount.";
                  value = value.replaceAll(',', "");
                  if (double.parse(value) == 0.0)
                    return "Please enter an amount";
                  return null;
                },
              ),
              TextFormField(
                onSaved: (s) {
                  if (s == null) return;
                  _formValues[_FieldName.Date] = s;
                },
                decoration: InputDecoration(labelText: "Date"),
                validator: (value) {
                  return value == null || value == ""
                      ? "Please enter a date."
                      : null;
                },
                style: Theme.of(context).textTheme.bodyText2!,
                readOnly: true,
                controller: dateController,
                onTap: () => showDatePicker(
                  context: context,
                  firstDate: DateTime(1900, 1, 1),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                ).then((value) {
                  final DateFormat f = DateFormat("dd/MM/yyyy");
                  var controller = dateController;
                  if (value == null) {
                    controller.text = "";
                    return;
                  }
                  controller.text = f.format(value);
                }),
              ),
              TextFormField(
                onSaved: (s) {
                  if (s == null) return;
                  _formValues[_FieldName.Time] = s;
                },
                decoration: InputDecoration(labelText: "Time"),
                style: Theme.of(context).textTheme.bodyText2!,
                readOnly: true,
                controller: timeController,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    var controller = timeController;
                    if (value == null) {
                      controller.text = "";
                      return;
                    }
                    controller.text = value.format(context);
                  });
                },
                validator: (value) {
                  if (value == "") return "Please enter a time.";

                  return null;
                },
              ),
              DropdownButtonFormField(
                onSaved: (s) {
                  if (s is! String?) return;
                  if (s == null) return;
                  _formValues[_FieldName.Currency] = s;
                },
                decoration: InputDecoration(labelText: "Currency"),
                value: selectedCurrency,
                validator: (str) =>
                    str == null ? "Please insert a currency" : null,
                isExpanded: true,
                onChanged: (value) {
                  if (value is String?) if (value != null)
                    selectedCurrency = value.trim();
                },
                style: Theme.of(context).textTheme.bodyText2!,
                items: currencyToSymbol.keys.map((final String key) {
                  const Map<String, String> map = currencyToSymbol;
                  String value = map[key] as String;
                  return DropdownMenuItem(
                    child: Text("$value - $key"),
                    value: key,
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                onSaved: (s) {
                  if (s == null) return;
                  _formValues[_FieldName.Category] = s;
                },
                decoration: InputDecoration(labelText: "Category"),
                value: selectedCategory,
                isExpanded: true,
                onChanged: (value) {
                  selectedCategory = value.toString().trim();
                },
                validator: (str) =>
                    str == null ? "Please enter a category" : null,
                style: Theme.of(context).textTheme.bodyText2!,
                items: _getCategoriesMenuItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getCategoriesMenuItems() {
    final values = categories.values.toList();
    var list = <DropdownMenuItem<String>>[];

    list.add(
      DropdownMenuItem<String>(
        child: Text("None"),
        value: "NONE",
      ),
    );

    for (var value in values.where((c) => c.uniqueID != "NONE")) {
      list.add(DropdownMenuItem<String>(
        child: Text("${value.emoji} - ${value.name}"),
        value: value.uniqueID,
      ));
    }
    return list;
  }
}
