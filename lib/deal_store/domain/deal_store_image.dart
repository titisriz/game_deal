import 'package:freezed_annotation/freezed_annotation.dart';
part 'deal_store_image.freezed.dart';

@freezed
class DealStoreImage with _$DealStoreImage {
  const DealStoreImage._();
  const factory DealStoreImage({
    required String banner,
    required String logo,
    required String icon,
  }) = _DealStoreImage;

  String get bannerUrl => 'https://www.cheapshark.com$banner';
  String get logoUrl => 'https://www.cheapshark.com$logo';
  String get iconUrl => 'https://www.cheapshark.com$icon';
}
