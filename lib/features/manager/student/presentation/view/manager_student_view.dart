import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/functions/open_dialog.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/add_student_dialog.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/manager_student_view_body.dart';

class ManagerStudentsView extends StatefulWidget {
  const ManagerStudentsView({super.key});

  @override
  State<ManagerStudentsView> createState() => _ManagerStudentsViewState();
}

class _ManagerStudentsViewState extends State<ManagerStudentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "add_student",
        onPressed: () async => openDialog(context, widget: AddStudentDialog()),
        icon: const Icon(Icons.add),
        label: const Text(
          'إضافة طالب',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF1E6553),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: ManagerStudentViewBody(),
      ),
    );
  }
}
