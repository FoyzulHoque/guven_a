import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/style/global_text_style.dart';

import '../const/icons_path.dart';
import '../const/image_path.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  CustomAppbar({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Image.asset("assets/images/back.png", width: 30),
        ),
        SizedBox(width: 15),
        Text(
          title,
          style: globalTextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
