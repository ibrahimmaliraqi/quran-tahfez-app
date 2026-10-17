import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/constants/app_popup_menus.dart';
import 'package:quran_tahfez/core/constants/enums/popup_menu_action_enum.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/functions/get_time_ago.dart';
import 'package:quran_tahfez/core/functions/make_call.dart';
import 'package:quran_tahfez/core/widgets/custom_pop_menu.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/delete_teacher/delete_teacher_cubit.dart';

class TeacherCard extends StatelessWidget {
  final TeacherEntity teacher;

  const TeacherCard({
    super.key,
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7EBE8)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: const Color(0xFFDDF0E9),
                child: Text(
                  teacher.teacherName.characters.first,
                  style: const TextStyle(
                    color: Color(0xFF1E6553),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          teacher.teacherName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF2D3748),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        CustomPopupMenuButton(
                          items: AppPopupMenus.common,
                          onSelected: (value) {
                            switch (value) {
                              case PopupMenuActionEnums.delete:
                                context
                                    .read<DeleteTeacherCubit>()
                                    .deleteTeacher(teacherId: teacher.userId);

                                break;
                              default:
                            }
                          },
                          value: teacher.userId,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    _copyableInfo(
                      canCall: true,

                      context: context,
                      label: 'الإيميل',
                      value: teacher.email,
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 5),

                    _copyableInfo(
                      canCall: true,
                      context: context,
                      label: 'رقم الهاتف',
                      value: teacher.phone,
                      icon: Icons.phone_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              height: 1,
              color: Color(0xFFEDF0ED),
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 15,
                color: Color(0xFF718096),
              ),
              const SizedBox(width: 8),
              const Text(
                'تاريخ الإنشاء',
                style: TextStyle(
                  color: Color(0xFF718096),
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                getTimeAgo(teacher.createdAt),
                style: const TextStyle(
                  color: Color(0xFF2D3748),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppPopupMenuAction<T> {
  final T value;
  final String title;
  final IconData icon;
  final Color? color;

  const AppPopupMenuAction({
    required this.value,
    required this.title,
    required this.icon,
    this.color,
  });
}

Widget _copyableInfo({
  required BuildContext context,
  required String label,
  required String value,
  required IconData icon,
  bool canCall = false,
}) {
  return Row(
    children: [
      Icon(
        icon,
        size: 15,
        color: const Color(0xFF718096),
      ),
      const SizedBox(width: 6),
      Text(
        '$label: ',
        style: const TextStyle(
          color: Color(0xFF718096),
          fontSize: 12,
        ),
      ),
      Expanded(
        child: Text(
          value.isEmpty ? 'غير متوفر' : value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF718096),
            fontSize: 12,
          ),
        ),
      ),

      if (value.trim().isNotEmpty) ...[
        // نسخ
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 30,
          ),
          tooltip: 'نسخ',
          icon: const Icon(
            Icons.copy_rounded,
            size: 15,
            color: Color(0xFF1E6553),
          ),
          onPressed: () async {
            await Clipboard.setData(
              ClipboardData(text: value),
            );

            if (!context.mounted) return;

            Snack.show(
              context,
              message: 'تم نسخ $label بنجاح',
            );
          },
        ),

        // اتصال
        if (canCall)
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 30,
            ),
            tooltip: 'اتصال',
            icon: const Icon(
              Icons.call_rounded,
              size: 17,
              color: Color(0xFF1E6553),
            ),
            onPressed: () async {
              await makePhoneCall(context, phone: label);
            },
          ),
      ],
    ],
  );
}
