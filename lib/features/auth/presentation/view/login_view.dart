import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/constants/assets/assets.dart';
import 'package:quran_tahfez/core/widgets/custom_text.dart';
import 'package:quran_tahfez/core/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();

  @override
  void dispose() {
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F5),
      body: Stack(
        children: [
          // الخلفية العلوية
          Container(
            height: 340,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF287763),
                  Color(0xFF1E6553),
                  Color(0xFF164A3D),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -65,
                  right: -45,
                  child: _DecorativeCircle(size: 190),
                ),
                Positioned(
                  top: 125,
                  left: -75,
                  child: _DecorativeCircle(size: 160),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.18),
                                ),
                              ),
                              child: const Icon(
                                Icons.auto_stories_rounded,
                                color: Color(0xFFE5C783),
                                size: 27,
                              ),
                            ),
                            const Gap(12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'رِحْلَةُ الحِفْظ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(3),
                                Text(
                                  'رفيقك في حفظ القرآن الكريم',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          'أهلاً بك من جديد',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(10),
                        const Text(
                          'خطوة جديدة نحو إتقان كتاب الله',
                          style: TextStyle(
                            color: Color(0xFFE1EDE7),
                            fontSize: 15,
                          ),
                        ),
                        const Gap(28),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // محتوى تسجيل الدخول
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 205, 22, 24),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: const Color(0xFFE9EDE8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF164A3D).withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // الشعار
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

                        const Gap(30),

                        // الحقول
                        _FieldLabel(text: 'البريد الإلكتروني'),
                        const Gap(10),
                        CustomTextField(
                          icon: Icons.email_outlined,
                          title: 'أدخل بريدك الإلكتروني',
                          controller: emailCon,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const Gap(22),

                        _FieldLabel(text: 'كلمة المرور'),
                        const Gap(10),
                        CustomTextField(
                          icon: Icons.lock_outline_rounded,
                          title: 'أدخل كلمة المرور',
                          controller: passwordCon,
                        ),

                        const Gap(8),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              // الانتقال لاستعادة كلمة المرور
                            },
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
                        ),

                        const Gap(18),

                        // زر تسجيل الدخول
                        SizedBox(
                          width: double.infinity,
                          height: 57,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF287763),
                                  Color(0xFF1E6553),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF1E6553,
                                  ).withOpacity(0.22),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // دالة تسجيل الدخول
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Gap(10),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Gap(15),
                      ],
                    ),
                  ),

                  const Gap(25),

                  // عبارة ختامية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        size: 16,
                        color: Color(0xFFB99A55),
                      ),
                      const Gap(8),
                      Text(
                        'خيركم من تعلّم القرآن وعلّمه',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(8),
                      const Icon(
                        Icons.auto_awesome,
                        size: 16,
                        color: Color(0xFFB99A55),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// زخارف الخلفية
class _DecorativeCircle extends StatelessWidget {
  final double size;

  const _DecorativeCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
          width: 1.5,
        ),
        color: Colors.white.withOpacity(0.025),
      ),
    );
  }
}

// عنوان الحقل
class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF263D33),
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
