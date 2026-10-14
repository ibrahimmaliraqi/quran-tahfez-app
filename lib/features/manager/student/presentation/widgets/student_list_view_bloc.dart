import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/demo/demo_students.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/students_list_view.dart';

class StudentsListViewBloc extends StatelessWidget {
  const StudentsListViewBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentListView(
      students: demoStudents,
    );
  }
}
