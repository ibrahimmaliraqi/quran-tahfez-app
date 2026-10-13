import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/teacher_card.dart';

class ManagerTeachersList extends StatelessWidget {
  final List<TeacherEntity> teachers;
  const ManagerTeachersList({super.key, required this.teachers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        return TeacherCard(teacher: teachers[index]);
      },
    );
  }
}
