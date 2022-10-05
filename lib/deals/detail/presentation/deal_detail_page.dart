import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/core/presentation/deal_list_tile.dart';
import 'package:game_deal/core/presentation/image_display.dart';
import 'package:game_deal/core/presentation/image_size_config.dart';
import 'package:game_deal/deal_store/shared/providers.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/deals/core/presentation/image_placeholder.dart';
import 'package:game_deal/deals/core/shared/providers.dart';

class DealDetailPage extends ConsumerStatefulWidget {
  const DealDetailPage(
    this.imageTag, {
    Key? key,
    required this.dealResult,
  }) : super(key: key);
  final DealResult dealResult;
  final String imageTag;

  @override
  ConsumerState<DealDetailPage> createState() => _DealDetailPageState();
}

class _DealDetailPageState extends ConsumerState<DealDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(dealDetailStateNotifier.notifier)
        .getData(widget.dealResult.gameID, widget.dealResult.storeID));
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(dealDetailStateNotifier);
    final stores = ref.watch(storeById(widget.dealResult.storeID));
    final imageUrl = stores?.images.logoUrl ?? '';
    final title = stores?.storeName ?? "Get Deals";
    final savings = widget.dealResult.dealSavings;
    final normalPrice = widget.dealResult.normalPrice;
    final dealPrice = widget.dealResult.dealSalePrice;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: DetailCustomClipper(),
              child: Hero(
                tag: widget.imageTag,
                child: ImageDisplay(
                  url: widget.dealResult.headerImgUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  ratio: detailHeroRatio,
                  errorWidget: ImageDisplay(
                    url: widget.dealResult.thumb,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    ratio: detailHeroRatio,
                    errorWidget: ImagePlaceholder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.dealResult.title,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Current Deal',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DealListTile(
                    imageUrl: imageUrl,
                    title: title,
                    savings: savings,
                    normalPrice: normalPrice,
                    dealPrice: dealPrice,
                    dealID: widget.dealResult.dealID,
                  ),
                  ...detail.when(
                    initial: () => [],
                    loadInProgress: () => [],
                    loadSuccess: (gameInfo) {
                      return [
                        if (gameInfo!.deals.isNotEmpty)
                          const SizedBox(
                            height: 10,
                          ),
                        if (gameInfo.deals.isNotEmpty &&
                            gameInfo.deals.length > 1)
                          Text(
                            'Price in Other Stores',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontSize: 15),
                          ),
                        if (gameInfo.deals.isNotEmpty &&
                            gameInfo.deals.length == 1)
                          Text(
                            'Price in Other Store',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontSize: 15),
                          ),
                        if (gameInfo.deals.isNotEmpty)
                          const SizedBox(
                            height: 5,
                          ),
                        ...gameInfo.deals.map(
                          (e) {
                            final store = ref.watch(storeById(e.storeID));
                            if (e.storeID == widget.dealResult.storeID) {
                              return Container();
                            }
                            return DealListTile(
                              imageUrl: store?.images.logoUrl ?? '',
                              title: store?.storeName ?? '',
                              savings: e.dealPercentage,
                              normalPrice: e.retailPrice,
                              dealPrice: e.price,
                              dealID: e.dealID,
                            );
                          },
                        ).toList(),
                      ];
                    },
                    loadFailure: (_) => [],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(15, size.height - 15),
      radius: const Radius.circular(15),
    );
    path.lineTo(size.width - 15, size.height - 15);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: const Radius.circular(15),
    );
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DetailCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30
      ..color = Colors.amber;
    final path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(15, size.height - 15),
      radius: const Radius.circular(15),
    );
    path.lineTo(size.width - 15, size.height - 15);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: const Radius.circular(15),
    );
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
