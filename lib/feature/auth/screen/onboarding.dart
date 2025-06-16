import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:guven_a/feature/auth/screen/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SizedBox(height: screenWidth * .3),
              Image.asset("assets/images/logo.png", width: screenWidth * .5),
              SizedBox(height: screenWidth * .3),
              Text(
                'Welcome to Fizz me !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              Spacer(),
              AppButton(
                onTap: () {
                  Get.to(() => RegisterScreen());
                },
                text: "Sign Up",
              ),
              SizedBox(height: 15),
              AppButton2(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                text: "Sign In",
                borderColor: Color(0xFFD536AC),
                textColor: Color(0xFFD536AC),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
