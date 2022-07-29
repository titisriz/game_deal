// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../../deals/core/domain/deal_result.dart' as _i5;
import '../../../deals/detail/presentation/deal_detail_page.dart' as _i2;
import '../main_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainPage());
    },
    DealDetailRoute.name: (routeData) {
      final args = routeData.argsAs<DealDetailRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.DealDetailPage(args.imageTag,
              key: args.key, dealResult: args.dealResult));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/main', fullMatch: true),
        _i3.RouteConfig(MainRoute.name, path: '/main'),
        _i3.RouteConfig(DealDetailRoute.name, path: '/detal')
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: '/main');

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.DealDetailPage]
class DealDetailRoute extends _i3.PageRouteInfo<DealDetailRouteArgs> {
  DealDetailRoute(
      {required String imageTag,
      _i4.Key? key,
      required _i5.DealResult dealResult})
      : super(DealDetailRoute.name,
            path: '/detal',
            args: DealDetailRouteArgs(
                imageTag: imageTag, key: key, dealResult: dealResult));

  static const String name = 'DealDetailRoute';
}

class DealDetailRouteArgs {
  const DealDetailRouteArgs(
      {required this.imageTag, this.key, required this.dealResult});

  final String imageTag;

  final _i4.Key? key;

  final _i5.DealResult dealResult;

  @override
  String toString() {
    return 'DealDetailRouteArgs{imageTag: $imageTag, key: $key, dealResult: $dealResult}';
  }
}
