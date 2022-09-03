import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/deals/deal_main/presentation/deal_by_store_section.dart';
import 'package:game_deal/deals/deal_main/presentation/horizontal_game_section.dart';

import 'package:game_deal/deals/deal_main/shared/providers.dart';

class DealMainPage extends ConsumerWidget {
  const DealMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = [
      HorizontalGameSection(
        title: "Free Games",
        getData: (ref) =>
            ref.watch(freeGamesStateNotifierProvider.notifier).getFreeGames(),
        stateNotifierProvider: freeGamesStateNotifierProvider,
      ),
      HorizontalGameSection(
        title: "Popular Deals",
        getData: (ref) => ref
            .watch(popularDealStateNotifierProvider.notifier)
            .getPopularDeal(),
        stateNotifierProvider: popularDealStateNotifierProvider,
      ),
      HorizontalGameSection(
        title: "Most Recent Deals",
        getData: (ref) => ref
            .watch(recentDealStateNotifierProvider.notifier)
            .getMostRecentDeal(),
        stateNotifierProvider: recentDealStateNotifierProvider,
      ),
      const DealByStoreSection(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.watch(freeGamesStateNotifierProvider.notifier).getFreeGames();
            ref
                .watch(popularDealStateNotifierProvider.notifier)
                .getPopularDeal();
            ref
                .watch(recentDealStateNotifierProvider.notifier)
                .getMostRecentDeal();
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return sections[index];
            },
          ),
        ),
      ),
    );
  }
}
