import 'package:flutter/material.dart';

class ManagerStudentsView extends StatefulWidget {
  const ManagerStudentsView({super.key});

  @override
  State<ManagerStudentsView> createState() => _ManagerStudentsViewState();
}

class _ManagerStudentsViewState extends State<ManagerStudentsView> {
  static const Color primary = Color(0xFF1E6553);
  static const Color mint = Color(0xFFDDF0E9);
  static const Color background = Color(0xFFF9F9F8);
  static const Color textColor = Color(0xFF2D3748);
  static const Color muted = Color(0xFF718096);

  // عدد صفحات المصحف
  static const int totalQuranPages = 604;

  final TextEditingController _searchController = TextEditingController();

  // اربط هذه القائمة ببيانات API لاحقاً
  final List<Map<String, dynamic>> _students = [
    {
      "student_name": "مجري",
      "teacher_name": "مدرس مدري",
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

  int _lastPage(Map<String, dynamic> student) {
    final value =
        int.tryParse(
          (student['last_page'] ?? 0).toString(),
        ) ??
        0;

    return value.clamp(0, totalQuranPages);
  }

  double _progress(Map<String, dynamic> student) {
    return _lastPage(student) / totalQuranPages;
  }

  String _progressLabel(Map<String, dynamic> student) {
    return '${(_progress(student) * 100).round()}%';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final students = _filteredStudents;

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
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                  children: [
                    _buildSearch(),
                    const SizedBox(height: 22),
                    _buildSectionHeader(students.length),
                    const SizedBox(height: 16),
                    if (students.isEmpty)
                      _buildEmptyState()
                    else
                      ...students.map(_buildStudentCard),
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
    final totalStudents = _students.length;
    final activeStudents = _students
        .where((student) => _lastPage(student) > 0)
        .length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E6553), Color(0xFF124638)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إدارة الطلاب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'إجمالي الطلاب',
                  value: '$totalStudents',
                  icon: Icons.groups_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'بدأوا الحفظ',
                  value: '$activeStudents',
                  icon: Icons.auto_stories_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFDDF0E9), size: 23),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFDDF0E9),
              fontSize: 11,
            ),
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
          color: muted,
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
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: Color(0xFFE8EDE9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(color: primary),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(int count) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'الطلاب وتقدّم الحفظ',
            style: TextStyle(
              color: textColor,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: mint,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count طالب',
            style: const TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    final name = student['student_name']?.toString() ?? 'بدون اسم';
    final teacher = student['teacher_name']?.toString() ?? 'غير محدد';
    final image = student['image']?.toString() ?? '';
    final page = _lastPage(student);
    final progress = _progress(student);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEDF0ED)),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildAvatar(name, image),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.school_outlined,
                          size: 16,
                          color: primary,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            teacher,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: muted,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: mint,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: primary,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 11),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'آخر صفحة محفوظة',
                        style: TextStyle(
                          color: muted,
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'من أصل 604 صفحات',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '$page / $totalQuranPages',
                  style: const TextStyle(
                    color: primary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              const Icon(
                Icons.trending_up_rounded,
                size: 19,
                color: primary,
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'تقدّم الحفظ',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                _progressLabel(student),
                style: const TextStyle(
                  color: primary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: const Color(0xFFE8EFEB),
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 0.75 ? const Color(0xFF23966E) : primary,
              ),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            progress == 0
                ? 'لم يبدأ تسجيل تقدّم الحفظ بعد'
                : 'أكمل ${_progressLabel(student)} من صفحات المصحف',
            style: const TextStyle(
              color: muted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String name, String image) {
    if (image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Image.network(
          image,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _defaultAvatar(name),
        ),
      );
    }

    return _defaultAvatar(name);
  }

  Widget _defaultAvatar(String name) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: mint,
        borderRadius: BorderRadius.circular(17),
      ),
      alignment: Alignment.center,
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

  Widget _buildEmptyState() {
    final isSearching = _searchController.text.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 38,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: const Color(0xFFEDF0ED)),
      ),
      child: Column(
        children: [
          Container(
            width: 83,
            height: 83,
            decoration: BoxDecoration(
              color: mint,
              borderRadius: BorderRadius.circular(27),
            ),
            child: Icon(
              isSearching ? Icons.search_off_rounded : Icons.menu_book_rounded,
              color: primary,
              size: 39,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            isSearching ? 'ما لكينا نتائج' : 'قائمة الطلاب فارغة',
            style: const TextStyle(
              color: textColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            isSearching
                ? 'جرّب البحث باسم مختلف'
                : 'راح تظهر هنا أسماء الطلاب ونسب تقدّمهم بالحفظ بعد جلب البيانات',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: muted,
              fontSize: 13,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadStudents() async {
    // TODO: استدعاء API جلب الطلاب وتحديث _students.
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}
