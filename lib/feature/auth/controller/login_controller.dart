import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/feature/auth/screen/reset_password.dart';

import 'package:http/http.dart' as http;

import '../../../core/global_widegts/coustom_dialouge.dart';
import '../../../core/network_caller/endpoints.dart';
import '../../../core/services_class/local_service/shared_preferences_helper.dart';

class LoginController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgetpasswordEmailController = TextEditingController();
  final GlobalKey<FormState> logInGlobalKey = GlobalKey<FormState>();
  var isClicked = false.obs;

  void togglePasswordVisible() {
    isPasswordVisible.value = !isPasswordVisible.value;
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
        fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
      } catch (e) {
        // Silently ignore FCM token errors
        debugPrint("FCM token error: $e");
      }

      debugPrint("FCM Token: $fcmToken");

      EasyLoading.show(status: 'Logging in...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": passwordController.text.trim(),
          "fcmToken": fcmToken,
        }),
      );

      if (kDebugMode) {
        print("Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          if (responseData["data"] != null) {
            String token = responseData["data"]["token"] ?? "";

            if (token.isNotEmpty) {
              await SharedPreferencesHelper.saveToken(token);
              EasyLoading.showSuccess("Logged in successfully");
              Get.offAllNamed('/dashboardScreen');
            } else {
              EasyLoading.showError("Token is missing in response.");
            }
          } else {
            EasyLoading.showError("Invalid response: 'data' is null.");
          }
        } else {
          EasyLoading.showError(responseData["message"] ?? "Login failed.");
        }
      } else {
        EasyLoading.showError("An error occurred: ${response.statusCode}");
      }
    } catch (e) {
      showCustomDialog(
        // ignore: use_build_context_synchronously
        context: context,
        icon: Icons.close,
        iconColor: Colors.red,
        title: "Error",
        message: "An error occurred. Please try again.",
        buttonText: "Ok, Got it!",
        onButtonPressed: () {
          Navigator.pop(context);
        },
      );

      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> reset(BuildContext context) async {
    String email = emailController.text.trim();

    // RegExp emailRegex for basic email validation
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
    final url = Uri.parse('${Urls.baseUrl}/auth/forgot-password');

    try {
      EasyLoading.show(status: 'Logging in...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if (kDebugMode) {
        print("Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        //final responseData = jsonDecode(response.body);

        EasyLoading.showSuccess("successfully sent");
        Get.to(() => ResetPassword(), arguments: {'email': email});
      } else {
        EasyLoading.showError("An error occurred: ${response.statusCode}");
        //Get.offAll(() => ResetPassword(), arguments: {'email': email});
      }
    } catch (e) {
      showCustomDialog(
        // ignore: use_build_context_synchronously
        context: context,
        icon: Icons.close,
        iconColor: Colors.red,
        title: "Error",
        message: "An error occurred. Please try again.",
        buttonText: "Ok, Got it!",
        onButtonPressed: () {
          Navigator.pop(context);
        },
      );
      //EasyLoading.showError('An error occurred. Please try again.');
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
