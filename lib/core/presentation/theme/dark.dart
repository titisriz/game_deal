import 'package:flutter/material.dart';

const primaryColor = Color(0xffe7ac5e);
const onPrimaryColor = Color(0xff2A1700);
const scaffoldBgColor = Color(0xff001D1B);
const onScaffoldBgColor = Colors.white;
const cardColor = Color.fromARGB(255, 0, 45, 42);
const appBarColor = Color.fromARGB(255, 0, 45, 42);
const bottomNavBarColor = Color.fromARGB(255, 0, 45, 42);
const unselectedColor = Color.fromARGB(255, 1, 83, 78);
const shimmerBaseColor = Color.fromARGB(255, 0, 81, 76);
const shimmerHighlightColor = Color.fromARGB(255, 0, 111, 104);

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
      color: cardColor,
      surfaceTintColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      color: appBarColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarColor,
      selectedItemColor: onScaffoldBgColor,
    ),
    chipTheme: const ChipThemeData(
      disabledColor: scaffoldBgColor,
      selectedColor: primaryColor,
      checkmarkColor: Colors.green,
      backgroundColor: unselectedColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(primaryColor),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color.fromARGB(255, 211, 158, 1);
        } else {
          return unselectedColor;
        }
      }),
    ),
  );
}
