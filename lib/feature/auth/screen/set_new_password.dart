import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/feature/auth/controller/set_pass_controller.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/background_path.dart';
import '../../../core/global_widegts/app_button.dart';
import '../../../core/global_widegts/spp_textfield.dart';
import '../../../core/style/global_text_style.dart';

class SetNewPassword extends StatelessWidget {
  SetNewPassword({super.key});

  final SetPassController controller = Get.put(SetPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BackgroundPath.primaryBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
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
                    const SizedBox(width: 10),
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

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "set_up_new_password".tr,
                        style: globalTextStyle(
                          color: AppColors.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        child: Text(
                          "dont_share_password".tr,
                          textAlign: TextAlign.center,
                          style: globalTextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      AppTextField(
                        controller: controller.passwordController,
                        hintText: "password".tr,
                      ),
                      AppTextField(
                        controller: controller.confirmPasswordController,
                        hintText: "confirm_password".tr,
                      ),
                      const Spacer(),
                      AppButton(
                        onTap: () {
                          // Check if passwords match
                          if (controller.passwordController.text ==
                              controller.confirmPasswordController.text) {
                            controller.setPassword(context);
                          } else {
                            // Show an error message to the user
                            Get.snackbar(
                              "Error",
                              "Passwords do not match",
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
                        text: "save".tr,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
