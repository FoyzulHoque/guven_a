import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_appbar.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/feature/capture_photo2/screen/capture_photo2.dart';

class CapturePhoto extends StatelessWidget {
  const CapturePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(
                title: "Captured photo",
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/camera.png",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Reminder",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              // Subtitle text
              Text(
                "Photos should be-fallen live, not from the library",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Spacer(),
              AppButton(
                onTap: () {
                  Get.to(() => CustomCameraScreen());
                },
                text: "Take Photo",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
