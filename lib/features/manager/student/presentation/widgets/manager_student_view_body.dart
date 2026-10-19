import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/features/manager/student/presentation/manager/get_students/get_students_cubit.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/manager_student_view_header.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/number_of_student.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/student_list_view_bloc.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/teachers_search_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ManagerStudentViewBody extends StatefulWidget {
  const ManagerStudentViewBody({super.key});

  @override
  State<ManagerStudentViewBody> createState() => _ManagerStudentViewBodyState();
}

class _ManagerStudentViewBodyState extends State<ManagerStudentViewBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: Colors.white,
      onRefresh: () => context.read<GetStudentsCubit>().getStudents(
        managerId: int.parse(PrefsHelper.getUser()!.id!),
      ),
      child: Column(
        children: [
          ManagerStudentViewHeader(),
          Gap(24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: TeachersSearchField(),
          ),
          Gap(15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: BlocBuilder<GetStudentsCubit, GetStudentsState>(
              builder: (context, state) {
                if (state is GetStudentsSuccess) {
                  return NumberOfStudent(
                    count: state.students.length.toString(),
                    title: 'جميع الطلاب',
                  );
                }
                if (state is GetStudentsLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: NumberOfStudent(
                      count: 12.toString(),
                      title: 'جميع الطلاب',
                    ),
                  );
                }
                return NumberOfStudent(
                  count: 12.toString(),
                  title: 'جميع الطلاب',
                );
              },
            ),
          ),
          Gap(15),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StudentsListViewBloc(),
            ),
          ),
        ],
      ),
    );
  }
}
