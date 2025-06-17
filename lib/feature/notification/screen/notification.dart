import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_appbar.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/global_widegts/custom_textfield.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/capture_photo/controller/capture_photo_controller.dart';
import 'package:guven_a/feature/capture_photo/screen/capture_photo.dart';
import 'package:guven_a/feature/notification/controller/notification_controller.dart';
import 'package:guven_a/feature/profile/controller/profile_controller.dart';
import 'package:guven_a/feature/request/controller/request_controller.dart';
import 'package:guven_a/feature/subscription/screen/subscription.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

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
                CustomAppbar(
                  title: "Notification",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20),
                _items1(),
                Divider(),
                _items2(),
                Divider(),
                _items3(),
                Divider(),
                _items4(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _items1() {
    return Container(
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
          // Image.asset(
          //   "assets/images/visibility.png",
          //   height: 50,
          //   width: 50,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              "Sound",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Obx(() {
            return Switch(
              value: controller.isSound.value,
              onChanged: controller.toggleSound,
              activeColor: Color(0xFFD536AC),
            );
          }),
        ],
      ),
    );
  }

  Widget _items2() {
    return Container(
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
          SizedBox(width: 16),
          Expanded(
            child: Text(
              "One notification per day",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Obx(() {
            return Switch(
              value: controller.isOne.value,
              onChanged: controller.toggleOneNotification,
              activeColor: Color(0xFFD536AC),
            );
          }),
        ],
      ),
    );
  }

  Widget _items3() {
    return Container(
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
          SizedBox(width: 16),
          Expanded(
            child: Text(
              "Several notification per day ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Obx(() {
            return Switch(
              value: controller.isSeverel.value,
              onChanged: controller.severelNotification,
              activeColor: Color(0xFFD536AC),
            );
          }),
        ],
      ),
    );
  }

  Widget _items4() {
    return Container(
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
          SizedBox(width: 16),
          Expanded(
            child: Text(
              "No notification",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Obx(() {
            return Switch(
              value: controller.isNotification.value,
              onChanged: controller.toggleNotification,
              activeColor: Color(0xFFD536AC),
            );
          }),
        ],
      ),
    );
  }
}
