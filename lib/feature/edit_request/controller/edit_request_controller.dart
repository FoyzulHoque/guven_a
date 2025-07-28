import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:guven_a/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:guven_a/core/global_widegts/coustom_dialouge.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditRequestController extends GetxController {
  var addressController = TextEditingController();
  var detaildsController = TextEditingController();
  var datePickerController = TextEditingController(); // For validity date
  var selectedOption =
      1.obs; // 1 means urgent (true), 2 means not urgent (false)
  var lat = 0.0.obs; // Store latitude as a reactive double
  var long = 0.0.obs; // Store longitude as a reactive double

  var address =
      ''.obs; // The source of the address string, assign to addressController

  // Add a reactive variable for the selected date (optional, for date picker)
  Rx<DateTime?> selectedValidityDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    // Assign initial address if available (e.g., from arguments)
    if (Get.arguments != null && Get.arguments['initialAddress'] != null) {
      address.value = Get.arguments['initialAddress'];
      addressController.text = address.value;
    }

    // Listen to changes in the 'address' RxString to update TextEditingController
    ever(address, (String newAddress) {
      if (addressController.text != newAddress) {
        addressController.text = newAddress;
        if (kDebugMode) {
          print('Address controller updated via ever: $newAddress');
        }
      }
    });

    // You might also want to set lat/long from arguments or a location service
    if (Get.arguments != null && Get.arguments['initialLat'] != null) {
      lat.value = Get.arguments['initialLat'];
    }
    if (Get.arguments != null && Get.arguments['initialLong'] != null) {
      long.value = Get.arguments['initialLong'];
    }
  }

  // --- Date Picker Logic ---
  void pickValidityDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedValidityDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ), // Up to 1 year from now
    );

    if (pickedDate != null) {
      selectedValidityDate.value = pickedDate;
      // Optionally update a TextEditingController if you display the date
      datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  // --- API Call Method ---
  Future<void> submitRequest(String id) async {
    // 1. Client-side validation
    if (addressController.text.isEmpty) {
      EasyLoading.showError("Please enter the address.");
      return;
    }
    if (detaildsController.text.isEmpty) {
      EasyLoading.showError("Please enter details for the request.");
      return;
    }
    // Basic check for coordinates (assuming 0.0, 0.0 is an invalid default)
    if (lat.value == 0.0 && long.value == 0.0) {
      EasyLoading.showError(
        "Please select a valid location (latitude/longitude).",
      );
      return;
    }
    if (selectedValidityDate.value == null) {
      EasyLoading.showError("Please select a validity date.");
      return;
    }

    // Ensure token is available for authenticated API call
    final String? token = await SharedPreferencesHelper.getAccessToken();
    if (token == null || token.isEmpty) {
      EasyLoading.showError(
        "Authentication token not found. Please log in again.",
      );
      // Optionally navigate to login screen: Get.offAll(() => LoginScreen());
      return;
    }

    final url = Uri.parse(
      '${Urls.baseUrl}/post/update-post/$id', // Adjust this endpoint to your actual request update API
    ); // Adjust this endpoint to your actual request creation API

    try {
      EasyLoading.show(status: 'Submitting request...');

      // Format validityDate to ISO 8601 string with 'Z' for UTC
      String? formattedValidityDate;
      if (selectedValidityDate.value != null) {
        formattedValidityDate = selectedValidityDate.value!
            .toUtc()
            .toIso8601String();
        // Example if API needs 'Z' without milliseconds:
        // formattedValidityDate = formattedValidityDate.replaceAll(RegExp(r'\.\d{3}Z$'), 'Z');
      }

      // Prepare the request body
      final requestBody = {
        "lat": lat.value,
        "long": long.value,
        "address": addressController.text, // Use the text from the controller
        "details": detaildsController.text,
        "urgent":
            selectedOption.value == 1, // This is already correctly implemented
        "validityDate": formattedValidityDate,
      };

      if (kDebugMode) {
        print("Request Body for API call: $requestBody");
      }

      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(requestBody),
      );

      if (kDebugMode) {
        print("API Response for Request: ${response.body}");
        print("API Status Code for Request: ${response.statusCode}");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          EasyLoading.showSuccess(
            responseData["message"] ?? "Request submitted successfully!",
          );
          // Clear form fields after successful submission
          // addressController.clear();
          // detaildsController.clear();
          // datePickerController.clear();
          // lat.value = 0.0;
          // long.value = 0.0;
          // address.value = '';
          // selectedValidityDate.value = null;
          // selectedOption.value = 1; // Reset to default (Yes, urgent)

          // Navigate to a confirmation screen or back to dashboard
          Get.offAll(() => BottomNavbar()); // Example navigation
        } else {
          EasyLoading.showError(
            responseData["message"] ?? "Failed to submit request.",
          );
        }
      } else {
        String errorMessage =
            "Failed to submit request: ${response.statusCode}";
        try {
          final Map<String, dynamic> errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          if (kDebugMode) debugPrint("Failed to parse error response: $e");
        }
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception during request submission: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  // // Remember to dispose controllers
  // @override
  // void onClose() {
  //   addressController.dispose();
  //   detaildsController.dispose();
  //   datePickerController.dispose();
  //   super.onClose();
  // }
}
