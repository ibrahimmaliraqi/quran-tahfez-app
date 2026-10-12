import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/core/widgets/custom_button.dart';
import 'package:quran_tahfez/core/widgets/custom_text_field.dart';
import 'package:quran_tahfez/features/auth/presentation/widgets/forget_password.dart';
import 'package:quran_tahfez/features/auth/presentation/widgets/login_header.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({
    super.key,
  });

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginHeader(),

        const Gap(30),

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

        ForgerPasswordWidget(),

        const Gap(18),

        CustomButton(
          title: 'تسجيل الدخول',
          onTap: () {},
        ),
        const Gap(15),
      ],
    );
  }
}

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
