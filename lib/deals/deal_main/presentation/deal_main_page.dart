import 'package:flutter/material.dart';
import 'package:game_deal/deals/deal_main/presentation/deal_by_store_section.dart';
import 'package:game_deal/deals/deal_main/presentation/horizontal_game_section.dart';

import 'package:game_deal/deals/deal_main/shared/providers.dart';

class DealMainPage extends StatefulWidget {
  const DealMainPage({Key? key}) : super(key: key);

  @override
  State<DealMainPage> createState() => _DealMainPageState();
}

class _DealMainPageState extends State<DealMainPage> {
  @override
  Widget build(BuildContext context) {
    final sections = [
      HorizontalGameSection(
        title: "Free Games",
        getData: (ref) =>
            ref.watch(freeGamesStateNotifierProvider.notifier).getFreeGames(),
        stateNotifierProvider: freeGamesStateNotifierProvider,
      ),
      HorizontalGameSection(
        title: "Popular Game Deals",
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
      Text(
        'Top Deals by Store',
        style: Theme.of(context).textTheme.headline6,
      ),
      const DealByStoreSection(),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
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
