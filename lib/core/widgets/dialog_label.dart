import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class DialogLabel extends StatelessWidget {
  const DialogLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.person_add_alt_1_rounded,
          color: AppColors.primary,
          size: 24,
        ),
        SizedBox(width: 10),
        Text(
          'إضافة معلم',
          style: TextStyle(
            color: Color(0xFF2D3748),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
