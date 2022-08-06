import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/shared/providers.dart';
import 'package:game_deal/deals/core/presentation/image_placeholder.dart';

class HorizontalGameCardLoading extends ConsumerWidget {
  const HorizontalGameCardLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(currentThemeProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.shimmerBaseColor),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              ImagePlaceholder(ratio: 8 / 4, color: theme.shimmerBaseColor),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 100,
                height: 15,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
