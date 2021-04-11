import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/color_parser.dart';
import 'package:moneio/constants.dart';

class SettingListTile<T> extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String settingKey;
  final T initialValue;

  SettingListTile(this.initialValue,
      {required this.title, this.subtitle, required this.settingKey});

  @override
  _SettingListTileState<T> createState() =>
      _SettingListTileState<T>(initialValue, title, subtitle, settingKey);
}

class _SettingListTileState<T> extends State<SettingListTile> {
  T _value;
  String _title;
  String? _subtitle;
  String _settingKey;

  _SettingListTileState(
    this._value,
    this._title,
    this._subtitle,
    this._settingKey,
  );

  Widget getWidgetByType(context) {
    Text titleText = Text(
      _title,
      style: TextStyle(
        fontFamily: "Poppins",
        color: ColorPalette.ImperialPrimer,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );

    Text? subtitleText = _subtitle != null
        ? Text(
            _subtitle!,
            style: TextStyle(
              fontFamily: "Poppins",
              color: ColorPalette.StormPetrel,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          )
        : null;
    // TODO: Implement other types as we need fit
    if (_value is bool) {
      bool value = _value as bool;
      return ListTile(
        title: titleText,
        subtitle: subtitleText,
        onTap: () {
          setState(() {
            value = !value;
            _value = value as T;
            BlocProvider.of<PreferenceBloc>(context)
                .add(PreferenceWrite(_settingKey, value));
          });
        },
        trailing: Switch(
          value: value,
          onChanged: (bool _) {
            setState(() {
              BlocProvider.of<PreferenceBloc>(context)
                  .add(PreferenceWrite(_settingKey, _));
              print("Setting $_settingKey to $_");
              value = _;
              _value = _ as T;
            });
          },
        ),
      );
    } else if (_value is String && isColorString(_value as String)) {
      if (morePrinting)
        debugPrint(
            "SettingListTileState.getWidgetByType(): Got string $_value, this is a color");
      Color value = parseColorString(_value as String);
      return ListTile(
        title: titleText,
        subtitle: subtitleText,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              Color temporaryValue = value;
              return AlertDialog(
                title: Text(this._title),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    availableColors: ColorPalette.getAllColors([
                      ColorPalette.ImperialPrimer,
                      ColorPalette.Bluebell,
                      ColorPalette.NasuPurple,
                    ]),
                    pickerColor: value,
                    onColorChanged: (color) => temporaryValue = color,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Back'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      if (this._settingKey == "accent_color")
                        setState(() {
                          BlocProvider.of<PreferenceBloc>(context).add(
                              PreferenceWrite("accent_color",
                                  colorToString(temporaryValue)));
                          _value = colorToString(temporaryValue) as T;
                        });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        trailing: CircleAvatar(
          child: Container(),
          backgroundColor: parseColorString(_value as String),
        ),
      );
    }

    debugPrint("Unsupported type ${_value.runtimeType}");
    throw UnimplementedError(
        "Type ${_value.runtimeType} is not yet implemented");
  }

  @override
  Widget build(BuildContext context) {
    // if (T is bool) debugPrint("Boolean!");
    return Container(child: getWidgetByType(context));
  }
}
