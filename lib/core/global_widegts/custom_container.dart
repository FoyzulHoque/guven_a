import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String imageUrl;
  final String text;
  VoidCallback onTap;

  CustomContainer({
    required this.imageUrl,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xFfD536AC).withOpacity(0.1),
              spreadRadius: 8,
              blurRadius: 30,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, width: 35, height: 35),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
