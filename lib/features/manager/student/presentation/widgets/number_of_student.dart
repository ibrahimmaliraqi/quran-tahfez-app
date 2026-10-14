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
              color: Colors.black87,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 30,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Text(
            count,
            style: const TextStyle(
              color: AppColors.mint,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
