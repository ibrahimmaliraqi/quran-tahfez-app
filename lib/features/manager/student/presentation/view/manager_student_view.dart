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

class ManagerStudentsView extends StatelessWidget {
  const ManagerStudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final managerId = PrefsHelper.getUser()!.id!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetStudentsCubit(
            studentRepo: getIt.get<StudentRepo>(),
          )..getStudents(managerId: managerId),
        ),
        BlocProvider(
          create: (_) => AddStudentCubit(
            studentRepo: getIt.get<StudentRepo>(),
            storageRepo: getIt.get<StorageRepo>(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              heroTag: 'add_student',
              onPressed: () {
                final addStudentCubit = context.read<AddStudentCubit>();

                openDialog(
                  context,
                  widget: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: addStudentCubit,
                      ),
                      BlocProvider(
                        create: (_) => GetTeachersCubit(
                          teacherRepo: getIt.get<TeacherRepo>(),
                        )..getTeachers(managerId: managerId),
                      ),
                    ],
                    child: const AddStudentDialog(),
                  ),
                );
              },
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
              child: BlocListener<AddStudentCubit, AddStudentState>(
                listener: (context, state) {
                  if (state is AddStudentSuccess) {
                    context.read<GetStudentsCubit>().getStudents(
                      managerId: managerId,
                    );
                  }
                },
                child: const ManagerStudentViewBody(),
              ),
            ),
          );
        },
      ),
    );
  }
}
