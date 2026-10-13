import 'package:flutter/material.dart';

class EmptyTeachersView extends StatelessWidget {
  final bool isSearching;
  final VoidCallback onAddTeacher;

  const EmptyTeachersView({
    super.key,
    required this.isSearching,
    required this.onAddTeacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7EBE8)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.people_outline_rounded,
            color: Color(0xFF1E6553),
            size: 42,
          ),
          const SizedBox(height: 12),
          Text(
            isSearching ? 'لا توجد نتائج' : 'لا يوجد معلمون حالياً',
            style: const TextStyle(
              color: Color(0xFF2D3748),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            isSearching
                ? 'جرّب البحث باستخدام اسم آخر'
                : 'يمكنك إضافة أول معلم إلى القائمة',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF718096),
              fontSize: 12,
            ),
          ),
          if (!isSearching) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onAddTeacher,
              icon: const Icon(Icons.add),
              label: const Text('إضافة معلم'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1E6553),
                side: const BorderSide(
                  color: Color(0xFF1E6553),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
