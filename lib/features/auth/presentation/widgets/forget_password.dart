import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class ForgerPasswordWidget extends StatelessWidget {
  const ForgerPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
        ),
        child: const Text(
          'نسيت كلمة المرور؟',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
