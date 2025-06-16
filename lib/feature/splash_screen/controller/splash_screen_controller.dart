import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/onboarding.dart';

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    Timer(const Duration(seconds: 3), () async {
      Get.to(() => OnboardingScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }
}
