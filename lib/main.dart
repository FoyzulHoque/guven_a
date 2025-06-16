import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guven_a/route/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/const/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configEasyLoading();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Get.put(NotificationController());
  // Get.put(ChatController());
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? savedLocale = prefs.getString('locale');
  runApp(MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.grayColor
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  final String? savedLocale;
  @override
  const MyApp({super.key, this.savedLocale});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'karthikrenkaraj',
        getPages: AppRoute.routes,

        initialRoute: AppRoute.splashScreen,

        theme: ThemeData(scaffoldBackgroundColor: Color(0xffF1F1F3)),
        builder: EasyLoading.init(),
      ),
    );
  }
}
