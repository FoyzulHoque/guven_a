import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:guven_a/core/const/app_colors.dart';
import 'package:guven_a/core/const/background_path.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/auth/controller/register/register_controller.dart';


class ResgisterOtpScreen extends StatelessWidget {
  ResgisterOtpScreen({super.key});

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
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Icon(
                  //     Icons.arrow_back_ios_new_sharp,
                  //     color: AppColors.greyColor,
                  //   ),
                  // ),
                  SizedBox(width: 10),
                  Text(
                    "",
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
                  Text(
                    "OTP Verification",
                    style: globalTextStyle(
                      color: AppColors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 10),
                  SizedBox(
                    width: 230,
                    child: Text(
                      "otp_message".tr,
                      textAlign: TextAlign.center,
                      style: globalTextStyle(
                        color: AppColors.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  OtpTextField(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    focusedBorderColor: AppColors.primaryColor,
                    numberOfFields: 4,
                    borderColor: AppColors.greyColor,
                    fieldWidth: 66,
                    fieldHeight: 56,
                    borderRadius: BorderRadius.circular(18),
                    showFieldAsBox: true,
                    onSubmit: (otp) {
                      controller.setOtp(otp);
                      if (kDebugMode) {
                        print("Entered OTP: $otp");
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "didnt_get_otp".tr,
                        style: globalTextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          controller.resendOtp(context);
                        },
                        child: Text(
                          "resend".tr,
                          style: globalTextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 400),
                  AppButton(
                    onTap: () {
                      controller.verifyOtp(context);
                    },
                    text: "verify".tr,
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
