import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class AddStudentHeader extends StatelessWidget {
  const AddStudentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.person_add_alt_1,
              color: Colors.white,
              size: 25,
            ),
          ),
          const Gap(13),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إضافة طالب جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(5),
                Text(
                  'أدخل معلومات الطالب لإضافته إلى النظام',
                  style: TextStyle(
                    color: Color(0xFFDDF0E9),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () => Navigator.pop(context),
            tooltip: 'إغلاق',
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
