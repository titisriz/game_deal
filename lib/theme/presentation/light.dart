import 'package:flutter/material.dart';
import 'package:game_deal/theme/application/application_theme.dart';

// final baseColor = Colors.grey.shade200;
// final highlightColor = Colors.grey.shade100;
class LightTheme extends ApplicationTheme {
  final primaryColor = const Color(0xffe7ac5e);
  final onPrimaryColor = const Color(0xff2A1700);
  final scaffoldBgColor = const Color.fromARGB(255, 236, 254, 253);
  final onScaffoldBgColor = Colors.white;
  final cardColor = const Color.fromARGB(255, 90, 90, 90);
  final appBarColor = const Color.fromARGB(255, 6, 98, 92);
  final bottomNavBarColor = const Color.fromARGB(255, 6, 98, 92);
  final unselectedColor = const Color.fromARGB(255, 182, 182, 182);
  @override
  final shimmerBaseColor = Colors.grey.shade200;
  @override
  final shimmerHighlightColor = Colors.grey.shade100;

  @override
  ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.dark(
          primary: primaryColor,
          onPrimary: onPrimaryColor,
          brightness: Brightness.light,
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
        ),
        appBarTheme: AppBarTheme(
          color: appBarColor,
          foregroundColor: Colors.white70,
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
