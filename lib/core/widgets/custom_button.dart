import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final void Function()? onTap;
  final String title;
  const CustomButton({super.key, this.onTap, required this.title, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: 57,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
