import 'package:duochat/screens/home/home.dart';
import 'package:flutter/material.dart';

import '../app/app.dart';
import 'app_routing.dart';

class RouterGenerator {
  static Route<dynamic> getRouter(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouter.homeScreenRouter:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MyApp(),
        );
    }
  }
}
