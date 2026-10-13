import 'package:flutter/material.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/widgets/manager_teachers_list.dart';

class ManagerTeachersListBloc extends StatelessWidget {
  const ManagerTeachersListBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return ManagerTeachersList();
  }
}
//  NoDataWidget(
//             icon: Icons.people_outline_rounded,
//             title: 'لا يوجد معلمون حالياً',
//             subtitle: 'يمكنك إضافة أول معلم إلى القائمة',
//             showAction: true,
//             actionIcon: Icons.person_add_alt_1,
//             actionText: 'إضافة معلم',
//             onAction: () {},
//           )