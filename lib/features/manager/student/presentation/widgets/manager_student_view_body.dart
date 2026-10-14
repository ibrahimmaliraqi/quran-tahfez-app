import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/manager_student_view_header.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/number_of_student.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/student_list_view_bloc.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/teachers_search_field.dart';

class ManagerStudentViewBody extends StatefulWidget {
  const ManagerStudentViewBody({super.key});

  @override
  State<ManagerStudentViewBody> createState() => _ManagerStudentViewBodyState();
}

class _ManagerStudentViewBodyState extends State<ManagerStudentViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ManagerStudentViewHeader(),
        Gap(24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: TeachersSearchField(),
        ),
        Gap(15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: NumberOfStudent(
            count: 12.toString(),
            title: 'جميع الطلاب',
          ),
        ),
        Gap(15),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StudentsListViewBloc(),
          ),
        ),
      ],
    );
  }
}
