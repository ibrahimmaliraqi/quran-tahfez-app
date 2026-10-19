import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/domain/storage_repo/storage_repo.dart';
import 'package:quran_tahfez/core/domain/teacher/repo/teacher_repo.dart';
import 'package:quran_tahfez/core/functions/open_dialog.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/service/server_locator.dart';
import 'package:quran_tahfez/features/auth/domain/repositories/auth_repo.dart';
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
                heroTag: "add_teacher",
                onPressed: () {
                  openDialog(
                    context,
                    widget: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => AddTeacherCubit(
                            authRepo: getIt.get<AuthRepo>(),
                            teacherRepo: getIt.get<TeacherRepo>(),
                            storageRepo: getIt.get<StorageRepo>(),
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
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                highlightElevation: 0,
                shape: const StadiumBorder(),
                icon: const Icon(Icons.add_rounded, size: 24),
                label: const Text(
                  'إضافة معلم',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                ),
              ),
            ),
            // top: false so the emerald header extends under the status bar
            // (TeachersHeader adds the top inset itself).
            body: SafeArea(
              top: false,
              child: BlocBuilder<DeleteTeacherCubit, DeleteTeacherState>(
                builder: (context, state) {
                  return ModalProgressHUD(
                    inAsyncCall: state is DeleteTeacherLoading,
                    child: ManagerTeachersViewBody(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
