import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/demo/teacher_demo.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/widgets/error_widget.dart';
import 'package:quran_tahfez/core/widgets/not_data_found.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/delete_teacher/delete_teacher_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/get_teachers/get_teachers_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teachers_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ManagerTeachersListBloc extends StatelessWidget {
  const ManagerTeachersListBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTeachersCubit, GetTeachersState>(
      builder: (context, state) {
        if (state is GetTeachersFailure) {
          return FailureWidget(
            message: state.errMessage,
            title: 'حدث خطأ',
            onRetry: () {
              context.read<GetTeachersCubit>().getTeachers(
                managerId: int.parse(PrefsHelper.getUser()!.id!),
              );
            },
          );
        } else if (state is GetTeachersSuccess) {
          if (state.teachers.isEmpty) {
            return NoDataWidget(
              icon: Icons.people_outline_rounded,
              title: 'لا يوجد معلمون حالياً',
              subtitle: 'يمكنك إضافة أول معلم إلى القائمة',
              showAction: true,
              actionIcon: Icons.person_add_alt_1,
              actionText: 'إضافة معلم',
              onAction: () {},
            );
          }
          return TeacherCardBlocListener(
            teachers: state.teachers,
          );
        } else if (state is GetTeachersLoading) {
          return Skeletonizer(
            enabled: true,
            child: ManagerTeachersList(
              teachers: demoTeachers,
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class TeacherCardBlocListener extends StatelessWidget {
  final List<TeacherEntity> teachers;
  const TeacherCardBlocListener({
    super.key,
    required this.teachers,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteTeacherCubit, DeleteTeacherState>(
      listener: (context, state) {
        if (state is DeleteTeacherFailure) {
          Snack.show(context, message: state.errMessage, isError: true);
        }
        if (state is DeleteTeacherSuccess) {
          context.read<GetTeachersCubit>().getTeachers(
            managerId: int.parse(PrefsHelper.getUser()!.id!),
          );
          Snack.show(context, message: state.message);
        }
      },
      child: ManagerTeachersList(
        teachers: teachers,
      ),
    );
  }
}
