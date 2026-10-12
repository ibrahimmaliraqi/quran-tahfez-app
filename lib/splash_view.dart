import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/router/app_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const Color backgroundColor = Color(0xFFF9F9F8);
  static const Color goldColor = Color(0xFFD4AF66);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        GoRouter.of(context).pushReplacement(AppRouter.login);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF267763), Color(0xFF1E6553), Color(0xFF164A3D)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Quran Icon
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: SplashView.goldColor.withOpacity(0.7),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  size: 85,
                  color: SplashView.goldColor,
                ),
              ),

              const SizedBox(height: 35),

              // App Name
              const Text(
                'حِفْظُ القُرْآنِ الكَرِيم',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: SplashView.backgroundColor,
                  height: 1.8,
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              const Text(
                'رِحْلَتُكَ مَعَ كِتَابِ الله',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: SplashView.goldColor,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 30),

              // Decorative Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 1,
                    color: SplashView.goldColor.withOpacity(0.7),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.auto_awesome,
                      color: SplashView.goldColor,
                      size: 18,
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 1,
                    color: SplashView.goldColor.withOpacity(0.7),
                  ),
                ],
              ),

              const Spacer(),

              // Loading Indicator
              const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: SplashView.goldColor,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'بِالعِلْمِ نَرْتَقِي وَبِالقُرْآنِ نَحْيَا',
                style: TextStyle(
                  fontSize: 13,
                  color: SplashView.backgroundColor,
                ),
              ),

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
