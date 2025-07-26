import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';

import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/capture_photo/screen/capture_photo.dart';

import 'package:guven_a/feature/my_response/model/my_response_model.dart';

import 'package:intl/intl.dart';
import 'package:guven_a/feature/my_response/controller/my_response_controller.dart'; // <--- Correct import for

class MyResponse extends StatelessWidget {
  MyResponse({super.key});

  final MyResponseController myResponseController = Get.put(
    MyResponseController(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () => myResponseController.fetchMyPosts(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/logo2.png",
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "My Response",
                        style: globalTextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/images/notification.png",
                        width: 55,
                        height: 55,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Removed the single large map at the top
                  // as individual maps will be in each card.
                  Obx(() {
                    if (myResponseController.isLoadingPosts.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (myResponseController.posts.isEmpty) {
                      return Center(
                        child: Text(
                          "No posts found to display.",
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: myResponseController.posts.length,
                        itemBuilder: (context, index) {
                          final post = myResponseController.posts[index];
                          return RequestCard(
                            post: post,
                            controller: myResponseController,
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final Post post;
  final MyResponseController controller;

  const RequestCard({Key? key, required this.post, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedValidityDate = post.validityDate != null
        ? DateFormat('MMM dd, yyyy').format(post.validityDate!)
        : 'N/A';

    // Define a unique controller for each map
    final Map<String, GoogleMapController> mapControllers = {};

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.details ?? "No Deatils",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      post.address ?? "No Address",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              // Map for the specific post
              if (post.lat != null && post.long != null)
                Container(
                  height: 150, // Adjust height as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 1.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController mapController) {
                      mapControllers[post.id!] =
                          mapController; // Store controller
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(post.lat!, post.long!),
                            zoom: 12.0,
                          ),
                        ),
                      );
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(post.lat!, post.long!),
                      zoom: 12.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(post.id ?? post.address!),
                        position: LatLng(post.lat!, post.long!),
                        infoWindow: InfoWindow(
                          title: post.address,
                          snippet: post.details,
                        ),
                      ),
                    },
                    zoomControlsEnabled:
                        false, // Optional: disable zoom controls for smaller maps
                    scrollGesturesEnabled:
                        false, // Optional: disable map scrolling
                  ),
                ),
              // SizedBox(height: 12),
              // Text(
              //   post.details ?? "No details provided.",
              //   style: TextStyle(color: Colors.black87),
              // ),
              SizedBox(height: 12),
              Text(
                "Validity: $formattedValidityDate",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "Urgency: ${post.urgent == true ? 'Yes' : 'No'}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: AppButton2(
                      onTap: () {
                        if (post.id != null) {
                          controller.rejectPost(post.id!);
                        } else {
                          Get.snackbar(
                            'Error',
                            'Cannot reject post without an ID.',
                          );
                        }
                      },
                      text: "Reject",
                      borderColor: Color(0xFFD536AC),
                      buttonColor: Colors.white,
                      textColor: Color(0xFFD536AC),
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: AppButton(
                      onTap: () {
                        if (post.id != null) {
                          //controller.approvePost(post.id!);
                          // If approval leads to another screen, you might change this
                          Get.to(() => CapturePhoto(postId: post.id!));
                        } else {
                          Get.snackbar(
                            'Error',
                            'Cannot approve post without an ID.',
                          );
                        }
                      },
                      text: "Approve",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
