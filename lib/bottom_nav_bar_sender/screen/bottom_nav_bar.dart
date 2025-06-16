import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/bottom_nav_bar_sender/controller/bottom_nav_bar_controller.dart';
import 'package:guven_a/core/const/nav_bar_images.dart';
import 'package:guven_a/feature/home/screen/home_screen.dart';
import 'package:guven_a/feature/my_request/screen/my_request.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({super.key});

  final BottomNavbarController controller = Get.put(BottomNavbarController());

  final List<Widget> pages = [
    HomeScreen(),
    MyRequestScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => pages[controller.currentIndex.value]),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), // Top-left corner radius
            topRight: Radius.circular(30), // Top-right corner radius
          ),
          border: Border.all(width: 1, color: Colors.black12),
        ),
        child: BottomAppBar(
          elevation: 5,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  index: 0,
                  activeImage: NavBarImages.acthome,
                  passiveImage: NavBarImages.passhome,
                ),
                _buildNavItem(
                  index: 1,
                  activeImage: NavBarImages.actReq,
                  passiveImage: NavBarImages.passReq,
                ),
                _buildNavItem(
                  index: 2,
                  activeImage: NavBarImages.actGlobeReq,
                  passiveImage: NavBarImages.passGlobeReq,
                ),
                _buildNavItem(
                  index: 3,
                  activeImage: NavBarImages.actResp,
                  passiveImage: NavBarImages.passResp,
                ),
                _buildNavItem(
                  index: 4,
                  activeImage: NavBarImages.actprofile,
                  passiveImage: NavBarImages.passprofile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build each bottom navigation item
  Widget _buildNavItem({
    required int index,
    required String activeImage,
    required String passiveImage,
  }) {
    return GestureDetector(
      onTap: () => controller.changeIndex(
        index,
      ), // Change the index when an item is tapped
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: 60, // Special size for index 2
          fit: BoxFit.cover,
        );
      }),
    );
  }
}
