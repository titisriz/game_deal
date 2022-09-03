import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/infrastructure/sembast_database.dart';
import 'package:game_deal/theme/application/application_theme.dart';
import 'package:game_deal/theme/presentation/dark.dart';
import 'package:game_deal/theme/presentation/light.dart';

final dioProvider = Provider(
  (ref) => Dio(),
);
final sembastProvider = Provider((ref) => SembastDatabase());

final darkThemeProvider = Provider<ApplicationTheme>(
  (ref) => DarkTheme(),
);
final lightThemeProvider = Provider<ApplicationTheme>(
  (ref) => LightTheme(),
);
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

final currentThemeProvider = Provider<ApplicationTheme>(
  (ref) {
    final mode = ref.watch(themeModeProvider);
    return mode == ThemeMode.dark
        ? ref.watch(darkThemeProvider)
        : ref.watch(lightThemeProvider);
  },
);
