import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/constants/app_popup_menus.dart';
import 'package:quran_tahfez/core/constants/enums/popup_menu_action_enum.dart';
import 'package:quran_tahfez/core/domain/teacher/entities/teacher_entity.dart';
import 'package:quran_tahfez/core/functions/get_time_ago.dart';
import 'package:quran_tahfez/core/functions/make_call.dart';
import 'package:quran_tahfez/core/widgets/custom_pop_menu.dart';
import 'package:quran_tahfez/core/widgets/net_image.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';
import 'package:quran_tahfez/features/manager/teacher/presentation/manager/delete_teacher/delete_teacher_cubit.dart';

class TeacherCard extends StatelessWidget {
  final TeacherEntity teacher;

  const TeacherCard({super.key, required this.teacher});

  static const _ink = Color(0xFF1F342B);
  static const _muted = Color(0xFF8A978F);

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _ink.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _Avatar(teacher: teacher),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  teacher.teacherName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              CustomPopupMenuButton(
                items: AppPopupMenus.common,
                onSelected: (value) {
                  switch (value) {
                    case PopupMenuActionEnums.delete:
                      context.read<DeleteTeacherCubit>().deleteTeacher(
                        teacherId: teacher.userId,
                      );
                      break;
                    default:
                  }
                },
                value: teacher.userId,
              ),
            ],
          ),
          const SizedBox(height: 14),
          _ContactRow(
            label: 'الإيميل',
            value: teacher.email,
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 8),
          _ContactRow(
            label: 'رقم الهاتف',
            value: teacher.phone,
            icon: Icons.phone_outlined,
            canCall: true,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 15, color: primary),
                const SizedBox(width: 8),
                const Text(
                  'تاريخ الإنشاء',
                  style: TextStyle(color: _muted, fontSize: 12),
                ),
                const Spacer(),
                Text(
                  getTimeAgo(teacher.createdAt),
                  style: TextStyle(
                    color: primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.teacher});

  final TeacherEntity teacher;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final name = teacher.teacherName.trim();

    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD9B66B).withValues(alpha: 0.75),
          width: 1.4,
        ),
      ),
      child: ClipOval(
        child: teacher.imageUrl == null
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      const Color(0xFFDDF0E9),
                      Color.lerp(const Color(0xFFDDF0E9), primary, 0.35)!,
                    ],
                  ),
                ),
                child: Text(
                  name.isEmpty ? '؟' : name.characters.first,
                  style: TextStyle(
                    color: primary,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            : SizedBox(
                width: 51,
                height: 51,
                child: NetImage(imageUrl: teacher.imageUrl!),
              ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.label,
    required this.value,
    required this.icon,
    this.canCall = false,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool canCall;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final hasValue = value.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 4, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.09),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 17, color: primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: TeacherCard._muted,
                    fontSize: 10.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hasValue ? value : 'غير متوفر',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: TeacherCard._ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (hasValue) ...[
            _MiniButton(
              icon: Icons.copy_rounded,
              tooltip: 'نسخ',
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: value));
                if (!context.mounted) return;
                Snack.show(context, message: 'تم نسخ $label بنجاح');
              },
            ),
            if (canCall)
              _MiniButton(
                icon: Icons.call_rounded,
                tooltip: 'اتصال',
                onTap: () => makePhoneCall(context, phone: value),
              ),
          ],
        ],
      ),
    );
  }
}

class _MiniButton extends StatelessWidget {
  const _MiniButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      icon: Icon(icon, size: 18, color: AppColors.primary),
    );
  }
}

// Kept as-is: may be used by other files.
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
