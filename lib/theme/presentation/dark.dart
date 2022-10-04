import 'package:flutter/material.dart';
import 'package:game_deal/theme/application/application_theme.dart';

class DarkTheme extends ApplicationTheme {
  final primaryColor = const Color(0xffe7ac5e);
  final onPrimaryColor = const Color(0xff2A1700);
  final scaffoldBgColor = const Color.fromARGB(255, 10, 24, 23);
  // final scaffoldBgColor = const Color(0xff001D1B);
  final onScaffoldBgColor = Colors.white.withOpacity(.8);
  // final cardColor = const Color.fromARGB(255, 0, 45, 42);
  final cardColor = const Color(0xff001D1B);
  final appBarColor = const Color.fromARGB(255, 0, 45, 42);
  final bottomNavBarColor = const Color.fromARGB(255, 0, 45, 42);
  final unselectedColor = const Color.fromARGB(255, 1, 83, 78);
  @override
  final shimmerBaseColor = const Color.fromARGB(255, 0, 81, 76);
  @override
  final shimmerHighlightColor = const Color.fromARGB(255, 0, 111, 104);

  @override
  ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.dark(
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
        cardTheme: CardTheme(
          color: cardColor,
          surfaceTintColor: Colors.white,
          shadowColor: primaryColor,
        ),
        appBarTheme: AppBarTheme(
          color: appBarColor,
          shadowColor: primaryColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: bottomNavBarColor,
          selectedItemColor: onScaffoldBgColor,
        ),
        chipTheme: ChipThemeData(
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
