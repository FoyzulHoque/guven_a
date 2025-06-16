import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guven_a/core/style/global_text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
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
                    Image.asset(
                      "assets/images/notification.png",
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                CustomCard(
                  title: "123 Main St",
                  subtitle:
                      "Photos should be-fallen live, not from the library",
                  imageUrl: "assets/images/home_img1.png",
                  onTap: () {},
                ),

                CustomCard(
                  title: "123 Main St",
                  subtitle:
                      "Photos should be-fallen live, not from the library",
                  imageUrl: "assets/images/home_img1.png",
                  onTap: () {},
                ),
                CustomCard(
                  title: "123 Main St",
                  subtitle:
                      "Photos should be-fallen live, not from the library",
                  imageUrl: "assets/images/home_img1.png",
                  onTap: () {},
                ),
                CustomCard(
                  title: "123 Main St",
                  subtitle:
                      "Photos should be-fallen live, not from the library",
                  imageUrl: "assets/images/home_img1.png",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onTap;

  CustomCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap, // Handles the onTap event
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1, color: Colors.black12),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            // Subtitle text
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.black38),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                15,
              ), // Rounded corners for image
              child: Image.asset(
                imageUrl,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
