import 'dart:convert';
import 'package:guven_a/core/global_widegts/coustom_dialouge.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:guven_a/feature/auth/screen/reset_pass_confirm.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SetPassController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch email from arguments
    email.value = Get.arguments?['email'] ?? '';
  }

  Future<void> setPassword(BuildContext context) async {
    final url = Uri.parse('${Urls.baseUrl}/auth/change-password');

    try {
      EasyLoading.show(status: '...');

      // Prepare headers with Authorization token

      // Prepare the request body
      final requestBody = {
        "email": email.value,
        "newPassword": passwordController.text,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (kDebugMode) {
        print(requestBody);
        print("Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        Get.to(() => ResetPassConfirm());
        //Get.offAll(() => LoginScreen());
        EasyLoading.showSuccess("Password updated successfully.");
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
}
