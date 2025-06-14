import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/const/app_colors.dart';
import 'package:guven_a/core/const/background_path.dart';
import 'package:guven_a/core/const/image_path.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/spp_textfield.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/auth/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BackgroundPath.primaryBackground),
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 60),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: AppColors.greyColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "back".tr,
                    style: globalTextStyle(
                      color: AppColors.grayColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: Column(
                children: [
                  Image.asset(ImagePath.authImage, width: 60),
                  SizedBox(height: 80),
                  AppTextField(
                    controller: controller.emailController,
                    hintText: "email".tr,
                  ),
                  AppTextField(
                    controller: controller.passwordController,
                    hintText: "password".tr,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "forgot_password".tr,
                        style: globalTextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          //Get.toNamed('/resetPasswordScreen');
                          if (controller.emailController.text.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please enter your email",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            controller.reset(context);
                          }
                        },
                        child: Text(
                          "reset".tr,
                          style: globalTextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 200),
                  AppButton(
                    onTap: () {
                      // Get.offAllNamed('/dashboardScreen');
                      controller.login(context);
                    },
                    text: "login".tr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
