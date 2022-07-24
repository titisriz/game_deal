import 'package:flutter/material.dart';
import 'package:game_deal/deals/core/domain/deal_result.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_tag.dart';

class DealTile extends StatelessWidget {
  final DealResult dealResult;
  const DealTile({
    Key? key,
    required this.dealResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        // boxShadow: const [BoxShadow(color: Colors.black)],
        border: Border.all(color: Colors.black, width: 3),
        // borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade400,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      dealResult.thumb,
                      scale: 1,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  dealResult.title,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DealTag(tag: "Humble Bundle"),
              DealTag(
                tag: '-${dealResult.savings}%',
                color: Colors.green,
                fontSize: 15,
              ),
              DealTag(
                tag: '\$${dealResult.salePrice}',
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              DealTag(
                tag: '\$${dealResult.normalPrice}',
                fontSize: 15,
                textDecoration: TextDecoration.lineThrough,
                isLastPlacement: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
