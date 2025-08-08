import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:guven_a/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:guven_a/core/global_widegts/coustom_dialouge.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';

import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RxBool isPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var isGoogle = false.obs;
  var emailError = false.obs;
  var passError = false.obs;
  var emailErrorText = "".obs;
  var passErrorText = "".obs;
  var isRememberMeChecked = false.obs;
  RxString otp = ''.obs;

  // Set OTP value
  void setOtp(String otpValue) {
    otp.value = otpValue;
    if (kDebugMode) {
      print("OTP entered: $otpValue");
    }
  }

  // Toggle remember me option
  void toggleRememberMe(bool value) {
    isRememberMeChecked.value = value;
  }

  // Validate and create account
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
    String? fcmToken;

    // Fetch FCM Token
    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) debugPrint("FCM Token: $fcmToken");
    } catch (e) {
      if (kDebugMode) debugPrint("Error fetching FCM token: $e");
      fcmToken = null;
    }

    final String tokenToSend = fcmToken ?? "";

    // Register account via API
    try {
      EasyLoading.show(status: 'Creating account...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": passwordController.text,
          "fcmToken": tokenToSend,
        }),
      );

      if (kDebugMode) {
        debugPrint("Sign up response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Handle response success
        if (responseData['success'] == true && responseData['data'] != null) {
          final Map<String, dynamic> data = responseData['data'];
          final String? token = data['token'];

          if (token != null && token.isNotEmpty) {
            // Save token using SharedPreferencesHelper
            await SharedPreferencesHelper.saveToken(token);
            EasyLoading.showSuccess("Account created successfully!");

            // Navigate to the OTP screen or home screen
            Get.to(() => BottomNavbar());
          } else {
            EasyLoading.showError("Token not found in response.");
          }
        } else {
          EasyLoading.showError(
            responseData['message'] ?? 'Registration failed.',
          );
        }
      } else {
        // Handle non-200 status codes
        String errorMessage = "An error occurred: ${response.statusCode}";
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          if (kDebugMode) debugPrint("Failed to parse error response: $e");
        }
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError("An unexpected error occurred. Please try again.");
      if (kDebugMode) debugPrint("Exception during account creation: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Sign up with Google
  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      isGoogle.value = true;

      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) return; // User canceled the login

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        String fullName = userCredential.user!.displayName ?? "Unknown";
        String email = userCredential.user!.email ?? "No Email";
        print("Google Sign-In successful: $fullName, $email");
        // Fetch FCM Token
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken == null) {
          debugPrint("FCM token is null");
          return;
        }

        await socialSignUpApiCall(fullName, email, fcmToken);
      }
    } catch (e) {
      debugPrint("❌ Google Sign-In Error: $e");
    } finally {
      isGoogle.value = false;
    }
  }

  // Social sign-up API call
  Future<void> socialSignUpApiCall(
    String fullName,
    String email,
    String fcmToken,
  ) async {
    try {
      Map<String, String> requestBody = {
        'fullName': fullName,
        'email': email,
        'fcmToken': fcmToken,
      };

      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/users/social-sign-up"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true && responseData['data'] != null) {
          final Map<String, dynamic> data = responseData['data'];
          final String? token = data['token'];

          // Save the token and navigate
          if (token != null && token.isNotEmpty) {
            await SharedPreferencesHelper.saveToken(token);
            EasyLoading.showSuccess("Account created successfully!");
            Get.offAll(BottomNavbar());
          } else {
            EasyLoading.showError("Token not found.");
          }
        } else {
          EasyLoading.showError(responseData['message'] ?? 'Sign-Up failed.');
        }
      } else {
        EasyLoading.showError("Error: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("An error occurred: $e");
    }
  }
}
