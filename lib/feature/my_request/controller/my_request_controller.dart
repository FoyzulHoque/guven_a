import 'package:get/get.dart';

class MyRequestController extends GetxController {
  var currentTabIndex = 0.obs; // Rx variable to hold the current tab index

  // Method to change the selected tab index
  void changeTab(int index) {
    currentTabIndex.value = index;
  }
}
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:guven_a/core/network_caller/endpoints.dart';
// import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
// import 'package:guven_a/feature/auth/screen/login_screen.dart';
// import 'package:guven_a/feature/my_request/model/active_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// // lib/enums/request_status.dart

// enum RequestStatus {
//   ACTIVE,
//   ACCEPTED,
//   ARCHIVED,
//   // Add other statuses like 'PENDING', 'REJECTED', 'COMPLETED', etc., if needed
// }

// extension RequestStatusExtension on RequestStatus {
//   String toApiString() {
//     return toString()
//         .split('.')
//         .last; // Converts enum to 'ACTIVE', 'ACCEPTED', etc.
//   }
// }

// class MyRequestsController extends GetxController {
//   // --- Tab Management ---
//   var currentTabIndex = 0.obs; // Rx variable to hold the current tab index

//   // Method to change the selected tab index and trigger data fetch if needed
//   void changeTab(int index) {
//     currentTabIndex.value = index;
//     _fetchRequestsForCurrentTab(index); // Trigger fetch based on new tab
//   }

//   // --- Data Management ---
//   final Map<RequestStatus, RxList<ActivePost>> _requestsMap = {
//     RequestStatus.ACTIVE: <ActivePost>[].obs,
//     RequestStatus.ACCEPTED: <ActivePost>[].obs,
//     RequestStatus.ARCHIVED: <ActivePost>[].obs,
//     // Add other statuses here if you have them in your API
//   };

//   final Map<RequestStatus, RxBool> _loadingMap = {
//     RequestStatus.ACTIVE: false.obs,
//     RequestStatus.ACCEPTED: false.obs,
//     RequestStatus.ARCHIVED: false.obs,
//   };

//   RxList<ActivePost> getRequests(RequestStatus status) => _requestsMap[status]!;
//   RxBool isLoading(RequestStatus status) => _loadingMap[status]!;

//   @override
//   void onInit() {
//     // Initial fetch for the first tab when the controller is created
//     _fetchRequestsForCurrentTab(currentTabIndex.value);
//     super.onInit();
//   }

//   // Private helper to map index to status and fetch
//   void _fetchRequestsForCurrentTab(int index) {
//     RequestStatus status;
//     switch (index) {
//       case 0:
//         status = RequestStatus.ACTIVE;
//         break;
//       case 1:
//         status = RequestStatus.ACCEPTED;
//         break;
//       case 2:
//         status = RequestStatus.ARCHIVED;
//         break;
//       default:
//         status = RequestStatus.ACTIVE; // Default case
//     }
//     // Only fetch if data for this tab hasn't been loaded yet or if forced refresh
//     // We also check !isLoading(status).value to prevent multiple concurrent fetches
//     if (getRequests(status).isEmpty && !isLoading(status).value) {
//       fetchRequestsByStatus(status);
//     }
//   }

//   Future<void> fetchRequestsByStatus(RequestStatus status) async {
//     // Prevent fetching if already loading for this status
//     if (isLoading(status).value) return;

//     isLoading(status).value = true;
//     EasyLoading.show(
//       status: 'Loading ${status.toApiString().toLowerCase()} requests...',
//     );

//     try {
//       final String statusString = status.toApiString();
//       final url = Uri.parse(
//         '${Urls.baseUrl}/post/my-posts-req?status=$statusString',
//       );
//       final String? token = await SharedPreferencesHelper.getAccessToken();

//       if (token == null || token.isEmpty) {
//         EasyLoading.showError("Authentication token not found. Please log in.");
//         Get.offAll(() => LoginScreen());
//         return;
//       }

//       final response = await http.get(
//         url,
//         headers: {'Content-Type': 'application/json', 'Authorization': token},
//       );

//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final ActivePostApiResponse apiResponse = ActivePostApiResponse.fromJson(
//         responseData,
//       );

//       if (apiResponse.success) {
//         getRequests(status).assignAll(apiResponse.data);
//         EasyLoading.dismiss();
//         print(
//           "Successfully fetched ${getRequests(status).length} ${statusString} requests.",
//         );
//       } else {
//         EasyLoading.showError(apiResponse.message);
//         print("API Error (${statusString} Requests): ${apiResponse.message}");
//       }
//     } catch (e) {
//       EasyLoading.showError(
//         "Error fetching ${status.toApiString().toLowerCase()} requests: $e",
//       );
//       print(
//         "Error fetching ${status.toApiString().toLowerCase()} requests: $e",
//       );
//     } finally {
//       isLoading(status).value = false;
//       if (EasyLoading.isShow) EasyLoading.dismiss();
//     }
//   }

//   Future<void> refreshRequests(RequestStatus status) async {
//     // Optionally clear existing data before refreshing for a clean slate
//     // getRequests(status).clear();
//     await fetchRequestsByStatus(status);
//   }
// }
