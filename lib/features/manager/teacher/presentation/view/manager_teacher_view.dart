import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';
import 'package:quran_tahfez/core/functions/open_dialog.dart';
import 'package:quran_tahfez/core/service/server_locator.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/add_teacher/add_teacher_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/add_teacher_dialog.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teacher_view_body.dart';

class ManagerTeachersView extends StatefulWidget {
  const ManagerTeachersView({super.key});

  @override
  State<ManagerTeachersView> createState() => _ManagerTeachersViewState();
}

class _ManagerTeachersViewState extends State<ManagerTeachersView> {
  List teachers = [];
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F6),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openDialog(
          context,
          widget: BlocProvider.value(
            value: AddTeacherCubit(
              teacherRepo: getIt.get<TeacherRepo>(),
            ),

            child: AddTeacherDialog(),
          ),
        ),
        backgroundColor: const Color(0xFF1E6553),
        foregroundColor: Colors.white,
        elevation: 2,
        icon: const Icon(Icons.add),
        label: const Text(
          'إضافة معلم',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: ManagerTeachersViewBody(),
      ),
    );
  }
}
