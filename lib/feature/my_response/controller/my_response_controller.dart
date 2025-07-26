// lib/feature/my_response/controller/my_response_controller.dart (example path)
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:guven_a/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/my_response/model/my_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart'; // For kDebugMode

class MyResponseController extends GetxController {
  var isLoadingPosts = true.obs;
  var posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyPosts();
  }

  Future<void> fetchMyPosts() async {
    isLoadingPosts.value = true;
    final String? token = await SharedPreferencesHelper.getAccessToken();

    if (token == null || token.isEmpty) {
      EasyLoading.showError("Authentication token not found. Please log in.");
      isLoadingPosts.value = false;
      return;
    }

    final url = Uri.parse('${Urls.baseUrl}/post/nearby'); // Adjust as needed

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );

      if (kDebugMode) {
        print("Fetch My Posts API Response: ${response.body}");
        print("Fetch My Posts API Status Code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final ApiResponse apiResponse = ApiResponse.fromJson(jsonResponse);

        if (apiResponse.success == true && apiResponse.data != null) {
          posts.value = apiResponse.data!;
          if (posts.isEmpty) {
            EasyLoading.showInfo("No posts found for your response.");
          }
        } else {
          EasyLoading.showError(
            apiResponse.message ?? "Failed to fetch posts.",
          );
          posts.clear();
        }
      } else {
        String errorMessage = "Failed to fetch posts: ${response.statusCode}";
        try {
          final Map<String, dynamic> errorData = json.decode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          if (kDebugMode) debugPrint("Failed to parse error response: $e");
        }
        EasyLoading.showError(errorMessage);
        posts.clear();
      }
    } catch (e) {
      EasyLoading.showError("Network error: ${e.toString()}");
      if (kDebugMode) {
        print("Exception fetching posts: $e");
      }
      posts.clear();
    } finally {
      isLoadingPosts.value = false;
    }
  }

  Future<void> rejectPost(String postId) async {
    EasyLoading.show(status: 'Rejecting...');
    try {
      final url = Uri.parse('${Urls.baseUrl}/post/reject/$postId');
      final String? token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token not found.");
        return;
      }
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Post rejected!");
        fetchMyPosts();
        posts.removeWhere((post) => post.id == postId);
      } else {
        final errorData = json.decode(response.body);
        EasyLoading.showError(errorData['message'] ?? "Failed to reject post.");
      }
    } catch (e) {
      EasyLoading.showError("Error rejecting post: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  // --- MODIFIED APPROVE POST METHOD ---
  Future<void> approvePost(String postId, String imagePath) async {
    EasyLoading.show(status: 'Approving and Uploading Image...');
    try {
      final url = Uri.parse(
        '${Urls.baseUrl}/post/accept/$postId',
      ); // Your API endpoint for approval
      final String? token = await SharedPreferencesHelper.getAccessToken();

      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token not found.");
        return;
      }

      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add authorization header
      request.headers['Authorization'] = token;

      // Attach the image file
      File imageFile = File(imagePath);
      if (await imageFile.exists()) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'photo', // This is the field name your backend expects for the image file
            imageFile.path,
            filename: basename(imageFile.path),
          ),
        );
      } else {
        EasyLoading.showError("Selected image file does not exist.");
        return;
      }

      // Send the request
      var response = await request.send();

      // Read the response
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Get.offAll(() => BottomNavbar());
        EasyLoading.showSuccess("Post approved and image uploaded!");
        // Get.snackbar(
        //   "Success",
        //   "Image send successfully",
        //   backgroundColor: Colors.pinkAccent,
        // );
      } else {
        final errorData = json.decode(responseBody);
        EasyLoading.showError(
          errorData['message'] ?? "Failed to approve post and upload image.",
        );
      }
    } catch (e) {
      EasyLoading.showError("Error approving post or uploading image: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
