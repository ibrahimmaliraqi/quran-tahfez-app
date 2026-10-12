import 'package:flutter/material.dart';
import 'package:quran_tahfez/features/auth/presentation/widgets/login_view_body.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LoginViewBody(),
      ),
    );
  }
}
