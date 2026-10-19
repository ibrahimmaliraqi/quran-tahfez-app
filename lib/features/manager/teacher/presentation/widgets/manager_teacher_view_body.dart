import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/get_teachers/get_teachers_cubit.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teachers_header.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teachers_list_bloc.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/teachers_search_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ManagerTeachersViewBody extends StatelessWidget {
  const ManagerTeachersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: Colors.white,
      onRefresh: () => context.read<GetTeachersCubit>().getTeachers(
        managerId: int.parse(PrefsHelper.getUser()!.id!),
      ),
      child: Column(
        children: [
          BlocBuilder<GetTeachersCubit, GetTeachersState>(
            builder: (context, state) {
              if (state is GetTeachersLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: TeachersHeader(count: 2),
                );
              }
              if (state is GetTeachersSuccess) {
                return TeachersHeader(
                  count: state.teachers.length,
                );
              }
              return TeachersHeader(count: 2);
            },
          ),
          Gap(24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TeachersSearchField(),
          ),

          Expanded(
            child: ManagerTeachersListBloc(),
          ),
        ],
      ),
    );
  }
}
