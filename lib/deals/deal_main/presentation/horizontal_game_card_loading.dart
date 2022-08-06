import 'package:flutter/material.dart';
import 'package:game_deal/core/presentation/theme/dark.dart';
import 'package:game_deal/deals/core/presentation/image_placeholder.dart';

class HorizontalGameCardLoading extends StatelessWidget {
  const HorizontalGameCardLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: cardColor),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              ImagePlaceholder(ratio: 8 / 4, color: shimmerBaseColor),
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
