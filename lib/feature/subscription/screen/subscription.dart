import 'package:flutter/material.dart';
import 'package:guven_a/core/global_widegts/app_button.dart';
import 'package:guven_a/core/style/global_text_style.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 28),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Share more photos with FrizzMe Premium!',
              style: globalTextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Unlock unlimited sharing and extra features.',
              style: globalTextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Horizontal Scrollable Subscription Options
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSubscriptionCard('10 Credits price', '€4.99'),
                  const SizedBox(width: 16),
                  _buildSubscriptionCard('25 Credits', '€9.99'),
                  const SizedBox(width: 16),
                  _buildSubscriptionCard('50 Credits', '€14.99'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Unlock all features',
              style: globalTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildFeatureList(),
          ],
        ),
      ),
    );
  }

  // Helper method to build each subscription card
  Widget _buildSubscriptionCard(String title, String price) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFF2F2F7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: globalTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: globalTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          SubscriptionButton(onTap: () {}, text: "Buy"),
        ],
      ),
    );
  }

  // Helper method to build feature list
  Widget _buildFeatureList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/checkbox.png", width: 25, height: 25),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "You can send more photo requests.",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/checkbox.png", width: 25, height: 25),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "You can also send express photo requests.",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/checkbox.png", width: 25, height: 25),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "You can express request and , they earn \$0.25 per accepted photo.",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SubscriptionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;

  const SubscriptionButton({
    required this.onTap,
    required this.text,
    this.buttonColor = Colors.white,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFfFC7B2A), Color(0xFFD536AC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30), // corner radius
          border: Border.all(
            color: Colors.transparent, // border color, change if needed
            width: 2, // border width
          ),
        ),
        child: Text(
          text,
          style: globalTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
