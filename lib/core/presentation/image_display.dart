import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_deal/deals/core/presentation/image_placeholder.dart';
import 'package:shimmer/shimmer.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({
    Key? key,
    required this.url,
    required this.errorWidget,
    this.fit = BoxFit.fitWidth,
    required this.ratio,
    this.alignment,
  }) : super(key: key);

  final String url;
  final Widget errorWidget;
  final BoxFit? fit;
  final double ratio;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 500),
        imageUrl: url,
        cacheKey: url,
        filterQuality: FilterQuality.high,
        fit: fit,
        alignment: alignment ?? Alignment.center,
        progressIndicatorBuilder: (context, url, progress) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: ImagePlaceholder(ratio: ratio),
          );
        },
        errorWidget: (context, url, error) {
          return errorWidget;
        },
      ),
    );
  }
}
