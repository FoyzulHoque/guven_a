import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/onboarding.dart';

import 'dart:async'; // Required for Timer
import 'package:get/get.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    // Wait for 3 seconds for the splash screen effect
    await Future.delayed(const Duration(seconds: 3));

    // Check if a token is available
    final String? token = await SharedPreferencesHelper.getAccessToken();

    if (kDebugMode) {
      print('Splash Screen: Token found? ${token != null}');
      if (token != null) {
        print('Token: $token');
      }
    }

    if (token != null && token.isNotEmpty) {
      // If token is available, navigate to the BottomNavBar (or main app screen)
      // Use Get.offAll to clear the navigation stack, so the user can't go back to splash/onboarding
      Get.offAll(
        () => BottomNavbar(),
      ); // Replace BottomNavBar() with your actual main logged-in screen
    } else {
      // If no token, navigate to the OnboardingScreen
      Get.offAll(() => OnboardingScreen());
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }
}
