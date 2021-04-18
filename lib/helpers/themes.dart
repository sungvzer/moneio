import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  get darkTheme => _darkTheme;
  get lightTheme => _lightTheme;
  get currentTheme => _currentTheme;

  late ThemeData _currentTheme;
  late PreferenceBloc _preferenceBloc;

  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  final _lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  void _setCurrentTheme(bool isDarkMode) {
    _currentTheme = isDarkMode ? _darkTheme : _lightTheme;
    notifyListeners();
  }

  void _handleListen(PreferenceState state) {
    bool darkMode;
    if (state is PreferenceWriteState) {
      if (state.success == false) {
        debugPrint("ThemeNotifier._handleListen: success is false");
        return;
      }

      Map<String, dynamic> preferences = state.updatedPreferences;
      debugPrint("ThemeNotifier._handleListen: preferences -> $preferences");
      assert(
        preferences.keys.contains("dark_mode"),
        "Preferences do not contain dark mode",
      );
      darkMode = preferences["dark_mode"]!;
      debugPrint("ThemeNotifier._handleListen: darkMode is $darkMode");
      _setCurrentTheme(darkMode);
      return;
    }

    if (state is PreferenceReadState) {
      if (state.key != "" && state.key != "dark_mode") return;

      if (state.key == "") {
        assert(state.readValue is Map);
        Map<String, dynamic> value = state.readValue;
        debugPrint("ThemeNotifier._handleListen: value -> $value");
        assert(value.keys.contains("dark_mode"));

        darkMode = value["dark_mode"];
        debugPrint("ThemeNotifier._handleListen: darkMode is $darkMode");
        _setCurrentTheme(darkMode);

        return;
      }

      if (state.key == "dark_mode") {
        assert(state.readValue is bool);
        darkMode = state.readValue as bool;
        debugPrint("ThemeNotifier._handleListen: darkMode is $darkMode");
        _setCurrentTheme(darkMode);

        return;
      }
    }
  }

  ThemeNotifier(BuildContext context) {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _preferenceBloc.stream.listen(_handleListen);
  }
}
