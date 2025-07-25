import 'package:flutter/material.dart';
import 'package:guven_a/core/const/app_colors.dart';
import 'package:guven_a/core/style/global_text_style.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;

  const AppButton({
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
        width: screenWidth, // width of the button
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
