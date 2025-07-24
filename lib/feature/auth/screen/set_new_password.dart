import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_appbar.dart';
import 'package:guven_a/core/global_widegts/custom_passwordfield.dart';
import 'package:guven_a/feature/auth/controller/set_pass_controller.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:guven_a/feature/auth/screen/reset_pass_confirm.dart';

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
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BackgroundPath.primaryBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  title: "Reset Password",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create a new password".tr,
                          style: globalTextStyle(
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomPasswordField2(
                          title: "",
                          hintText: "New password",
                          hintColor: Colors.black26,
                          controller: controller.passwordController,
                          focusedBorderColor: Color(0xFfD536AC),
                        ),

                        CustomPasswordField2(
                          title: "",
                          hintText: "Confirm password",
                          hintColor: Colors.black26,
                          controller: controller.confirmPasswordController,
                          focusedBorderColor: Color(0xFfD536AC),
                        ),

                        const Spacer(),
                        AppButton(
                          onTap: () {
                            controller.setPassword(context);
                            // // Check if passwords match
                            // if (controller.passwordController.text ==
                            //     controller.confirmPasswordController.text) {
                            //   Get.to(() => ResetPassConfirm());
                            // } else {
                            //   // Show an error message to the user
                            //   Get.snackbar(
                            //     "Error",
                            //     "Passwords do not match",
                            //     snackPosition: SnackPosition.TOP,
                            //   );
                            // }
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
      ),
    );
  }
}
