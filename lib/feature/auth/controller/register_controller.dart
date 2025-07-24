import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:guven_a/core/global_widegts/coustom_dialouge.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';

import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var emailError = false.obs;
  var passError = false.obs;
  var emailErrorText = "".obs;
  var passErrorText = "".obs;
  var isRememberMeChecked = false.obs;

  void toggleRememberMe(bool value) {
    isRememberMeChecked.value = value;
  }

  RxString otp = ''.obs;

  // Set OTP value
  void setOtp(String otpValue) {
    otp.value = otpValue;
    if (kDebugMode) {
      print("OTP entered: $otpValue");
    }
  }

  Future<void> createAccount() async {
    String email = emailController.text.trim();
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );

    // Validate email
    if (email.isEmpty) {
      EasyLoading.showError("Please enter an email address.");
      return;
    } else if (!emailRegex.hasMatch(email)) {
      EasyLoading.showError("Invalid email format.");
      return;
    }

    final url = Uri.parse('${Urls.baseUrl}/users/register');

    //String? fcmToken;
    // try {
    //   fcmToken = await FirebaseMessaging.instance.getToken();
    //   if (kDebugMode) debugPrint("FCM Token: $fcmToken");
    // } catch (e) {
    //   if (kDebugMode) debugPrint("Error fetching FCM token: $e");
    //   fcmToken = null;
    // }

    //final String tokenToSend = fcmToken ?? "";

    try {
      EasyLoading.show(status: 'Creating account...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": passwordController.text,
          //"fcmToken": tokenToSend,
        }),
      );

      if (kDebugMode) {
        debugPrint("Sign up response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Check if the API response indicates success and contains data
        if (responseData['success'] == true && responseData['data'] != null) {
          final Map<String, dynamic> data = responseData['data'];
          final String? token = data['token'];

          if (token != null && token.isNotEmpty) {
            // Save the token using SharedPreferencesHelper
            await SharedPreferencesHelper.saveToken(token);
            EasyLoading.showSuccess("Account created successfully!");

            // Now you can navigate to the OTP screen or home screen
            Get.to(() => BottomNavbar());
          } else {
            EasyLoading.showError("Token not found in response.");
          }
        } else {
          // Handle API success: false or missing data
          final String message =
              responseData['message'] ?? 'Registration failed.';
          EasyLoading.showError(message);
        }
      } else {
        // Handle non-200 status codes
        String errorMessage = "An error occurred: ${response.statusCode}";
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
      EasyLoading.showError("An unexpected error occurred. Please try again.");
      if (kDebugMode) {
        debugPrint("Exception during account creation: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Future<void> verifyOtp(BuildContext context) async {
  //   final url = Uri.parse('${Urls.baseUrl}/auth/verify-otp');

  //   try {
  //     EasyLoading.show(status: 'Logging in...');

  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         "email": emailController.text.trim(),
  //         "otp": int.parse(otp.value),
  //       }),
  //     );

  //     if (kDebugMode) {
  //       print("Response: ${response.body}");
  //     }

  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess("successfully ");
  //       final responseData = jsonDecode(response.body);

  //       if (responseData["success"] == true) {
  //         if (responseData["data"] != null) {
  //           String token = responseData["data"]["token"] ?? "";

  //           if (token.isNotEmpty) {
  //             await SharedPreferencesHelper.saveToken(token);
  //             EasyLoading.showSuccess("Registration success");
  //             // Get.offAll(() => UserType());
  //           } else {
  //             EasyLoading.showError("Token is missing in response.");
  //           }
  //         } else {
  //           EasyLoading.showError("Invalid response: 'data' is null.");
  //         }
  //       } else {
  //         EasyLoading.showError(responseData["message"] ?? "Login failed.");
  //       }
  //     } else {
  //       EasyLoading.showError("An error occurred: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     showCustomDialog(
  //       // ignore: use_build_context_synchronously
  //       context: context,
  //       icon: Icons.close,
  //       iconColor: Colors.red,
  //       title: "Error",
  //       message: "An error occurred. Please try again.",
  //       buttonText: "Ok, Got it!",
  //       onButtonPressed: () {
  //         Navigator.pop(context);
  //       },
  //     );
  //     //EasyLoading.showError('An error occurred. Please try again.');
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  // Future<void> resendOtp(BuildContext context) async {
  //   final url = Uri.parse('${Urls.baseUrl}/auth/forgot-password');

  //   try {
  //     EasyLoading.show(status: 'Logging in...');

  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({"email": emailController.text.trim()}),
  //     );

  //     if (kDebugMode) {
  //       print("Response: ${response.body}");
  //     }

  //     if (response.statusCode == 200) {
  //       //final responseData = jsonDecode(response.body);

  //       EasyLoading.showSuccess("successfully sent");
  //     } else {
  //       EasyLoading.showError("An error occurred: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     showCustomDialog(
  //       // ignore: use_build_context_synchronously
  //       context: context,
  //       icon: Icons.close,
  //       iconColor: Colors.red,
  //       title: "Error",
  //       message: "An error occurred. Please try again.",
  //       buttonText: "Ok, Got it!",
  //       onButtonPressed: () {
  //         Navigator.pop(context);
  //       },
  //     );
  //     //EasyLoading.showError('An error occurred. Please try again.');
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
}
