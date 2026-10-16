import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/domain/storage_repo/storage_repo.dart';
import 'package:quran_tahfez/core/domain/student/repo/student_repo.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';
import 'package:quran_tahfez/core/functions/open_dialog.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/service/server_locator.dart';
import 'package:quran_tahfez/features/manager/student/presentation/manager/add_student/add_student_cubit.dart';
import 'package:quran_tahfez/features/manager/student/presentation/manager/get_students/get_students_cubit.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/add_student_dialog.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/manager_student_view_body.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/get_teachers/get_teachers_cubit.dart';

class ManagerStudentsView extends StatefulWidget {
  const ManagerStudentsView({super.key});

  @override
  State<ManagerStudentsView> createState() => _ManagerStudentsViewState();
}

class _ManagerStudentsViewState extends State<ManagerStudentsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetStudentsCubit(studentRepo: getIt.get<StudentRepo>())
            ..getStudents(managerId: PrefsHelper.getUser()!.id!),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "add_student",
          onPressed: () async => openDialog(
            context,
            widget: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: AddStudentCubit(
                    studentRepo: getIt.get<StudentRepo>(),
                    storageRepo: getIt.get<StorageRepo>(),
                  ),
                ),

                BlocProvider(
                  create: (context) =>
                      GetTeachersCubit(teacherRepo: getIt.get<TeacherRepo>())
                        ..getTeachers(managerId: PrefsHelper.getUser()!.id!),
                ),
              ],
              child: AddStudentDialog(),
            ),
          ),
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
      ),
    );
  }
}
