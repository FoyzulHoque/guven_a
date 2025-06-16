import 'dart:convert';
import 'package:guven_a/core/global_widegts/coustom_dialouge.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SetPassController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var email = ''.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Fetch email from arguments
  //   email.value = Get.arguments?['email'] ?? '';
  // }

  // Future<void> setPassword(BuildContext context) async {
  //   final url = Uri.parse('${Urls.baseUrl}/auth/reset-password');

  //   try {
  //     EasyLoading.show(status: '...');

  //     // Retrieve the token from SharedPreferences using the helper class
  //     String? token = await SharedPreferencesHelper.getAccessToken();

  //     if (token == null || token.isEmpty) {
  //       EasyLoading.showError("Authentication token not found.");
  //       return;
  //     }

  //     // Prepare headers with Authorization token
  //     final headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': token, // Add token to headers
  //     };

  //     // Prepare the request body
  //     final requestBody = {
  //       "email": email.value,
  //       "password": passwordController.text,
  //     };

  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: jsonEncode(requestBody),
  //     );

  //     if (kDebugMode) {
  //       print("Response: ${response.body}");
  //     }

  //     if (response.statusCode == 200) {
  //       await SharedPreferencesHelper.clearAllData();
  //       Get.offAll(() => LoginScreen());
  //       EasyLoading.showSuccess("Password updated successfully.");
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
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
}
