import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:game_deal/core/presentation/main_page.dart';
import 'package:game_deal/deals/detail/presentation/deal_detail_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: MainPage, path: '/main', initial: true),
    AutoRoute(
      page: DealDetailPage,
      path: '/detal',
    )
  ],
)
class $AppRouter {}
