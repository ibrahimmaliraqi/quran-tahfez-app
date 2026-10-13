import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teachers_header.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teachers_list_bloc.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/teachers_search_field.dart';

class ManagerTeachersViewBody extends StatelessWidget {
  const ManagerTeachersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeachersHeader(count: 2),
        Gap(24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TeachersSearchField(),
        ),
        Gap(15),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: ManagerTeachersListBloc(),
          ),
        ),
      ],
    );
  }
}
