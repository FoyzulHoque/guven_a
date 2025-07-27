import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/network_caller/endpoints.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:guven_a/feature/my_request/model/active_model.dart';
import 'package:http/http.dart' as http;

// class MyRequestController extends GetxController {
//   var currentTabIndex = 0.obs; // Rx variable to hold the current tab index

//   // Method to change the selected tab index
//   void changeTab(int index) {
//     currentTabIndex.value = index;
//   }
// }
enum RequestStatus {
  ACTIVE,
  ACCEPTED,
  ARCHIVED,
  // Add other statuses if needed
}

extension RequestStatusExtension on RequestStatus {
  String toApiString() {
    return toString().split('.').last; // Converts enum to 'ACTIVE', 'ACCEPTED', etc.
  }
}
class MyRequestsController extends GetxController {
  // --- Tab Management ---
  var currentTabIndex = 0.obs; // Reactive variable to hold the current tab index

  // Method to change the selected tab index and trigger data fetch if needed
  void changeTab(int index) {
    currentTabIndex.value = index;
    // Trigger data fetch for the newly selected tab
    _fetchRequestsForCurrentTab(index);
  }

  // --- Data Management ---
  // A map to store lists of requests for each status (Active, Accepted, Archived)
  // Each list is an RxList to ensure reactivity in the UI.
  final Map<RequestStatus, RxList<ActiveRequest>> _requestsMap = {
    RequestStatus.ACTIVE: <ActiveRequest>[].obs,
    RequestStatus.ACCEPTED: <ActiveRequest>[].obs,
    RequestStatus.ARCHIVED: <ActiveRequest>[].obs,
    // Add other RequestStatus enums here if your API supports them
  };

  // A map to store the loading status for each request category.
  final Map<RequestStatus, RxBool> _loadingMap = {
    RequestStatus.ACTIVE: false.obs,
    RequestStatus.ACCEPTED: false.obs,
    RequestStatus.ARCHIVED: false.obs,
  };

  // Getter to provide read-only access to the list of requests for a given status.
  RxList<ActiveRequest> getRequests(RequestStatus status) => _requestsMap[status]!;

  // Getter to provide read-only access to the loading state for a given status.
  RxBool isLoading(RequestStatus status) => _loadingMap[status]!;

  @override
  void onInit() {
    super.onInit();
    // Fetch data for the initial tab (index 0, which is ACTIVE) when the controller is first initialized.
    _fetchRequestsForCurrentTab(currentTabIndex.value);
  }

  // Private helper method to map the tab index to a RequestStatus and initiate data fetching.
  void _fetchRequestsForCurrentTab(int index) {
    RequestStatus status;
    switch (index) {
      case 0:
        status = RequestStatus.ACTIVE;
        break;
      case 1:
        status = RequestStatus.ACCEPTED;
        break;
      case 2:
        status = RequestStatus.ARCHIVED;
        break;
      default:
        status = RequestStatus.ACTIVE; // Fallback to ACTIVE if index is unexpected
    }

    // Only fetch if data for this tab hasn't been loaded yet OR if it's not currently loading.
    // This prevents redundant API calls if the user switches back and forth quickly or if
    // data is already present.
    if (getRequests(status).isEmpty && !isLoading(status).value) {
      fetchRequestsByStatus(status);
    }
  }

  // Public method to fetch requests from the API based on the specified status.
  Future<void> fetchRequestsByStatus(RequestStatus status) async {
    // Prevent multiple concurrent fetch operations for the same status.
    if (isLoading(status).value) {
      print('Already loading ${status.toApiString()} requests. Skipping.');
      return;
    }

    isLoading(status).value = true; // Set loading state to true for this status
    EasyLoading.show(status: 'Loading ${status.toApiString().toLowerCase()} requests...');

    try {
      final String statusString = status.toApiString(); // Convert enum to API string (e.g., "ACTIVE")
      final url = Uri.parse('${Urls.baseUrl}/post/my-posts-req?status=$statusString');
      final String? token = await SharedPreferencesHelper.getAccessToken(); // Retrieve auth token

      if (token == null || token.isEmpty) {
        EasyLoading.showError("Authentication token not found. Please log in.");
        Get.offAll(() => LoginScreen()); // Redirect to login if token is missing
        return;
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Include authorization token
        },
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      // Use ActiveRequestApiResponse as it's designed to parse the consistent structure
      final ActiveRequestApiResponse apiResponse = ActiveRequestApiResponse.fromJson(responseData);

      if (apiResponse.success) {
        // Update the specific RxList for this status with the fetched data
        getRequests(status).assignAll(apiResponse.data);
        EasyLoading.dismiss(); // Dismiss loading indicator on success
        print("Successfully fetched ${getRequests(status).length} ${statusString} requests.");
      } else {
        EasyLoading.showError(apiResponse.message); // Show API error message
        print("API Error (${statusString} Requests): ${apiResponse.message}");
      }
    } catch (e) {
      EasyLoading.showError("Error fetching ${status.toApiString().toLowerCase()} requests: $e");
      print("Error fetching ${status.toApiString().toLowerCase()} requests: $e");
    } finally {
      isLoading(status).value = false; // Set loading state to false
      if (EasyLoading.isShow) EasyLoading.dismiss(); // Ensure loading indicator is dismissed
    }
  }

  // Method to refresh data for a specific status (e.g., used for Pull-to-Refresh in UI)
  Future<void> refreshRequests(RequestStatus status) async {
    // Optionally clear existing data before refreshing if you want a blank slate during refresh
    // getRequests(status).clear();
    await fetchRequestsByStatus(status);
  }
}
