import 'package:freezed_annotation/freezed_annotation.dart';

part 'page.freezed.dart';

@freezed
class Page<T> with _$Page<T> {
  const Page._();
  const factory Page(
    bool isNextPageAvailable,
    int totalPage,
    List<T> content,
  ) = _Page<T>;

  factory Page.empty() => const Page(false, 0, []);

  get isEmptyResult => totalPage == 0 && content.isEmpty;
}
