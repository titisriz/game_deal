import 'package:flutter/material.dart';

const primaryColor = Color(0xffe7ac5e);
const onPrimaryColor = Color(0xff2A1700);
const scaffoldBgColor = Color(0xff001D1B);
const onScaffoldBgColor = Colors.white;
const elevation1 = Color.fromARGB(255, 0, 45, 42);
const unselectedColor = Color.fromARGB(255, 1, 83, 78);

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      brightness: Brightness.dark,
      background: scaffoldBgColor,
      onBackground: onScaffoldBgColor,
      onPrimaryContainer: onScaffoldBgColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        foregroundColor: MaterialStateProperty.all(onPrimaryColor),
      ),
    ),
    scaffoldBackgroundColor: scaffoldBgColor,
    cardTheme: const CardTheme(
      color: elevation1,
      surfaceTintColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      color: elevation1,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: elevation1,
      selectedItemColor: onScaffoldBgColor,
    ),
    chipTheme: const ChipThemeData(
      disabledColor: scaffoldBgColor,
      selectedColor: primaryColor,
      checkmarkColor: Colors.green,
      backgroundColor: unselectedColor,
    ),
  );
}
