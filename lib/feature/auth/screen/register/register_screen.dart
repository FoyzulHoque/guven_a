import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guven_a/feature/auth/controller/register/register_controller.dart';


import '../../../../core/const/app_colors.dart';
import '../../../../core/const/background_path.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global_widegts/app_button.dart';
import '../../../../core/global_widegts/spp_textfield.dart';
import '../../../../core/style/global_text_style.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

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
                  AppTextField(
                    controller: controller.confirmPasswordController,
                    hintText: "confirm_password".tr,
                  ),
                  SizedBox(height: 150),
                  AppButton(
                    onTap: () {
                      // Check if passwords match
                      if (controller.passwordController.text ==
                          controller.confirmPasswordController.text) {
                        // Proceed with registration or navigate to the next page
                        //Get.to(() => UserType());
                        controller
                            .createAccount(); // Uncomment to create account
                      } else {
                        // Show an error message to the user
                        Get.snackbar(
                          "Error",
                          "Passwords do not match",
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    },
                    text: "Registration",
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
