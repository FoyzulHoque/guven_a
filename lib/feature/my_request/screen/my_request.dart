import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/my_request/controller/my_request_controller.dart';
import 'package:guven_a/feature/my_request/model/active_model.dart';
import 'package:guven_a/feature/my_request/screen/widget/accept.dart';
import 'package:guven_a/feature/my_request/screen/widget/active.dart';
import 'package:guven_a/feature/my_request/screen/widget/archived.dart';

// class MyRequestScreen extends StatelessWidget {
//   final List<Tab> myTabs = <Tab>[
//     Tab(text: 'Active'),
//     Tab(text: 'Accepted'),
//     Tab(text: 'Archived'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: myTabs.length,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           automaticallyImplyLeading: false,
//           title: Row(
//             children: [
//               Image.asset(
//                 'assets/images/logo2.png',
//                 height: 35,
//               ), // Replace with your logo
//               SizedBox(width: 15),
//               Text(
//                 'My Requests',
//                 style: globalTextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           bottom: TabBar(
//             labelColor: Color(0xFfD536AC),
//             unselectedLabelColor: Colors.black,
//             tabs: myTabs,
//             indicatorColor: Color(0xFfD536AC),
//             indicatorSize: TabBarIndicatorSize.tab,
//           ),
//           elevation: 0,
//         ),
//         body: TabBarView(
//           children: [
//             ActiveRequestScreen(),
//             AcceptedRequestsWidget(),
//             ArchivedRequestsWidget(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_button.dart'; // Ensure correct paths for your widgets
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/style/global_text_style.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/style/global_text_style.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MyRequestsController myRequestsController = Get.put(
    MyRequestsController(),
  );

  // Map to store GoogleMapController instances for each request (keyed by request ID)
  final Map<String, GoogleMapController> _mapControllers = {}; // <--- NEW

  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'Active'),
    Tab(text: 'Accepted'),
    Tab(text: 'Archived'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: myTabs.length,
      vsync: this,
      initialIndex: myRequestsController.currentTabIndex.value,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        myRequestsController.changeTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Dispose all GoogleMapControllers to free up resources
    _mapControllers.forEach((key, controller) {
      // <--- NEW DISPOSE LOGIC
      controller.dispose();
    });
    _mapControllers.clear(); // <--- NEW
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/images/logo2.png', height: 35),
            const SizedBox(width: 15),
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
          controller: _tabController,
          labelColor: const Color(0xFfD536AC),
          unselectedLabelColor: Colors.black,
          tabs: myTabs,
          indicatorColor: const Color(0xFfD536AC),
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestListView(RequestStatus.ACTIVE),
          _buildRequestListView(RequestStatus.ACCEPTED),
          _buildRequestListView(RequestStatus.ARCHIVED),
        ],
      ),
    );
  }

  Widget _buildRequestListView(RequestStatus status) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      final isLoading = myRequestsController.isLoading(status);
      final requests = myRequestsController.getRequests(status);

      if (isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (requests.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No ${status.toApiString().toLowerCase()} requests found.",
                style: globalTextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () =>
                    myRequestsController.fetchRequestsByStatus(status),
                child: const Text("Refresh"),
              ),
            ],
          ),
        );
      } else {
        return RefreshIndicator(
          onRefresh: () => myRequestsController.refreshRequests(status),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];

              List<Widget> actionButtons;
              if (status == RequestStatus.ACTIVE) {
                actionButtons = [
                  Flexible(
                    child: AppButton2(
                      onTap: () {
                        /* TODO: Handle Edit for Active */
                      },
                      text: "Edit",
                      borderColor: const Color(0xFFD536AC),
                      buttonColor: Colors.white,
                      textColor: const Color(0xFFD536AC),
                    ),
                  ),
                  // const SizedBox(width: 20),
                  Flexible(
                    child: AppButton(
                      onTap: () {
                        /* TODO: Handle Archive for Active */
                      },
                      text: "Archived",
                    ),
                  ),
                ];
              } else if (status == RequestStatus.ACCEPTED) {
                actionButtons = [
                  Flexible(
                    child: AppButton(
                      onTap: () {
                        /* TODO: Handle Details for Accepted */
                      },
                      text: "Details",
                    ),
                  ),
                ];
              } else if (status == RequestStatus.ARCHIVED) {
                actionButtons = [
                  Image.asset(
                    "assets/images/edit_button.png",
                    width: size.width * 0.7,
                    height: 50,
                  ),
                ];
              } else {
                actionButtons = [];
              }

              return RequestCard(
                request: request,
                actionButtons: actionButtons,
                mapControllers: _mapControllers, // <--- Pass the mapControllers
              );
            },
          ),
        );
      }
    });
  }
}

// --- Reusable Request Card Widget (adjust if this is in a separate file) ---
// If RequestCard is in its own file (e.g., lib/widgets/request_card.dart),
// make sure to add the Maps_flutter import there.
// lib/widgets/request_card.dart (if separate)
// import 'package:Maps_flutter/Maps_flutter.dart'; // <--- Add this import
// import 'package:guven_a/models/active_request_model.dart'; // and other necessary imports

class RequestCard extends StatelessWidget {
  final ActiveRequest request;
  final List<Widget> actionButtons;
  final Map<String, GoogleMapController> mapControllers; // <--- NEW PARAMETER

  const RequestCard({
    super.key,
    required this.request,
    required this.actionButtons,
    required this.mapControllers, // <--- NEW PARAMETER
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.details,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      request.address ?? "No Address",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // --- Google Map Widget ---
              Container(
                // <--- REPLACED ClipRRect with Image.asset
                height: 150, // Adjust height as needed
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1.2,
                  ), // Your border
                  borderRadius: BorderRadius.circular(10), // Your border radius
                ),
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController mapController) {
                    mapControllers[request.id] =
                        mapController; // Store controller using request ID
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(
                            request.lat,
                            request.long,
                          ), // Use request's lat/long
                          zoom: 12.0,
                        ),
                      ),
                    );
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      request.lat,
                      request.long,
                    ), // Use request's lat/long
                    zoom: 12.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(
                        request.id,
                      ), // Use request ID for markerId
                      position: LatLng(
                        request.lat,
                        request.long,
                      ), // Use request's lat/long
                      infoWindow: InfoWindow(
                        title: request.address, // Use request's address
                        snippet: request.details, // Use request's details
                      ),
                    ),
                  },
                  zoomControlsEnabled: false,
                  scrollGesturesEnabled: false,
                ),
              ),

              // --- End Google Map Widget ---
              const SizedBox(height: 12),
              Text(
                request.details,
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date: ${request.validityDate.toLocal().toString().split(' ')[0]}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Urgency: ${request.urgent ? 'Yes' : 'No'}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: actionButtons
                    .map((button) => Flexible(child: button))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
