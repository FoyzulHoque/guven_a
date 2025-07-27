import 'package:get/get.dart';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:guven_a/feature/profile/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart'; // Make sure you have this package

class ProfileController extends GetxController {
  var isOnline = true.obs;
  var userEmail = ''.obs; // Observable to store the fetched email
  var isLoadingEmail = false.obs; // Observable to manage loading state

  @override
  void onInit() {
    fetchUserEmail(); // Call this when the controller is initialized
    super.onInit();
  }

  void toggleStatus(bool value) {
    isOnline.value = value;
    // You might want to make an API call here to update user's online status
    // on the backend if this toggle affects server-side visibility.
  }

  Future<void> fetchUserEmail() async {
    isLoadingEmail.value = true;
    EasyLoading.show(status: 'Fetching profile...');
    try {
      final url = Uri.parse(
        '${Urls.baseUrl}/users/get-me',
      ); // Adjust this endpoint if needed
      final String? token = await SharedPreferencesHelper.getAccessToken();

      if (token == null || token.isEmpty) {
        EasyLoading.showError(
          "Authentication token not found. Please log in again.",
        );
        isLoadingEmail.value = false;
        return;
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Include your authentication token
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final ProfileApiResponse profileResponse = ProfileApiResponse.fromJson(
          responseData,
        );

        if (profileResponse.success) {
          userEmail.value = profileResponse.data.email;
          EasyLoading.dismiss();
        } else {
          EasyLoading.showError(profileResponse.message);
        }
      } else {
        // Handle non-200 status codes
        final errorData = json.decode(response.body);
        EasyLoading.showError(
          errorData['message'] ??
              'Failed to fetch email: ${response.statusCode}',
        );
      }
    } catch (e) {
      EasyLoading.showError("Error fetching email: $e");
      print("Error fetching email: $e"); // Log the error for debugging
    } finally {
      isLoadingEmail.value = false;
      if (EasyLoading.isShow) {
        // Ensure EasyLoading is dismissed if it's still showing due to some error handling logic above
        EasyLoading.dismiss();
      }
    }
  }

  // Add methods for other profile actions like updating privacy settings, etc.
  // --- NEW METHOD: deleteAccount ---
  Future<void> deleteAccount() async {
    EasyLoading.show(status: 'Deleting account...');
    try {
      final url = Uri.parse('${Urls.baseUrl}/users/delete-account');
      final String? token = await SharedPreferencesHelper.getAccessToken();

      if (token == null || token.isEmpty) {
        EasyLoading.showError(
          "Authentication token not found. Cannot delete account.",
        );
        return;
      }

      final response = await http.delete(
        url,
        headers: {
          'Authorization': token, // Only the Authorization header
        },
      );

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Account deleted successfully!");
        // Clear local user data (e.g., token) after successful deletion
        await SharedPreferencesHelper.clearAllData();
        // Navigate to login screen and clear all previous routes
        Get.offAll(() => LoginScreen());
      } else {
        final errorData = json.decode(response.body);
        EasyLoading.showError(
          errorData['message'] ??
              "Failed to delete account: ${response.statusCode}",
        );
      }
    } catch (e) {
      EasyLoading.showError("Error deleting account: $e");
      print("Error deleting account: $e"); // Log the error for debugging
    } finally {
      EasyLoading.dismiss();
    }
  }
}
