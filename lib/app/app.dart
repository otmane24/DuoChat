// Import necessary packages
import 'package:duochat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import '../utils/size_config.dart';
import '../presentation/colors/color_manager.dart';
import '../routing/router_generator.dart';

// Define MyApp as a StatelessWidget
class MyApp extends StatelessWidget {
  // Constructor for MyApp
  const MyApp({super.key});

  // Override the build method
  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig get size of device
    SizeConfig().init(context);

    // Return MaterialApp to define the basic material design visual layout structure
    return MaterialApp(
      // Define the theme of the app
      theme: ThemeData(
        // Define the text theme for the app
        textTheme: TextTheme(
          // Define the style for medium titles
          titleMedium: TextStyle(
            color: ColorManager.black,
            fontSize: 2 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w600,
          ),
          // Define the style for large titles
          titleLarge: TextStyle(
            color: ColorManager.black,
            fontSize: 2.2 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.bold,
          ),
          // Define the style for small display text
          displaySmall: TextStyle(
            color: ColorManager.grey,
            fontSize: 1.2 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w400,
          ),
          // Define the style for medium display text
          displayMedium: TextStyle(
            color: ColorManager.black,
            fontSize: 1.6 * SizeConfig.blockSizeVertical!,
            fontWeight: FontWeight.w400,
          ),
        ),
        // Define the theme for input decorations
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
      // Set the locale of the app to English
      locale: const Locale('En'),
      // Disable the debug banner
      debugShowCheckedModeBanner: false,
      // Set the route generator for the app
      onGenerateRoute: RouterGenerator.getRouter,
      // Set the home screen of the app to SplashScreen
      home: const SplashScreen(),
    );
  }
}