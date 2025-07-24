import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/coustom_dialouge.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/feature/auth/screen/forget_pass_otp_verify.dart';
import 'package:http/http.dart' as http;

class ForgetPassEmailController extends GetxController {
  var emailController = TextEditingController();

  Future<void> sendOtp(BuildContext context) async {
    // Removed String email parameter, use emailController.text
    final String email = emailController.text.trim();

    // Basic email validation
    if (email.isEmpty) {
      EasyLoading.showError("Please enter your email address.");
      return;
    }
    // You might want a more robust email regex check here too, similar to login/register

    final url = Uri.parse('${Urls.baseUrl}/auth/forgot-password');

    try {
      EasyLoading.show(
        status: 'Sending OTP...',
      ); // More appropriate loading message

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if (kDebugMode) {
        print("Forgot Password OTP Response: ${response.body}");
        print("Forgot Password OTP Status: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          EasyLoading.showSuccess(
            responseData["message"] ?? "OTP sent successfully!",
          ); // Use API message or default

          // Navigate to the next screen, typically an OTP verification screen
          // Pass the email so the OTP screen knows which email to verify
          Get.to(() => ForgetPassOtpVerify(userEmail: email));
        } else {
          // API returned 200 OK, but success was false (e.g., email not found)
          EasyLoading.showError(
            responseData["message"] ?? "Failed to send OTP. Please try again.",
          );
        }
      } else {
        // Handle non-200 status codes (e.g., 400 Bad Request, 500 Server Error)
        String errorMessage = "Failed to send OTP: ${response.statusCode}";
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
        context:
            context, // `context` is now safe because we removed `BuildContext context` from args
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
        print("Exception during send OTP: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
