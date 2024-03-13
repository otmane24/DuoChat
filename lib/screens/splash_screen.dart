import 'package:duochat/assistant_methode/firestore_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../assistant_methode/size_config.dart';
import '../presentation/constants/strings.dart';
import '../routing/app_routing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FireStoreFunction().checkUser().then((value) => Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRouter.homeScreenRouter, (route) => false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
