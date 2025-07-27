import 'dart:convert';
import 'package:get/get.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:guven_a/feature/home/model/home_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart'; // Optional: for showing loading states

class HomeController extends GetxController {
  // Observable list to hold the fetched posts
  var homePosts = <HomePostData>[].obs;
  // Observable boolean to manage the loading state of the API call
  var isLoadingHomePosts = false.obs;

  @override
  void onInit() {
    // Automatically call fetchHomePosts when the controller is initialized
    fetchHomePosts();
    super.onInit();
  }

  // Method to fetch home posts from the API
  Future<void> fetchHomePosts() async {
    isLoadingHomePosts.value = true; // Set loading to true
    EasyLoading.show(
      status: 'Loading posts...',
    ); // Show loading indicator (optional)

    try {
      final url = Uri.parse(
        '${Urls.baseUrl}/post/my-home-posts',
      ); // Your API endpoint
      final String? token =
          await SharedPreferencesHelper.getAccessToken(); // Retrieve auth token

      if (token == null || token.isEmpty) {
        // Handle case where authentication token is missing
        EasyLoading.showError("Authentication token not found. Please log in.");
        Get.offAll(() => LoginScreen()); // Redirect to login
        return;
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Include the token in the headers
        },
      );

      // Decode the response body
      final Map<String, dynamic> responseData = json.decode(response.body);
      final HomePostApiResponse apiResponse = HomePostApiResponse.fromJson(
        responseData,
      );

      if (apiResponse.success) {
        // If API call was successful, update the observable list with fetched data
        homePosts.assignAll(apiResponse.data);
        EasyLoading.dismiss(); // Dismiss loading indicator
        print(
          "Successfully fetched ${homePosts.length} home posts.",
        ); // Log for debugging
      } else {
        // If API indicates failure, show the message from the API
        EasyLoading.showError(apiResponse.message);
        print("API Error: ${apiResponse.message}"); // Log for debugging
      }
    } catch (e) {
      // Catch any exceptions during the API call or parsing
      EasyLoading.showError("Failed to load posts: $e");
      print(
        "Error fetching home posts: $e",
      ); // Log the full error for debugging
    } finally {
      isLoadingHomePosts.value = false; // Set loading to false
      if (EasyLoading.isShow) {
        // Ensure EasyLoading is dismissed if it's still showing
        EasyLoading.dismiss();
      }
    }
  }

  // You can add more methods here, e.g., for refreshing posts,
  // filtering, or handling user interactions related to home posts.
  Future<void> refreshHomePosts() async {
    await fetchHomePosts(); // Simply re-call the fetch method
  }
}
