import 'package:flutter/material.dart';
import 'package:game_deal/core/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Switch.adaptive(
          value: ref.watch(themeModeProvider) == ThemeMode.dark ? true : false,
          onChanged: (value) {
            ref.read(themeModeProvider.notifier).update((state) {
              return value ? ThemeMode.dark : ThemeMode.light;
            });
          },
        );
      },
    );
  }
}
