import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/teacher_card.dart';

class ManagerTeachersList extends StatelessWidget {
  final List<TeacherEntity> teachers;

  const ManagerTeachersList({super.key, required this.teachers});

  @override
  Widget build(BuildContext context) {
    if (teachers.isEmpty) return const _EmptyState();

    return ListView.builder(
      // Bottom padding keeps the last card clear of the floating button.
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 110),
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        final ms = 350 + math.min(index, 6) * 70;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: ms),
          curve: Curves.easeOutCubic,
          builder: (context, t, child) => Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(0, 18 * (1 - t)),
              child: child,
            ),
          ),
          child: TeacherCard(teacher: teachers[index]),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cast_for_education_outlined,
                size: 38,
                color: primary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'لا يوجد معلمون بعد',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F342B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'اضغط على «إضافة معلم» للبدء',
              style: TextStyle(fontSize: 13, color: Color(0xFF8A978F)),
            ),
          ],
        ),
      ),
    );
  }
}
