import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/deals/core/application/deal_state_notifier.dart';
import 'package:game_deal/deals/deal_main/presentation/horizontal_game_card.dart';
import 'package:game_deal/deals/deal_main/presentation/horizontal_game_card_loading.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalGameSection extends ConsumerStatefulWidget {
  const HorizontalGameSection({
    Key? key,
    required this.stateNotifierProvider,
    required this.getData,
    required this.title,
  }) : super(key: key);

  final StateNotifierProvider<DealStateNotifier, DealState>
      stateNotifierProvider;
  final Future<void> Function(WidgetRef ref) getData;
  final String title;

  @override
  ConsumerState<HorizontalGameSection> createState() =>
      _HorizontalGameSectionState();
}

class _HorizontalGameSectionState extends ConsumerState<HorizontalGameSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.watch(widget.stateNotifierProvider);
      return state.maybeMap(
        orElse: () {},
        initial: (_) => widget.getData(ref),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.stateNotifierProvider);
    return state.maybeMap(
      orElse: () => Container(),
      loadInProgress: (value) => const SectionLoading(),
      loadSuccess: (value) {
        if (value.dealResults.isEmptyResult) {
          return Container();
        }
        // return const SectionLoading();
        return Section(title: widget.title, state: state);
      },
    );
  }
}

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.title,
    required this.state,
  }) : super(key: key);

  final String title;
  final DealState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.dealResults.content
                .map(
                  (e) => HorizontalGameCard(
                    key: UniqueKey(),
                    dealResult: e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class SectionLoading extends StatelessWidget {
  const SectionLoading({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 180,
              height: 20,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            const SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: Iterable.generate(5)
                      .map((e) => const HorizontalGameCardLoading())
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
