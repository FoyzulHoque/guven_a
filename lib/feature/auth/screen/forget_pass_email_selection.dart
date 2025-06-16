import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_appbar.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/auth/controller/forget_pass_email_controller.dart';
import 'package:guven_a/feature/auth/screen/forget_pass_otp_verify.dart';

class ForgetPassEmailSelection extends StatelessWidget {
  ForgetPassEmailSelection({super.key});

  final ForgetPassEmailController controller = Get.put(
    ForgetPassEmailController(),
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomAppbar(
                title: "Forgot Password",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 15),
              Text(
                "Select which contact details should we use to reset your password",
                style: globalTextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.black12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFfD536AC).withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 30,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/message.png",
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Email:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFf6D7580),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: controller.emailController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.black12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFfD536AC),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              AppButton(
                onTap: () {
                  if (controller.emailController.text.isEmpty) {
                    Get.snackbar("Email empty", "Enter your email");
                  } else {
                    Get.to(
                      () => ForgetPassOtpVerify(
                        userEmail: controller.emailController.text.trim(),
                      ),
                    );
                  }
                },
                text: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
