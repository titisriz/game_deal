import 'package:flutter/material.dart';

// final baseColor = Colors.grey.shade200;
// final highlightColor = Colors.grey.shade100;
ThemeData lightTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    colorScheme: const ColorScheme.light(
      brightness: Brightness.dark,
    ),
  );
}
