import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_deal/deals/core/infrastructure/game_info_remote_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const ProviderScope(child: TestApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  GameInfoRemoteRepository repository = GameInfoRemoteRepository(Dio());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final result = Future.microtask(() async {
      final response = await repository.getMultipleInfo([]);
      print(response);
      // return respo
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return const Scaffold(
          body: Center(
            child: Text("test"),
          ),
        );
      },
    );
  }
}
