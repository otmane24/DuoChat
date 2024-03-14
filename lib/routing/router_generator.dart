import 'package:duochat/screens/home.dart';
import 'package:flutter/material.dart';

import '../app/app.dart';
import '../screens/chat.dart';
import 'app_routing.dart';

class RouterGenerator {
  static Route<dynamic> getRouter(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouter.homeScreenRouter:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case AppRouter.chatScreenRouter:
        String documentId = (routeSettings.arguments as List)[0] as String;
        String userId = (routeSettings.arguments as List)[1] as String;
        String nameUser = (routeSettings.arguments as List)[2] as String;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(documentId: documentId, userId: userId, nameUser: nameUser),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MyApp(),
        );
    }
  }
}
