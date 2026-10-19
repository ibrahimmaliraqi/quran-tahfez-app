import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
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
          )..getStudents(managerId: int.parse(managerId)),
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
          final primary = AppColors.primary;

          return Scaffold(
            backgroundColor: const Color(0xFFF5F7F3),
            floatingActionButton: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: FloatingActionButton.extended(
                heroTag: 'add_student',
                onPressed: () {
                  final addStudentCubit = context.read<AddStudentCubit>();

                  openDialog(
                    context,
                    widget: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: addStudentCubit),
                        BlocProvider(
                          create: (_) => GetTeachersCubit(
                            teacherRepo: getIt.get<TeacherRepo>(),
                          )..getTeachers(managerId: int.parse(managerId)),
                        ),
                      ],
                      child: const AddStudentDialog(),
                    ),
                  );
                },
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                highlightElevation: 0,
                shape: const StadiumBorder(),
                icon: const Icon(Icons.add_rounded, size: 24),
                label: const Text(
                  'إضافة طالب',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                ),
              ),
            ),
            // Use `top: false` once this page's header extends under the
            // status bar (like TeachersHeader does); until then keep it true.
            body: SafeArea(
              child: BlocListener<AddStudentCubit, AddStudentState>(
                listener: (context, state) {
                  if (state is AddStudentSuccess) {
                    context.read<GetStudentsCubit>().getStudents(
                      managerId: int.parse(managerId),
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
