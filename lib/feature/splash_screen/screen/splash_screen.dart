import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFffffff),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset("assets/icons/splashlogo.png", width: screenWidth * .5),

            //SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
