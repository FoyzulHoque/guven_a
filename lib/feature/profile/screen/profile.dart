import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/global_widegts/custom_textfield.dart';
import 'package:guven_a/core/services_class/local_service/shared_preferences_helper.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/auth/screen/login_screen.dart';
import 'package:guven_a/feature/capture_photo/controller/capture_photo_controller.dart';
import 'package:guven_a/feature/capture_photo/screen/capture_photo.dart';
import 'package:guven_a/feature/notification/screen/notification.dart';
import 'package:guven_a/feature/privacy/screen/privacy.dart';
import 'package:guven_a/feature/profile/controller/profile_controller.dart';
import 'package:guven_a/feature/request/controller/request_controller.dart';
import 'package:guven_a/feature/subscription/screen/subscription.dart';
import 'package:guven_a/feature/terms/screen/terms.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo2.png",
                      width: 45,
                      height: 45,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Profile",
                      style: globalTextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "adam.smith@yourdomain.com",
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/visibility.png",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Visibility",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(() {
                        return Switch(
                          value: controller.isOnline.value,
                          onChanged: controller.toggleStatus,
                          activeColor: Color(0xFFD536AC),
                        );
                      }),
                    ],
                  ),
                ),
                Divider(),
                StatusContainer(
                  imageUrl: "assets/images/notification2.png",
                  title: "Notification",
                  isIcon: true,
                  onTap: () {
                    Get.to(() => NotificationScreen());
                  },
                ),
                Divider(),
                StatusContainer(
                  imageUrl: "assets/images/privacy.png",
                  title: "Privacy policy",
                  isIcon: true,
                  onTap: () {
                    Get.to(() => Privacy());
                  },
                ),
                Divider(),
                StatusContainer(
                  imageUrl: "assets/images/privacy.png",
                  title: "Terms & condition",
                  isIcon: true,
                  onTap: () {
                    Get.to(() => Terms());
                  },
                ),
                Divider(),
                StatusContainer(
                  imageUrl: "assets/images/logout.png",
                  title: "Logout",
                  isIcon: false,
                  onTap: () async {
                    await SharedPreferencesHelper.clearAllData();
                    Get.to(() => LoginScreen());
                  },
                ),
                SizedBox(height: 30),
                GestureDetector(
                  child: Image.asset(
                    "assets/images/premium_banner.png",
                    width: MediaQuery.of(context).size.width,
                  ),
                  onTap: () => Get.to(() => SubscriptionScreen()),
                ),
                SizedBox(height: 30),
                AppButton(
                  onTap: () {
                    _showDeleteAccountBottomSheet(context);
                  },
                  text: "Delete account",
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/delete.png",
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(
                'Are you sure want to Delete account?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: AppButton2(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: "Edit",
                      textColor: Color(0xFfD536AC),
                      borderColor: Color(0xFFD536AC),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: AppButton(
                      onTap: () {
                        Get.snackbar("Deleted", "Account deleted successfully");
                        Get.to(() => LoginScreen());
                      },
                      text: "Delete",
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatusContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isIcon;
  VoidCallback onTap;

  StatusContainer({
    required this.imageUrl,
    required this.title,
    this.isIcon = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(imageUrl, height: 50, width: 50, fit: BoxFit.cover),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            isIcon
                ? Image.asset(
                    "assets/images/arrow_right.png",
                    height: 30,
                    width: 30,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
