import 'package:get/get.dart';
import 'package:guven_a/feature/splash_screen/screen/splash_screen.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String forgetPasswordScreen = '/forgetPasswordScreen';
  static String signupScreen = '/signupScreen';
  static String signinScreen = '/signinScreen';
  static String bottomNavbarScreen = '/bottomNavbarScreen';
  static String moodBoard = '/moodBoard';
  static String homeTracking = '/homeTracking';
  static String bottomNavBarCourier = '/bottomNavBarCourier';

  static String getSplashScreen() => splashScreen;
  static String getForgetPasswordScreen() => forgetPasswordScreen;
  static String getsignupScreen() => signupScreen;
  static String getsigninScreen() => signinScreen;
  static String getbottomNavbarScreen() => bottomNavbarScreen;
  static String getMoodBoard() => moodBoard;
  static String getHomeTracking() => homeTracking;
  static String getBottomNavBarCourier() => bottomNavBarCourier;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    // GetPage(name: moodBoard, page: () => MoodBoard()),
    // GetPage(name: homeTracking, page: () => CourierProfileScreen()),
    // GetPage(name: bottomNavBarCourier, page: () => BottomNavbarCourier()),
  ];
}
