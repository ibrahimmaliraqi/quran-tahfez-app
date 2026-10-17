import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/features/manager/student/presentation/manager/get_students/get_students_cubit.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/student_card.dart';

class StudentListView extends StatelessWidget {
  final List<StudentEntity> students;
  const StudentListView({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return StudentCard(
          student: students[index],
          showActions: true,
          onDelete: () => context.read<GetStudentsCubit>().deleteStudent(
            studentId: students[index].userId,
          ),
        );
      },
    );
  }
}
