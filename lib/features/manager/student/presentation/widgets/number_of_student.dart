import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class NumberOfStudent extends StatelessWidget {
  final String title;
  final String count;
  const NumberOfStudent({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xFF2D3748),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          count,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
