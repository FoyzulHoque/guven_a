import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';
import 'package:guven_a/core/global_widegts/custom_textfield.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/capture_photo/controller/capture_photo_controller.dart';
import 'package:guven_a/feature/capture_photo/screen/capture_photo.dart';
import 'package:guven_a/feature/request/controller/request_controller.dart';
import 'package:intl/intl.dart';

class MyResponse extends StatelessWidget {
  MyResponse({super.key});

  final RequestController controller = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate() async {
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (_picked != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(_picked);
        controller.datePickerController.text = formattedDate;
      }
    }

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
                RequestCard(),
                RequestCard(),
                RequestCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              // Name and subtitle
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Abonding Building",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Wilson Westervelt",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  15,
                ), // Rounded corners for image
                child: Image.asset(
                  "assets/images/map.png",
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 12),
              // Description
              Text(
                "DoctorQ is greatest medical online consultation app platform in this century.",
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(height: 12),

              // Date and Urgency
              Text(
                "Urgency: Yes",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Divider(height: 24),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: AppButton2(
                      onTap: () {},
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
                        Get.to(() => CapturePhoto());
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
