import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/constants/app_popup_menus.dart';
import 'package:quran_tahfez/core/constants/enums/popup_menu_action_enum.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';
import 'package:quran_tahfez/core/widgets/custom_pop_menu.dart';
import 'package:quran_tahfez/core/widgets/snack.dart';

class StudentCard extends StatelessWidget {
  final StudentEntity student;
  final bool showActions;
  final VoidCallback? onDelete;

  const StudentCard({
    super.key,
    required this.student,
    required this.showActions,
    this.onDelete,
  });

  static const int totalQuranPages = 604;
  static const _ink = Color(0xFF1F342B);

  @override
  Widget build(BuildContext context) {
    final name = student.studentName.trim();
    final email = student.email;
    final phone = student.phone;
    final educationLevel = student.educationLevel;
    final teacherName = student.teacherName;

    final lastPage = student.lastPage.clamp(0, totalQuranPages);
    final progress = lastPage / totalQuranPages;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(name: name, image: student.image),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name.isEmpty ? 'بدون اسم' : name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 16.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (showActions)
                          CustomPopupMenuButton(
                            items: AppPopupMenus.common,
                            onSelected: (value) {
                              switch (value) {
                                case PopupMenuActionEnums.delete:
                                  onDelete?.call();
                                  break;
                                default:
                                  break;
                              }
                            },
                            value: student.userId,
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (teacherName!.trim().isNotEmpty)
                          _Chip(
                            icon: Icons.school_outlined,
                            text: 'المدرّس: $teacherName',
                          ),
                        if (educationLevel.isNotEmpty)
                          _Chip(
                            icon: Icons.menu_book_outlined,
                            text: educationLevel,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (phone.isNotEmpty || email.isNotEmpty) ...[
            const SizedBox(height: 14),
            if (phone.isNotEmpty)
              _ContactRow(
                icon: Icons.phone_outlined,
                label: 'رقم الهاتف',
                value: phone,
              ),
            if (phone.isNotEmpty && email.isNotEmpty) const SizedBox(height: 8),
            if (email.isNotEmpty)
              _ContactRow(
                icon: Icons.email_outlined,
                label: 'البريد الإلكتروني',
                value: email,
              ),
          ],
          const SizedBox(height: 14),
          _ProgressBox(lastPage: lastPage, progress: progress),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name, required this.image});

  final String name;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final hasImage = image != null && image!.trim().isNotEmpty;

    Widget initial() => Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.mint,
            Color.lerp(AppColors.mint, primary, 0.35)!,
          ],
        ),
      ),
      child: Text(
        name.isNotEmpty ? name.characters.first : 'ط',
        style: TextStyle(
          color: primary,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

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
        child: hasImage
            ? Image.network(
                image!,
                width: 51,
                height: 51,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => initial(),
              )
            : initial(),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: primary),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: primary,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

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
                    color: AppColors.muted,
                    fontSize: 10.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: StudentCard._ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'نسخ',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: Icon(Icons.copy_rounded, size: 18, color: primary),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: value));
              if (!context.mounted) return;
              Snack.show(context, message: 'تم نسخ $label');
            },
          ),
        ],
      ),
    );
  }
}

class _ProgressBox extends StatelessWidget {
  const _ProgressBox({required this.lastPage, required this.progress});

  final int lastPage;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_stories_rounded,
                  color: primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'آخر صفحة محفوظة',
                      style: TextStyle(color: AppColors.muted, fontSize: 11.5),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$lastPage / ${StudentCard.totalQuranPages}',
                      style: const TextStyle(
                        color: StudentCard._ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(progress * 100).round()}%',
                    style: TextStyle(
                      color: primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const Text(
                    'مكتمل',
                    style: TextStyle(color: AppColors.muted, fontSize: 10.5),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (context, v, _) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 8,
                color: Colors.white,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FractionallySizedBox(
                    widthFactor: v,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                          colors: [
                            Color.lerp(primary, Colors.white, 0.35)!,
                            primary,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
