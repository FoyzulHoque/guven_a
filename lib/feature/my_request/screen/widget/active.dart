import 'package:flutter/material.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/global_widegts/app_button2.dart';

class ActiveRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        ActiveCard(),
        ActiveCard(), // Add as many cards as needed
      ],
    );
  }
}

class ActiveCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Name and subtitle
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kristin Watson",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date: 11/10/2025",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Urgency: No",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Divider(height: 24),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: AppButton2(
                      onTap: () {},
                      text: "Edit",
                      borderColor: Color(0xFFD536AC),
                      buttonColor: Colors.white,
                      textColor: Color(0xFFD536AC),
                    ),
                  ),

                  SizedBox(width: 20),
                  Flexible(
                    child: AppButton(onTap: () {}, text: "Archived"),
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
