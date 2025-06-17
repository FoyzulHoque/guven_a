import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/style/global_text_style.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;

  // Receive the image path as a parameter
  ImagePreviewScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    "Create request",
                    style: globalTextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "assets/images/remove.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(imagePath),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Spacer(),
              AppButton(
                onTap: () {
                  Get.snackbar(
                    "Success",
                    "Image send successfully",
                    backgroundColor: Colors.pinkAccent,
                  );
                },
                text: "Send",
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
