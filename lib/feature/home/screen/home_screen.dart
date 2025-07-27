import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/card_details/screen/card_details.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Image.asset(
//                       "assets/images/logo2.png",
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.contain,
//                     ),
//                     SizedBox(width: 20),
//                     Text(
//                       "Fizz me",
//                       style: globalTextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Spacer(),
//                     Image.asset(
//                       "assets/images/notification.png",
//                       width: 55,
//                       height: 55,
//                       fit: BoxFit.contain,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 50),
//                 CustomCard(
//                   title: "123 Main St",
//                   subtitle:
//                       "Photos should be-fallen live, not from the library",
//                   imageUrl: "assets/images/home_img1.png",
//                   onTap: () {
//                     Get.to(
//                       () => CardDetails(
//                         title: "123 Main St",
//                         subtitle:
//                             "Photos should be-fallen live, not from the library",
//                         imageUrl: "assets/images/home_img1.png",
//                       ),
//                     );
//                   },
//                 ),

//                 CustomCard(
//                   title: "123 Main St",
//                   subtitle:
//                       "Photos should be-fallen live, not from the library",
//                   imageUrl: "assets/images/home_img1.png",
//                   onTap: () {
//                     Get.to(
//                       () => CardDetails(
//                         title: "123 Main St",
//                         subtitle:
//                             "Photos should be-fallen live, not from the library",
//                         imageUrl: "assets/images/home_img1.png",
//                       ),
//                     );
//                   },
//                 ),
//                 CustomCard(
//                   title: "123 Main St",
//                   subtitle:
//                       "Photos should be-fallen live, not from the library",
//                   imageUrl: "assets/images/home_img1.png",
//                   onTap: () {
//                     Get.to(
//                       () => CardDetails(
//                         title: "123 Main St",
//                         subtitle:
//                             "Photos should be-fallen live, not from the library",
//                         imageUrl: "assets/images/home_img1.png",
//                       ),
//                     );
//                   },
//                 ),
//                 CustomCard(
//                   title: "123 Main St",
//                   subtitle:
//                       "Photos should be-fallen live, not from the library",
//                   imageUrl: "assets/images/home_img1.png",
//                   onTap: () {
//                     Get.to(
//                       () => CardDetails(
//                         title: "123 Main St",
//                         subtitle:
//                             "Photos should be-fallen live, not from the library",
//                         imageUrl: "assets/images/home_img1.png",
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CustomCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String imageUrl;
//   final VoidCallback onTap;

//   CustomCard({
//     required this.title,
//     required this.subtitle,
//     required this.imageUrl,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: onTap, // Handles the onTap event
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(width: 1, color: Colors.black12),
//         ),
//         margin: EdgeInsets.all(10),
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title text
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 5),
//             // Subtitle text
//             Text(
//               subtitle,
//               style: TextStyle(fontSize: 14, color: Colors.black38),
//             ),
//             SizedBox(height: 10),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(
//                 15,
//               ), // Rounded corners for image
//               child: Image.asset(
//                 imageUrl,
//                 width: size.width,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/feature/home/controller/home_controller.dart';
import 'package:guven_a/feature/home/model/home_model.dart';
import 'package:guven_a/feature/notification/screen/notification.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize your HomeController using Get.put().
    // It will automatically call onInit and fetch data.
    final HomeController homeController = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
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
                    "Fizz me",
                    style: globalTextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    // Added GestureDetector for notification icon
                    onTap: () {
                      Get.to(() => NotificationScreen());
                    },
                    child: Image.asset(
                      "assets/images/notification.png",
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Adjusted spacing
              Expanded(
                // Use Expanded to allow ListView.builder to take available height
                child: Obx(() {
                  if (homeController.isLoadingHomePosts.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (homeController.homePosts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No photo submissions found."),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => homeController.fetchHomePosts(),
                            child: Text("Refresh"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: homeController.homePosts.length,
                      itemBuilder: (context, index) {
                        final postData = homeController.homePosts[index];
                        return CustomCard(
                          postData: postData, // Pass the entire postData object
                          onTap: () {
                            // Pass relevant data to CardDetails
                            Get.to(
                              () => CardDetails(
                                title: postData.post.address,
                                subtitle: postData.post.details,
                                imageUrl: postData.photoUrl,
                                // You might want to pass the whole postData object here too if CardDetails needs more info
                                // postData: postData,
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final HomePostData postData;
  final VoidCallback onTap;

  CustomCard({super.key, required this.postData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black12),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postData.post.address,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              postData.post.details,
              style: TextStyle(fontSize: 14, color: Colors.black38),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: postData.photoUrl.isNotEmpty
                  ? Image.network(
                      postData.photoUrl,
                      width: size.width,
                      height: 200,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        // Calculate progress
                        double? progressValue;
                        if (loadingProgress.expectedTotalBytes != null) {
                          progressValue =
                              loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!;
                        }

                        return Center(
                          child: CircularProgressIndicator(
                            value:
                                progressValue, // Use the calculated progress value
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: size.width,
                          height: 200,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 50,
                          ),
                          alignment: Alignment.center,
                        );
                      },
                    )
                  : Container(
                      width: size.width,
                      height: 200,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                      alignment: Alignment.center,
                    ),
            ),
            // SizedBox(height: 10),
            // Text(
            //   'Submitted by: ${postData.user.email}',
            //   style: TextStyle(fontSize: 12, color: Colors.grey),
            // ),
            // Text(
            //   'Posted on: ${postData.createdAt.toLocal().toString().split('.')[0]}',
            //   style: TextStyle(fontSize: 12, color: Colors.grey),
            // ),
          ],
        ),
      ),
    );
  }
}
