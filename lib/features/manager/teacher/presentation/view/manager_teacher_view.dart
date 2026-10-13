import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManagerTeachersView extends StatefulWidget {
  const ManagerTeachersView({super.key});

  @override
  State<ManagerTeachersView> createState() => _ManagerTeachersViewState();
}

class _ManagerTeachersViewState extends State<ManagerTeachersView> {
  static const Color primary = Color(0xFF1E6553);
  static const Color mint = Color(0xFFDDF0E9);
  static const Color background = Color(0xFFF9F9F8);
  static const Color textColor = Color(0xFF2D3748);
  static const Color muted = Color(0xFF718096);

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _teachers = [
    {
      "teacher_name": "علي",
      "email": "ali123456@gmail.com",
      "created_at": DateTime.now(),
    },
  ];

  List<Map<String, dynamic>> get _filteredTeachers {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) return _teachers;

    return _teachers.where((teacher) {
      final name = (teacher['teacher_name'] ?? '').toString().toLowerCase();
      final email = (teacher['email'] ?? '').toString().toLowerCase();

      return name.contains(query) || email.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddTeacherDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'إضافة معلم جديد',
            style: TextStyle(
              color: primary,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInput(
                    controller: nameController,
                    label: 'اسم المعلم',
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    controller: emailController,
                    label: "رقم الهاتف",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'أدخل البريد الإلكتروني';
                      }

                      if (!value.contains('@') || !value.contains('.')) {
                        return 'البريد الإلكتروني غير صحيح';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildInput(
                    controller: emailController,
                    label: 'البريد الإلكتروني',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'أدخل البريد الإلكتروني';
                      }

                      if (!value.contains('@') || !value.contains('.')) {
                        return 'البريد الإلكتروني غير صحيح';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildInput(
                    controller: emailController,
                    label: "كلمة السر",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'أدخل البريد الإلكتروني';
                      }

                      if (!value.contains('@') || !value.contains('.')) {
                        return 'البريد الإلكتروني غير صحيح';
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'إلغاء',
                style: TextStyle(color: muted),
              ),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                setState(() {
                  _teachers.insert(0, {
                    'teacher_name': nameController.text.trim(),
                    'email': emailController.text.trim(),
                    'created_at': DateTime.now().toIso8601String(),
                  });
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'تمت إضافة المعلم للعرض المحلي بنجاح',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('إضافة'),
            ),
          ],
        );
      },
    ).whenComplete(() {
      nameController.dispose();
      emailController.dispose();
    });
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator:
          validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primary),
        filled: true,
        fillColor: background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE7ECE9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teachers = _filteredTeachers;

    return Scaffold(
      backgroundColor: background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTeacherDialog,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text(
          'إضافة معلم',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RefreshIndicator(
                color: primary,
                onRefresh: () async {
                  // اربط جلب المعلمين من API هنا.
                },
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 100),
                  children: [
                    _buildSearchField(),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'قائمة المعلمين',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: textColor,
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
                            '${_teachers.length} معلم',
                            style: const TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (teachers.isEmpty)
                      _buildEmptyState()
                    else
                      ...teachers.map(_buildTeacherCard),
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
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 30),
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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.cast_for_education_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إدارة المعلمين',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'إدارة الكادر التعليمي بسهولة',
                      style: TextStyle(
                        color: Color(0xFFDDF0E9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.groups_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إجمالي المعلمين',
                        style: TextStyle(
                          color: Color(0xFFDDF0E9),
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'الكادر التعليمي',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${_teachers.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'ابحث عن اسم المعلم أو البريد الإلكتروني',
        hintStyle: const TextStyle(
          color: muted,
          fontSize: 12,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: primary,
        ),
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
      ),
    );
  }

  Widget _buildTeacherCard(Map<String, dynamic> teacher) {
    final name = teacher['teacher_name']?.toString() ?? '';
    final email = teacher['email']?.toString() ?? '';
    final createdAt = teacher['created_at']?.toString() ?? '';

    String formattedDate = createdAt;

    try {
      formattedDate = DateFormat(
        'yyyy/MM/dd',
      ).format(DateTime.parse(createdAt));
    } catch (_) {
      // اعرض التاريخ الأصلي إذا كان بتنسيق غير متوقع.
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: const Color(0xFFEDF0ED)),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: mint,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: primary,
                  size: 28,
                ),
              ),
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
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.verified_user_outlined,
                color: primary,
                size: 21,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFEDF0ED)),
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 17,
                color: muted,
              ),
              const SizedBox(width: 7),
              const Text(
                'تاريخ الإنشاء',
                style: TextStyle(
                  color: muted,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 38,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEDF0ED)),
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: mint,
              borderRadius: BorderRadius.circular(27),
            ),
            child: const Icon(
              Icons.co_present_rounded,
              size: 40,
              color: primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            _searchController.text.isNotEmpty
                ? 'ما لكينا نتائج'
                : 'ماكو معلمين لحد الآن',
            style: const TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'تگدر تضيف معلم جديد حتى يظهر ضمن القائمة',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: muted,
              fontSize: 13,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: _showAddTeacherDialog,
            style: OutlinedButton.styleFrom(
              foregroundColor: primary,
              side: const BorderSide(color: primary),
            ),
            icon: const Icon(Icons.add_rounded),
            label: const Text('إضافة أول معلم'),
          ),
        ],
      ),
    );
  }
}
