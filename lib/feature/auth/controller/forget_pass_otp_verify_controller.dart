import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/coustom_dialouge.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/feature/auth/screen/set_new_password.dart';
import 'package:http/http.dart' as http;

class ForgetPassOtpVerifyController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  var otpError = false.obs;
  var otpErrorText = "".obs;

  Future<void> verifyOtp(BuildContext context, String email) async {
    // Basic validation for OTP
    if (otpController.text.isEmpty) {
      EasyLoading.showError("Please enter the OTP.");
      return;
    }

    int? otpValue;
    try {
      otpValue = int.parse(otpController.text);
    } catch (e) {
      EasyLoading.showError("Invalid OTP format. Please enter numbers only.");
      return;
    }

    final url = Uri.parse('${Urls.baseUrl}/auth/otp-verify');

    try {
      EasyLoading.show(
        status: 'Verifying OTP...',
      ); // More appropriate loading message

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "otp": otpValue, // Use parsed integer OTP
        }),
      );

      if (kDebugMode) {
        print("OTP Verify Response: ${response.body}");
        print("OTP Verify Status: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          EasyLoading.showSuccess(
            responseData["message"] ?? "OTP verified successfully!",
          ); // Use API message or default

          // Navigate to the Set New Password screen
          // Pass the email so SetNewPassword screen knows which account to reset
          Get.to(() => SetNewPassword(), arguments: {'email': email});
        } else {
          // API returned 200 OK, but success was false (e.g., incorrect OTP)
          EasyLoading.showError(
            responseData["message"] ??
                "OTP verification failed. Please try again.",
          );
        }
      } else {
        // Handle non-200 status codes (e.g., 400 Bad Request, 500 Server Error)
        String errorMessage = "OTP verification failed: ${response.statusCode}";
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          // If response body is not valid JSON, use generic message
          if (kDebugMode) debugPrint("Failed to parse error response: $e");
        }
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      // Catch network errors or other exceptions
      showCustomDialog(
        context: context,
        icon: Icons.close,
        iconColor: Colors.red,
        title: "Error",
        message:
            "An unexpected error occurred. Please check your internet connection and try again.",
        buttonText: "Ok, Got it!",
        onButtonPressed: () {
          Navigator.pop(context);
        },
      );
      if (kDebugMode) {
        print("Exception during OTP verification: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> resendOtp(BuildContext context, String email) async {
    final url = Uri.parse('${Urls.baseUrl}/auth/resend-otp');

    try {
      EasyLoading.show(
        status: 'Resending OTP...',
      ); // More appropriate loading message

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if (kDebugMode) {
        print("Resend OTP Response: ${response.body}");
        print("Resend OTP Status: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(
          response.body,
        ); // Decode for message

        if (responseData["success"] == true) {
          EasyLoading.showSuccess(
            responseData["message"] ?? "OTP sent successfully!",
          );
        } else {
          EasyLoading.showError(
            responseData["message"] ??
                "Failed to resend OTP. Please try again.",
          );
        }
      } else {
        // Handle non-200 status codes
        String errorMessage = "Failed to resend OTP: ${response.statusCode}";
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          if (kDebugMode) debugPrint("Failed to parse error response: $e");
        }
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      showCustomDialog(
        context: context,
        icon: Icons.close,
        iconColor: Colors.red,
        title: "Error",
        message:
            "An unexpected error occurred. Please check your internet connection and try again.",
        buttonText: "Ok, Got it!",
        onButtonPressed: () {
          Navigator.pop(context);
        },
      );
      if (kDebugMode) {
        print("Exception during resend OTP: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
