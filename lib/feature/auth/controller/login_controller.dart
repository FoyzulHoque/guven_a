import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/bottom_nav_bar/screen/bottom_nav_bar.dart';

import 'package:http/http.dart' as http;

import '../../../core/global_widegts/coustom_dialouge.dart';
import '../../../core/network_caller/endpoints.dart';
import '../../../core/services_class/local_service/shared_preferences_helper.dart';

class LoginController extends GetxController {
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

  Future<void> login(BuildContext context) async {
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

    final url = Uri.parse('${Urls.baseUrl}/auth/login');

    try {
      String fcmToken = '';
      try {
        // Uncomment and implement if you're using Firebase Messaging
        // fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      } catch (e) {
        // Silently ignore FCM token errors
        debugPrint("FCM token error: $e");
      }

      if (kDebugMode) {
        debugPrint("FCM Token (if used): $fcmToken");
      }

      EasyLoading.show(status: 'Logging in...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": passwordController.text.trim(),
          // "fcmToken": fcmToken, // Uncomment if you're sending FCM token
        }),
      );

      if (kDebugMode) {
        print("Login Response: ${response.body}");
        print("Login Status Code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          if (responseData["data"] != null) {
            String token = responseData["data"]["token"] ?? "";
            String role =
                responseData["data"]["role"] ??
                "User"; // Default to "User" or handle based on your app logic

            if (token.isNotEmpty) {
              await SharedPreferencesHelper.saveToken(token);
              await SharedPreferencesHelper.saveUserType(role); // Save the role

              EasyLoading.showSuccess("Logged in successfully");

              // Now, navigate based on the role or to a common dashboard
              // Example: if (role == "Admin") { Get.offAllNamed('/adminDashboard'); } else { Get.offAllNamed('/dashboardScreen'); }
              Get.offAll(() => BottomNavbar()); // Your current navigation
            } else {
              EasyLoading.showError("Token is missing in response.");
            }
          } else {
            EasyLoading.showError("Invalid response: 'data' is null.");
          }
        } else {
          EasyLoading.showError(
            responseData["message"] ??
                "Login failed. Please check your credentials.",
          );
        }
      } else {
        // Handle non-200 status codes (e.g., 401 Unauthorized, 400 Bad Request)
        String errorMessage = "Login failed: ${response.statusCode}";
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
        print("Exception during login: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Future<void> reset(BuildContext context) async {
  //   String email = emailController.text.trim();

  //   // RegExp emailRegex for basic email validation
  //   RegExp emailRegex = RegExp(
  //     r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  //   );

  //   // Validate email
  //   if (email.isEmpty) {
  //     EasyLoading.showError("Please enter an email address.");
  //     return;
  //   } else if (!emailRegex.hasMatch(email)) {
  //     EasyLoading.showError("Invalid email format.");
  //     return;
  //   }
  //   final url = Uri.parse('${Urls.baseUrl}/auth/forgot-password');

  //   try {
  //     EasyLoading.show(status: 'Logging in...');

  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({"email": email}),
  //     );

  //     if (kDebugMode) {
  //       print("Response: ${response.body}");
  //     }

  //     if (response.statusCode == 200) {
  //       //final responseData = jsonDecode(response.body);

  //       EasyLoading.showSuccess("successfully sent");
  //       Get.to(() => ResetPassword(), arguments: {'email': email});
  //     } else {
  //       EasyLoading.showError("An error occurred: ${response.statusCode}");
  //       //Get.offAll(() => ResetPassword(), arguments: {'email': email});
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
