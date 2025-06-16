import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgetPassOtpVerifyController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  var otpError = false.obs;
  var otpErrorText = "".obs;

  // Future<void> verifyOtp(BuildContext context, String email) async {
  //   final url = Uri.parse('${Urls.baseUrl}/auth/verify-email');

  //   try {
  //     EasyLoading.show(status: 'OTP Sent...');

  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         "email": email,
  //         "otp": int.parse(otpController.text),
  //         "fcm": "",
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
  //           print("App Token is $token");
  //           if (token.isNotEmpty) {
  //             await SharedPreferencesHelper.saveToken(token);
  //             print("Shared Preference is----- ");
  //             String getToken =
  //                 SharedPreferencesHelper.getAccessToken().toString();
  //             print("Shared Prfreerence token is : $getToken");

  //             EasyLoading.showSuccess("Registration success");
  //             //  Get.offAll(() => UserType());
  //             Get.to(() => SuccessPage());
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

  // Future<void> resendOtp(BuildContext context, String email) async {
  //   final url = Uri.parse('${Urls.baseUrl}/auth/resend-otp');

  //   try {
  //     EasyLoading.show(status: 'OTP Resent...');

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
