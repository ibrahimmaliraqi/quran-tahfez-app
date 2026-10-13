import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';
import 'package:quran_tahfez/core/functions/open_dialog.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/service/server_locator.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/add_teacher/add_teacher_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/delete_teacher/delete_teacher_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/get_teachers/get_teachers_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/add_teacher_dialog.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teacher_view_body.dart';

class ManagerTeachersView extends StatelessWidget {
  const ManagerTeachersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetTeachersCubit(
            teacherRepo: getIt.get<TeacherRepo>(),
          )..getTeachers(managerId: PrefsHelper.getUser()!.id!),
        ),
        BlocProvider(
          create: (context) =>
              DeleteTeacherCubit(teacherRepo: getIt.get<TeacherRepo>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F8F6),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                openDialog(
                  context,
                  widget: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) => AddTeacherCubit(
                          teacherRepo: getIt.get<TeacherRepo>(),
                        ),
                      ),
                      BlocProvider.value(
                        value: context.read<GetTeachersCubit>(),
                      ),
                    ],
                    child: const AddTeacherDialog(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF1E6553),
              foregroundColor: Colors.white,
              elevation: 2,
              icon: const Icon(Icons.add),
              label: const Text(
                'إضافة معلم',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            body: const SafeArea(
              child: ManagerTeachersViewBody(),
            ),
          );
        },
      ),
    );
  }
}
