import 'package:flutter/material.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/style/global_text_style.dart';

// ignore: must_be_immutable
class CustomtextField extends StatelessWidget {
  final TextEditingController controller;
  String? hintText;
  bool? isObscure = true;
  CustomtextField(
      {super.key, required this.controller, this.isObscure, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        obscureText: isObscure ?? false,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          hintStyle: globalTextStyle(color: AppColors.grayColor),
          fillColor: const Color(0xffD9D9D9),
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.0)),
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
