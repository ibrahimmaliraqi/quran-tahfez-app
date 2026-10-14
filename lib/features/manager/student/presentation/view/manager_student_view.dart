import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/widgets/not_data_found.dart';
import 'package:quran_tahfez/features/manager/student/presentation/widgets/student_card.dart';

class ManagerStudentsView extends StatefulWidget {
  const ManagerStudentsView({super.key});

  @override
  State<ManagerStudentsView> createState() => _ManagerStudentsViewState();
}

class _ManagerStudentsViewState extends State<ManagerStudentsView> {
  static const Color primary = Color(0xFF1E6553);
  static const Color background = Color(0xFFF9F9F8);

  final TextEditingController _searchController = TextEditingController();

  // بيانات تجريبية لجميع الطلاب
  final List<Map<String, dynamic>> _students = [
    {
      'id': 1,
      'student_name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '07701234567',
      'parent_phone': '07801234567',
      'image': '',
      'education_level': 'المرحلة المتوسطة',
      'last_page': 120,
      'teacher_name': 'محمد عبد الله',
    },
    {
      'id': 1,
      'student_name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '07701234567',
      'parent_phone': '07801234567',
      'image': '',
      'education_level': 'المرحلة المتوسطة',
      'last_page': 120,
      'teacher_name': 'محمد عبد الله',
    },
    {
      'id': 1,
      'student_name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '07701234567',
      'parent_phone': '07801234567',
      'image': '',
      'education_level': 'المرحلة المتوسطة',
      'last_page': 120,
      'teacher_name': 'محمد عبد الله',
    },
    {
      'id': 1,
      'student_name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '07701234567',
      'parent_phone': '07801234567',
      'image': '',
      'education_level': 'المرحلة المتوسطة',
      'last_page': 120,
      'teacher_name': 'محمد عبد الله',
    },
    {
      'id': 1,
      'student_name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '07701234567',
      'parent_phone': '07801234567',
      'image': '',
      'education_level': 'المرحلة المتوسطة',
      'last_page': 120,
      'teacher_name': 'محمد عبد الله',
    },
  ];

  List<Map<String, dynamic>> get _filteredStudents {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) return _students;

    return _students.where((student) {
      final name = (student['student_name'] ?? '').toString().toLowerCase();
      final teacher = (student['teacher_name'] ?? '').toString().toLowerCase();

      return name.contains(query) || teacher.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final students = _filteredStudents;
    final isSearching = _searchController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: RefreshIndicator(
                color: primary,
                onRefresh: _loadStudents,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildSearch(),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'جميع الطلاب',
                            style: TextStyle(
                              color: Color(0xFF2D3748),
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '${students.length} طالب',
                          style: const TextStyle(
                            color: primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    if (students.isEmpty)
                      NoDataWidget(
                        icon: isSearching
                            ? Icons.search_off_rounded
                            : Icons.school_outlined,
                        title: isSearching
                            ? 'لا توجد نتائج'
                            : 'لا يوجد طلاب حالياً',
                        subtitle: isSearching
                            ? 'جرّب البحث باسم آخر'
                            : 'ستظهر هنا قائمة الطلاب عند توفر البيانات',
                      )
                    else
                      ...students.map(
                        (student) => StudentCard(
                          student: student,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      decoration: const BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(26),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إدارة الطلاب',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'تابع رحلة الطلاب في حفظ القرآن',
                  style: TextStyle(
                    color: Color(0xFFDDF0E9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.groups_rounded,
            color: Colors.white,
            size: 27,
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'ابحث عن الطالب أو المعلم',
        hintStyle: const TextStyle(
          color: Color(0xFF718096),
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: primary,
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
                icon: const Icon(Icons.close_rounded),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFE7EBE8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary),
        ),
      ),
    );
  }

  Future<void> _loadStudents() async {
    // لاحقاً استدعاء API جلب جميع الطلاب
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );
  }
}
