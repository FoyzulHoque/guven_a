import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_appbar.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/auth/controller/forget_pass_otp_verify_controller.dart';
import 'package:guven_a/feature/auth/screen/set_new_password.dart';
import 'package:pinput/pinput.dart';

class ForgetPassOtpVerify extends StatefulWidget {
  final String userEmail;
  ForgetPassOtpVerify({super.key, required this.userEmail});

  @override
  _ForgetPassOtpVerifyState createState() => _ForgetPassOtpVerifyState();
}

class _ForgetPassOtpVerifyState extends State<ForgetPassOtpVerify> {
  final ForgetPassOtpVerifyController controller = Get.put(
    ForgetPassOtpVerifyController(),
  );
  Timer? _timer;
  int _secondsRemaining = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 120;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            CustomAppbar(
              title: "Forgot Password",
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Code has been send to ',
                    style: globalTextStyle(
                      fontSize: 14,
                      color: Color(0xFF4D5154),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: widget.userEmail,
                    style: globalTextStyle(
                      fontSize: 14,
                      color: Color(0xFfD536AC),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),

            // OTP PIN input
            Pinput(
              length: 4,
              controller: controller.otpController,
              defaultPinTheme: PinTheme(
                width: 50,
                height: 60,
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey), // 👉 grey initially
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 50,
                height: 60,
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFfD536AC),
                    width: 2,
                  ), // 👉 green when focused
                ),
              ),
              onCompleted: (pin) {
                print("Entered PIN: $pin");
              },
            ),
            SizedBox(height: 15),

            Obx(
              () => controller.otpError.value
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFfFEEFEF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Colors.red),
                          SizedBox(width: 10),
                          Text(
                            controller.otpErrorText.value,
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

            SizedBox(height: 10),

            // Countdown timer
            Text(
              _secondsRemaining > 0 ? _formatTime(_secondsRemaining) : "00.00",
              style: TextStyle(color: Color(0xFfD536AC)),
            ),

            Spacer(),
            AppButton(
              onTap: () {
                controller.verifyOtp(context, widget.userEmail);
              },
              text: "Verify",
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _startTimer();
                print("Resend OTP");
                //  controller.resendOtp(context, widget.userEmail);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn’t receive a code?",
                    style: globalTextStyle(
                      fontSize: 14,
                      color: Color(0xFF4D5154),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      controller.resendOtp(context, widget.userEmail);
                    },
                    child: Text(
                      "Resend Code",
                      style: globalTextStyle(
                        fontSize: 14,
                        color: Color(0xFfD536AC),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
