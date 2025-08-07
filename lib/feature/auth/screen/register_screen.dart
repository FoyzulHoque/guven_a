import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:guven_a/core/global_widegts/custom_container.dart';
import 'package:guven_a/core/global_widegts/custom_passwordfield.dart';
import 'package:guven_a/core/global_widegts/custom_textfield.dart';
import 'package:guven_a/feature/auth/controller/register_controller.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/background_path.dart';
import '../../../core/const/image_path.dart';
import '../../../core/global_widegts/app_button.dart';
import '../../../core/global_widegts/spp_textfield.dart';
import '../../../core/style/global_text_style.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: size.width * 0.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Sign up for free',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),
              CustomTextField(
                title: "Email",
                controller: controller.emailController,
                focusedBorderColor: Color(0xFfD536AC),
              ),
              Obx(
                () => controller.emailError.value
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFfFEEFEF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              controller.emailErrorText.value,
                              style: globalTextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),

              CustomPasswordField(
                title: "Password",
                controller: controller.passwordController,
                focusedBorderColor: Color(0xFfD536AC),
              ),

              Obx(
                () => controller.passError.value
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFfFEEFEF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              controller.passErrorText.value,
                              style: globalTextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Row(
                children: [
                  Obx(() {
                    return Checkbox(
                      value: controller.isRememberMeChecked.value,
                      activeColor: Color(0xFfD536AC),
                      onChanged: (bool? value) {
                        if (value != null) {
                          controller.toggleRememberMe(value);
                        }
                      },
                    );
                  }),
                  Text('Remember Me', style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 15),
              AppButton(
                onTap: () {
                  controller.createAccount();
                  // // Check if passwords match
                  // if (controller.emailController.text.isEmpty) {
                  //   controller.emailErrorText.value = "Enter your email";
                  //   controller.emailError.value = true;
                  //   // Show an error message to the user
                  //   Get.snackbar(
                  //     "Empty",
                  //     "Enter your email",
                  //     snackPosition: SnackPosition.TOP,
                  //   );
                  // } else if (controller.passwordController.text ==
                  //     controller.confirmPasswordController.text) {
                  //   controller.passErrorText.value = "Enter your password";
                  //   controller.emailError.value = false;
                  //   controller.passError.value = true;
                  //   Get.snackbar(
                  //     "Password empty",
                  //     "Enter your password",
                  //     snackPosition: SnackPosition.TOP,
                  //     backgroundColor: Colors.redAccent,
                  //   );
                  // } else {
                  //   controller.emailError.value = false;
                  //   controller.passError.value = false;
                  // }
                },
                text: "Sign Up",
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text('or continue with', style: TextStyle(fontSize: 16)),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flexible(
                  //   child: CustomContainer(
                  //     imageUrl: "assets/images/facebook.png",
                  //     text: "Facebook",
                  //     onTap: () {},
                  //   ),
                  // ),
                  // SizedBox(width: 15),
                  CustomContainer(
                    imageUrl: "assets/images/google.png",
                    text: "Google",
                    onTap: () async {
                      await controller.signUpWithGoogle(context);
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: globalTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => Get.to(() => LoginScreen()),
                    child: Text(
                      "Sign In",
                      style: globalTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFfD536AC),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
