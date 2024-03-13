import 'package:duochat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import '../assistant_methode/size_config.dart';
import '../presentation/colors/color_manager.dart';
import '../routing/router_generator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: ColorManager.black,
            fontSize: 2 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: ColorManager.black,
            fontSize: 2.2 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: ColorManager.grey,
            fontSize: 1.2 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            color: ColorManager.black,
            fontSize: 1.6 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w400,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorManager.black.withOpacity(.1),
          labelStyle: TextStyle(
            fontSize: 1.6 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            fontSize: 1.4 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 1.4 * SizeConfig.blockSizeVertical!,
              horizontal: 3.2 * SizeConfig.blockSizeHorizontal!),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: ColorManager.black.withOpacity(.1), width: .5),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: .5),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      locale: const Locale('En'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterGenerator.getRouter,
      home: const SplashScreen(),
    );
  }
}
