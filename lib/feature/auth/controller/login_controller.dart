import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guven_a/bottom_nav_bar/screen/bottom_nav_bar.dart';

import 'package:http/http.dart' as http;

import '../../../core/global_widegts/coustom_dialouge.dart';
import '../../../core/network_caller/endpoints.dart';
import '../../../core/services_class/local_service/shared_preferences_helper.dart';

class LoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RxBool isPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var emailError = false.obs;
  var passError = false.obs;
  var emailErrorText = "".obs;
  var passErrorText = "".obs;
  var isRememberMeChecked = false.obs;
  var isGoogle = false.obs;

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
        fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
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
          "fcmToken": fcmToken, // Uncomment if you're sending FCM token
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

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isGoogle.value = true;
      // EasyLoading.show(status: 'Signing in with Google...');
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // EasyLoading.dismiss();
        return; // User canceled
      }

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

        // ✅ Fetch FCM Token
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken == null) {
          debugPrint("❌ FCM token is null");

          return;
        }

        await socialSignUpApiCall(fullName, email, fcmToken);
      }
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
    } finally {
      isGoogle.value = false;
    }
  }

  Future<void> socialSignUpApiCall(
    String? fullName,
    String? email,
    String fcmToken,
  ) async {
    try {
      // Safely handle null values for fullName and email
      final String safeFullName = fullName?.isNotEmpty == true
          ? fullName!
          : "Unknown";
      final String safeEmail = email?.isNotEmpty == true ? email! : "No Email";

      // Prepare the request body
      Map<String, String> requestBody = {
        'fullName': safeFullName,
        'email': safeEmail,
        'fcmToken': fcmToken,
      };

      // Make the API request
      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/auth/social-SignUp"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      debugPrint("🔹 Request Body: $requestBody");
      debugPrint("🔹 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Parse the response data
        final responseData = jsonDecode(response.body);

        if (responseData["data"] != null) {
          String token = responseData["data"]["token"] ?? "";

          // Save the token using SharedPreferences
          await SharedPreferencesHelper.saveToken(token);
          debugPrint("Token Saved: $token");

          // Navigate to the appropriate route after a successful sign-in
          Get.offAll(BottomNavbar());
        } else {
          debugPrint("❌ API Error: No data in response");
          EasyLoading.showError("No data in response from the API.");
        }
      } else {
        // Handle non-200 status codes
        debugPrint("❌ API Error: ${response.statusCode}");
        EasyLoading.showError("API error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any exceptions that occur
      debugPrint("❌ Exception: $e");
      EasyLoading.showError("An error occurred: $e");
    }
  }
}
