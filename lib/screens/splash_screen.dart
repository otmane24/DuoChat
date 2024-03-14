import 'package:duochat/utils/firestore_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/size_config.dart';
import '../presentation/constants/strings.dart';
import '../routing/app_routing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Override initState to perform actions when the state is initialized
  @override
  void initState() {
    // Call the getUsers method from FireStoreFunction
    // This method retrieves the users from Firestore
    // Once the users are retrieved, it navigates to the home screen
    // The pushNamedAndRemoveUntil method removes all routes below the pushed route
    FireStoreFunction().getUsers().then((value) => Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRouter.homeScreenRouter, (route) => false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Center(
                child: SvgPicture.asset(
              '$svgsPath/logo.svg',
              width: 20 * SizeConfig.blockSizeVertical!,
              height: 20 * SizeConfig.blockSizeVertical!,
            )),
            Padding(
              padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical!),
              child: Image.asset(
                '$gifsPath/loading.gif',
                width: 10 * SizeConfig.blockSizeVertical!,
                height: 10 * SizeConfig.blockSizeVertical!,
                color: Colors.purple.withOpacity(.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
