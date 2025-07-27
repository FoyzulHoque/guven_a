import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/my_request/screen/widget/accept.dart';
import 'package:guven_a/feature/my_request/screen/widget/active.dart';
import 'package:guven_a/feature/my_request/screen/widget/archived.dart';

class MyRequestScreen extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Active'),
    Tab(text: 'Accepted'),
    Tab(text: 'Archived'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo2.png',
                height: 35,
              ), // Replace with your logo
              SizedBox(width: 15),
              Text(
                'My Requests',
                style: globalTextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            labelColor: Color(0xFfD536AC),
            unselectedLabelColor: Colors.black,
            tabs: myTabs,
            indicatorColor: Color(0xFfD536AC),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            ActiveRequestScreen(),
            AcceptedRequestsWidget(),
            ArchivedRequestsWidget(),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:guven_a/core/global_widegts/app_button.dart'; // Ensure these paths are correct
// import 'package:guven_a/core/global_widegts/app_button2.dart';
// import 'package:guven_a/core/style/global_text_style.dart';

// import 'package:guven_a/feature/my_request/controller/my_request_controller.dart';
// import 'package:guven_a/feature/my_request/model/active_model.dart';

// class MyRequestsScreen extends StatefulWidget {
//   const MyRequestsScreen({super.key});

//   @override
//   State<MyRequestsScreen> createState() => _MyRequestsScreenState();
// }

// class _MyRequestsScreenState extends State<MyRequestsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final MyRequestsController myRequestsController = Get.put(
//     MyRequestsController(),
//   );

//   final List<Tab> myTabs = const <Tab>[
//     Tab(text: 'Active'),
//     Tab(text: 'Accepted'),
//     Tab(text: 'Archived'),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: myTabs.length,
//       vsync: this,
//       initialIndex: myRequestsController.currentTabIndex.value,
//     );

//     // Listen to tab changes and update the controller's index and trigger fetch
//     _tabController.addListener(() {
//       if (!_tabController.indexIsChanging) {
//         myRequestsController.changeTab(_tabController.index);
//       }
//     });

//     // Initial fetch for the first tab (which is already done in controller's onInit)
//     // myRequestsController.fetchRequestsByStatus(RequestStatus.ACTIVE);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             Image.asset('assets/images/logo2.png', height: 35),
//             const SizedBox(width: 15),
//             Text(
//               'My Requests',
//               style: globalTextStyle(
//                 color: Colors.black,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         bottom: TabBar(
//           controller: _tabController, // Use the TabController
//           labelColor: const Color(0xFfD536AC),
//           unselectedLabelColor: Colors.black,
//           tabs: myTabs,
//           indicatorColor: const Color(0xFfD536AC),
//           indicatorSize: TabBarIndicatorSize.tab,
//         ),
//         elevation: 0,
//       ),
//       body: TabBarView(
//         controller: _tabController, // Use the TabController
//         children: [
//           _buildRequestListView(RequestStatus.ACTIVE),
//           _buildRequestListView(RequestStatus.ACCEPTED),
//           _buildRequestListView(RequestStatus.ARCHIVED),
//         ],
//       ),
//     );
//   }

//   // Helper widget to build the list view for each tab
//   Widget _buildRequestListView(RequestStatus status) {
//     final size = MediaQuery.of(context).size;
//     return Obx(() {
//       final isLoading = myRequestsController.isLoading(status);
//       final requests = myRequestsController.getRequests(status);

//       if (isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (requests.isEmpty) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "No ${status.toApiString().toLowerCase()} requests found.",
//                 style: globalTextStyle(color: Colors.grey),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () =>
//                     myRequestsController.fetchRequestsByStatus(status),
//                 child: const Text("Refresh"),
//               ),
//             ],
//           ),
//         );
//       } else {
//         return RefreshIndicator(
//           onRefresh: () => myRequestsController.refreshRequests(status),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: requests.length,
//             itemBuilder: (context, index) {
//               final request = requests[index];

//               // Determine buttons based on status
//               List<Widget> actionButtons;
//               if (status == RequestStatus.ACTIVE) {
//                 actionButtons = [
//                   Flexible(
//                     child: AppButton2(
//                       onTap: () {
//                         // Handle Edit action
//                       },
//                       text: "Edit",
//                       borderColor: const Color(0xFFD536AC),
//                       buttonColor: Colors.white,
//                       textColor: const Color(0xFFD536AC),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Flexible(
//                     child: AppButton(
//                       onTap: () {
//                         // Handle Archived action
//                       },
//                       text: "Archived",
//                     ),
//                   ),
//                 ];
//               } else if (status == RequestStatus.ACCEPTED) {
//                 actionButtons = [
//                   Flexible(
//                     child: AppButton(
//                       onTap: () {
//                         // Handle Details action for Accepted
//                       },
//                       text: "Details",
//                     ),
//                   ),
//                 ];
//               } else if (status == RequestStatus.ARCHIVED) {
//                 actionButtons = [
//                   // Assuming "edit_button.png" is a custom button widget, not just an image
//                   // You might want to wrap it in a GestureDetector or use an AppButton
//                   // For now, I'll keep the Image.asset, but a button is usually better for actions
//                   Image.asset(
//                     "assets/images/edit_button.png",
//                     width: size
//                         .width, // This will make it too wide, consider fixed width/height
//                     height: 50,
//                   ),
//                 ];
//               } else {
//                 actionButtons = []; // No buttons for unknown status
//               }

//               return RequestCard(
//                 request: request,
//                 actionButtons: actionButtons,
//               );
//             },
//           ),
//         );
//       }
//     });
//   }
// }

// // 2. Refactor RequestCard, RequestCard2, RequestCard3 into a single RequestCard
// class RequestCard extends StatelessWidget {
//   final ActivePost request;
//   final List<Widget> actionButtons; // To pass different buttons based on status

//   const RequestCard({
//     super.key,
//     required this.request,
//     required this.actionButtons,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust padding
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black12, width: 1),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // Name and subtitle (Not available in ActivePost model)
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // TODO: These values (Kristin Watson, Wilson Westervelt) are not in ActivePost model.
//                     // You might need to update your API to include user data or remove these.
//                     Text(
//                       "Kristin Watson", // Placeholder
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     Text(
//                       "Wilson Westervelt", // Placeholder
//                       style: TextStyle(color: Colors.grey[700]),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 // Assuming 'map.png' is a generic map image.
//                 // If the request has its own image URL, use Image.network(request.imageUrl) here.
//                 child: Image.asset(
//                   "assets/images/map.png",
//                   width: size.width,
//                   height: 200, // Fixed height for consistency
//                   fit: BoxFit.cover,
//                 ),
//               ),

//               const SizedBox(height: 12),
//               // Description
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   request.details, // Dynamic details
//                   style: const TextStyle(color: Colors.black87),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               // Date and Urgency
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Date: ${request.validityDate.toLocal().toString().split('T')[0]}", // Dynamic date
//                     style: const TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     "Urgency: ${request.urgent ? 'Yes' : 'No'}", // Dynamic urgency
//                     style: const TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//               const Divider(height: 24),
//               // Dynamic Buttons based on request status
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: actionButtons
//                     .map((button) => Flexible(child: button))
//                     .toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
