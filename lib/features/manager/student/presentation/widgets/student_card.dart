import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/domain/student/entities/student_entity.dart';

class StudentCard extends StatelessWidget {
  final StudentEntity student;

  const StudentCard({
    super.key,
    required this.student,
  });

  static const Color primary = Color(0xFF1E6553);
  static const Color mint = Color(0xFFDDF0E9);
  static const Color textColor = Color(0xFF2D3748);
  static const Color muted = Color(0xFF718096);

  static const int totalQuranPages = 604;

  @override
  Widget build(BuildContext context) {
    final name = student.studentName;
    final email = student.email;
    final phone = student.phone;
    final educationLevel = student.educationLevel;
    final image = student.image;

    final lastPage = student.lastPage.clamp(0, totalQuranPages);
    final progress = lastPage / totalQuranPages;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7EBE8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // معلومات الطالب
          Row(
            children: [
              _buildAvatar(name, image),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty ? 'بدون اسم' : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _infoRow(
                      icon: Icons.school_outlined,
                      text: 'رقم المدرّس: ${student.teacherId}',
                    ),
                    if (educationLevel.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      _infoRow(
                        icon: Icons.menu_book_outlined,
                        text: educationLevel,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          if (phone.isNotEmpty || email.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(
              color: Color(0xFFEDF0ED),
              height: 1,
            ),
            const SizedBox(height: 14),

            if (phone.isNotEmpty)
              _infoRow(
                icon: Icons.phone_outlined,
                text: phone,
              ),

            if (phone.isNotEmpty && email.isNotEmpty) const SizedBox(height: 9),

            if (email.isNotEmpty)
              _infoRow(
                icon: Icons.email_outlined,
                text: email,
              ),
          ],

          const SizedBox(height: 16),

          // تقدم الحفظ
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_stories_rounded,
                      color: primary,
                      size: 21,
                    ),
                    const SizedBox(width: 9),
                    const Expanded(
                      child: Text(
                        'آخر صفحة محفوظة',
                        style: TextStyle(
                          color: muted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      '$lastPage / $totalQuranPages',
                      style: const TextStyle(
                        color: primary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: mint,
                    valueColor: const AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
                const SizedBox(height: 7),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${(progress * 100).round()}% مكتمل',
                    style: const TextStyle(
                      color: muted,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String name, String? image) {
    if (image != null && image.trim().isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          image,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _defaultAvatar(name),
        ),
      );
    }

    return _defaultAvatar(name);
  }

  Widget _defaultAvatar(String name) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: mint,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        name.isNotEmpty ? name.characters.first : 'ط',
        style: const TextStyle(
          color: primary,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: muted,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: muted,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
