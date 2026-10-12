import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/constants/assets/assets.dart';
import 'package:quran_tahfez/core/widgets/custom_text.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 94,
          height: 94,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3ED),
            borderRadius: BorderRadius.circular(27),
          ),
          child: Image.asset(
            Assets.assetsImagesLogo,
            fit: BoxFit.contain,
          ),
        ),

        const Gap(22),

        CustomText(
          text: 'مرحباً بعودتك',
          fontSize: 25,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),

        const Gap(8),

        Text(
          'سجّل دخولك لمتابعة حفظك ووردك القرآني',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}
