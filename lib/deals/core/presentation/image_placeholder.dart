import 'package:flutter/material.dart';
import 'package:game_deal/core/presentation/image_size_config.dart';

class ImagePlaceholder extends StatelessWidget {
  ImagePlaceholder({
    Key? key,
    this.ratio,
    this.color = Colors.black,
    this.child,
  }) : super(key: key);
  double? ratio;
  Color? color;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio ?? headerRatio,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: child,
      ),
    );
  }
}
