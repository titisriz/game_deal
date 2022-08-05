import 'package:flutter/material.dart';
import 'package:game_deal/core/presentation/router/app_router.gr.dart';
import 'package:game_deal/core/presentation/theme/dark.dart';
import 'package:game_deal/core/presentation/theme/light.dart';
import 'package:game_deal/core/shared/providers.dart';
import 'package:game_deal/deal_store/shared/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initializationProvider = FutureProvider((ref) async {
  await ref.read(sembastProvider).init();
  ref.read(dealStoreStateNotifier.notifier).fetchStoreData();
});

class App extends ConsumerWidget {
  App({Key? key, this.theme}) : super(key: key);
  final ThemeData? theme;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (previous, next) {});
    return MaterialApp.router(
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'tes',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
