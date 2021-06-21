import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/helpers/colors.dart';

enum _fonts {
  poppinsThin,
  poppinsExtraLight,
  poppinsLight,
  poppinsRegular,
  poppinsMedium,
  poppinsSemiBold,
  poppinsBold,
  poppinsExtraBold,
  poppinsBlack,
}

class ThemeNotifier with ChangeNotifier {
  get darkTheme => _darkTheme;
  get lightTheme => _lightTheme;
  get currentTheme => _currentTheme;

  late ThemeData _currentTheme;
  late PreferenceBloc _preferenceBloc;

  static const Map<_fonts, TextStyle> textStylesWithoutColor = {
    _fonts.poppinsThin: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w100,
    ),
    _fonts.poppinsExtraLight: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w200,
    ),
    _fonts.poppinsLight: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w300,
    ),
    _fonts.poppinsRegular: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    _fonts.poppinsMedium: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    _fonts.poppinsSemiBold: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),
    _fonts.poppinsBold: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
    ),
    _fonts.poppinsExtraBold: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w800,
    ),
    _fonts.poppinsBlack: TextStyle(
      fontFamily: "Poppins",
      fontWeight: FontWeight.w900,
    ),
  };

  var _darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    brightness: Brightness.dark,
    primaryColor: ColorPalette.ImperialPrimer,
    accentColor: ColorPalette.LightBlueBallerina,
    textTheme: TextTheme(
      bodyText2: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.StormPetrel,
      ),
      bodyText1: textStylesWithoutColor[_fonts.poppinsSemiBold]!.copyWith(
        color: ColorPalette.StormPetrel,
        fontSize: 14,
      ),
      subtitle2: textStylesWithoutColor[_fonts.poppinsLight]!.copyWith(
        color: ColorPalette.LightBlueBallerina,
        fontSize: 11,
      ),
      button: textStylesWithoutColor[_fonts.poppinsRegular]!,
      headline4: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.LightBlueBallerina,
      ),
      headline5: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.LightBlueBallerina,
      ),
      headline6: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.LightBlueBallerina,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.LightBlueBallerina,
      foregroundColor: ColorPalette.ImperialPrimer,
    ),
    backgroundColor: ColorPalette.ImperialPrimer,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalette.LightBlueBallerina,
      selectionHandleColor: ColorPalette.LightBlueBallerina,
      selectionColor: darken(ColorPalette.LightBlueBallerina, 70),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ColorPalette.LightBlueBallerina,
      ),
      focusColor: ColorPalette.LightBlueBallerina,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.LightBlueBallerina,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: ColorPalette.LightBlueBallerina,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.Amour,
          width: 2,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.Amour,
        ),
      ),
    ),
  );

  var _lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: ColorPalette.ImperialPrimer,
      ),
      foregroundColor: ColorPalette.ImperialPrimer,
    ),
    // TODO: input decoration theme
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.DarkMountainMeadow,
      foregroundColor: ColorPalette.ImperialPrimer,
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      color: ColorPalette.StormPetrel,
    ),
    primaryColor: ColorPalette.DarkMountainMeadow,
    accentColor: ColorPalette.DarkMountainMeadow,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalette.DarkMountainMeadow,
      selectionHandleColor: ColorPalette.DarkMountainMeadow,
      selectionColor: lighten(ColorPalette.DarkMountainMeadow, 70),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ColorPalette.ImperialPrimer,
      ),
      focusColor: ColorPalette.DarkMountainMeadow,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.DarkMountainMeadow,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: ColorPalette.DarkMountainMeadow,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.Amour,
          width: 2,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.Amour,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all<Color>(ColorPalette.ImperialPrimer),
        // Ripple for text button
        // overlayColor: MaterialStateProperty.all<Color>(ColorPalette.Black),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: textStylesWithoutColor[_fonts.poppinsSemiBold]!.copyWith(
        color: ColorPalette.ImperialPrimer,
        fontSize: 14,
      ),
      bodyText2: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.FuelTown,
      ),
      subtitle2: textStylesWithoutColor[_fonts.poppinsLight]!.copyWith(
        color: ColorPalette.StormPetrel,
        fontSize: 11,
      ),
      button: textStylesWithoutColor[_fonts.poppinsRegular]!,
      headline4: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.ImperialPrimer,
      ),
      headline5: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.ImperialPrimer,
      ),
      headline6: textStylesWithoutColor[_fonts.poppinsRegular]!.copyWith(
        color: ColorPalette.ImperialPrimer,
      ),
    ),
    backgroundColor: ColorPalette.White,
  );

  void _setCurrentTheme({bool? isDarkMode, Color? primaryColor}) {
    ThemeData oldTheme = _currentTheme;

    // debugPrint("ThemeNotifier._setCurrentTheme: $isDarkMode, $primaryColor");
    if (isDarkMode != null) {
      _currentTheme = isDarkMode ? _darkTheme : _lightTheme;
    }

    // If we got a color to change
    // if (primaryColor != null) {
    //   _currentTheme = isDarkMode != null && isDarkMode
    //       ? _currentTheme.copyWith(
    //           accentColor: ColorPalette.LightBlueBallerina,
    //         )
    //       : _currentTheme.copyWith(
    //           primaryColor: primaryColor,
    //         );
    // }

    if (_currentTheme != oldTheme) {
      debugPrint("ThemeNotifier._setCurrentTheme: new theme!");
      notifyListeners();
    }
  }

  void _handleListen(PreferenceState state) {
    bool? darkMode;
    Color? accentColor;
    if (state is PreferenceWriteState) {
      if (state.success == false) {
        debugPrint("ThemeNotifier._handleListen: success is false");
        return;
      }

      Map<String, dynamic> preferences = state.updatedPreferences;
      // debugPrint("ThemeNotifier._handleListen: preferences -> $preferences");
      assert(
        preferences.keys.contains("dark_mode"),
        "Preferences do not contain dark mode",
      );
      darkMode = preferences["dark_mode"]!;
      _setCurrentTheme(isDarkMode: darkMode);
      return;
    } else if (state is PreferenceReadState) {
      if (state.key != "" &&
          state.key != "dark_mode" &&
          state.key != "accent_color") return;

      if (state.key == "") {
        assert(state.readValue is Map);
        Map<String, dynamic> value = state.readValue;
        assert(value.keys.contains("dark_mode"));
        assert(value.keys.contains("accent_color"));

        darkMode = value["dark_mode"];
        accentColor = parseColorString(value["accent_color"]);
      } else if (state.key == "accent_color") {
        accentColor = parseColorString(state.readValue);
      } else if (state.key == "dark_mode") {
        assert(state.readValue is bool);
        darkMode = state.readValue as bool;
      }
      _setCurrentTheme(isDarkMode: darkMode, primaryColor: accentColor);
    }
  }

  ThemeNotifier(BuildContext context) {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _preferenceBloc.stream.listen(_handleListen);
    _currentTheme = _lightTheme;
  }
}
