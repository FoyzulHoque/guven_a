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
    this.buttonColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: Text(
            text,
            style: globalTextStyle(
              color: textColor ?? Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
