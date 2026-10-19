import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/demo/demo_students.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';
import 'package:quran_tahfez/core/widgets/error_widget.dart';
import 'package:quran_tahfez/core/widgets/not_data_found.dart';
import 'package:quran_tahfez/features/manager/student/presentation/manager/get_students/get_students_cubit.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/students_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StudentsListViewBloc extends StatelessWidget {
  const StudentsListViewBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStudentsCubit, GetStudentsState>(
      builder: (context, state) {
        if (state is GetStudentsLoading) {
          return Skeletonizer(
            enabled: true,
            child: StudentListView(
              students: demoStudents,
            ),
          );
        }
        if (state is GetStudentsSuccess) {
          if (state.students.isEmpty) {
            return NoDataWidget(
              icon: Icons.people_outline,
              title: 'لا يوجد طلاب',
              subtitle: 'ما تمت إضافة أي طالب لحد الآن',
              actionIcon: Icons.person_add_alt_1,
              actionText: 'إضافة طالب',
              onAction: () {
                // افتح نافذة إضافة طالب
              },
              showAction: true,
            );
          }
          return StudentListView(
            students: state.students,
          );
        }
        if (state is GetStudentsFailure) {
          return FailureWidget(
            title: 'فشل تحميل الطلاب',
            message: state.message,
            onRetry: () {
              context.read<GetStudentsCubit>().getStudents(
                managerId: int.parse(PrefsHelper.getUser()!.id!),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
