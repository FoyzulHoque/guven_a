import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/style/global_text_style.dart';

// ignore: must_be_immutable
class CustomBotton extends StatelessWidget {
  final VoidCallback onTap;
  String title;
  Color? color;
  CustomBotton(
      {super.key, required this.onTap, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: globalTextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
