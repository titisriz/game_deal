import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
    ),
  );
}
