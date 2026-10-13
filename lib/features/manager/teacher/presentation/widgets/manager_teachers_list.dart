import 'package:flutter/material.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/teacher_card.dart';

class ManagerTeachersList extends StatelessWidget {
  const ManagerTeachersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return TeacherCard(teacher: {});
      },
    );
  }
}
