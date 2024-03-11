import 'package:duochat/screens/home/home.dart';
import 'package:flutter/material.dart';
import '../assistant_methode/size_config.dart';
import '../routing/router_generator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return const MaterialApp(
        locale: Locale('fr'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouterGenerator.getRouter,
        home: HomeScreen());
  }
}
