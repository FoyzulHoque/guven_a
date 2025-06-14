import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/set_new_password.dart';
import 'package:http/http.dart' as http;


class ForgotPassOtpController extends GetxController {
  var email = ''.obs;
  RxString otp = ''.obs; // Add this to store OTP

  @override
  void onInit() {
    super.onInit();
    // Fetch email from arguments
    email.value = Get.arguments?['email'] ?? '';
  }

  // Method to set the OTP entered by the user
  void setOtp(String otpValue) {
    otp.value = otpValue;
    if (kDebugMode) {
      print("OTP entered: $otpValue");
    }
  }

  // Method to verify OTP
  // Method to verify OTP
  Future<void> verifyOtp(BuildContext context) async {
    final url = Uri.parse('${Urls.baseUrl}/auth/verify-otp');

    try {
      EasyLoading.show(status: 'Verifying OTP...');

      // Ensure OTP is not empty
      if (otp.value.isEmpty) {
        EasyLoading.showError("Please enter the OTP.");
        return;
      }

      // Prepare the request body
      final requestBody = {"email": email.value, "otp": int.parse(otp.value)};

      // Print the body before sending
      if (kDebugMode) {
        print("Request Body: ${jsonEncode(requestBody)}");
      }

      // Send the request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (kDebugMode) {
        print("Response: ${response.body}");
      }

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response body
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          if (responseData['data'] != null) {
            String token = responseData['data']['token'] ?? "";

            if (token.isNotEmpty) {
              await SharedPreferencesHelper.saveToken(token);
              EasyLoading.showSuccess("Registration success");
              Get.to(() => SetNewPassword(), arguments: {'email': email.value});
            } else {
              EasyLoading.showError("Token is missing in response.");
            }
          } else {
            EasyLoading.showError("Invalid response: 'data' is null.");
          }
        } else {
          EasyLoading.showError(
            responseData["message"] ?? "OTP verification failed.",
          );
        }
      } else {
        EasyLoading.showError("An error occurred: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("An error occurred. Please try again.");
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Method to resend OTP
  Future<void> resendOtp(BuildContext context) async {
    final url = Uri.parse('${Urls.baseUrl}/auth/forgot-password');

    try {
      EasyLoading.show(status: 'Resending OTP...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email.value}),
      );

      if (kDebugMode) {
        print("Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("OTP sent successfully");
      } else {
        EasyLoading.showError("An error occurred: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("An error occurred. Please try again.");
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
