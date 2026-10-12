import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class ManagerDashboardView extends StatelessWidget {
  const ManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                        size: 29,
                      ),
                    ),
                    const SizedBox(width: 13),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'لوحة الإدارة',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF263D33),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'إدارة منظومة تحفيظ القرآن الكريم',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Notifications
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: const Size(46, 46),
                      ),
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Color(0xFF263D33),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Welcome Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF287763),
                        Color(0xFF164A3D),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -10,
                        bottom: -20,
                        child: Icon(
                          Icons.auto_stories_rounded,
                          size: 125,
                          color: Colors.white.withOpacity(0.07),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.14),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'مدير النظام',
                              style: TextStyle(
                                color: Color(0xFFE5C783),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'أهلاً بك 👋',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'معاً نحو جيلٍ متقنٍ لكتاب الله',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: Color(0xFFE5C783),
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'الإدارة والمتابعة من مكان واحد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Statistics Title
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 28, 20, 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'نظرة عامة',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263D33),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.analytics_outlined,
                      color: Color(0xFF1E6553),
                      size: 23,
                    ),
                  ],
                ),
              ),
            ),

            // Statistics Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate([
                  _StatCard(
                    title: 'الطلاب',
                    value: '0',
                    subtitle: 'إجمالي الطلاب',
                    icon: Icons.school_outlined,
                    color: const Color(0xFF287763),
                    background: const Color(0xFFE6F2EB),
                  ),
                  _StatCard(
                    title: 'المعلمون',
                    value: '0',
                    subtitle: 'إجمالي المعلمين',
                    icon: Icons.person_outline_rounded,
                    color: const Color(0xFF4976C8),
                    background: const Color(0xFFEAF0FC),
                  ),
                  _StatCard(
                    title: 'الحلقات',
                    value: '0',
                    subtitle: 'حلقات التحفيظ',
                    icon: Icons.groups_2_outlined,
                    color: const Color(0xFFB18A36),
                    background: const Color(0xFFFBF2DD),
                  ),
                  _StatCard(
                    title: 'المستخدمون',
                    value: '0',
                    subtitle: 'حسابات النظام',
                    icon: Icons.manage_accounts_outlined,
                    color: const Color(0xFF8C63B8),
                    background: const Color(0xFFF1EAF8),
                  ),
                ]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 13,
                  childAspectRatio: 1.12,
                ),
              ),
            ),

            // Quick Actions Title
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                child: Text(
                  'الإدارة السريعة',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263D33),
                  ),
                ),
              ),
            ),

            // Quick Actions
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    _ActionTile(
                      icon: Icons.person_add_alt_1_rounded,
                      title: 'إدارة المستخدمين',
                      subtitle: 'إضافة وتعديل حسابات الطلاب والمعلمين',
                      color: const Color(0xFF287763),
                      onTap: () {
                        // TODO: Navigate to users management
                      },
                    ),
                    const SizedBox(height: 12),
                    _ActionTile(
                      icon: Icons.menu_book_rounded,
                      title: 'إدارة حلقات التحفيظ',
                      subtitle: 'متابعة الحلقات وتنظيم الطلاب',
                      color: const Color(0xFFB18A36),
                      onTap: () {
                        // TODO: Navigate to circles management
                      },
                    ),
                    const SizedBox(height: 12),
                    _ActionTile(
                      icon: Icons.fact_check_outlined,
                      title: 'سجل النشاطات',
                      subtitle: 'عرض عمليات الإضافة والتعديل والحذف',
                      color: const Color(0xFF4976C8),
                      onTap: () {
                        // TODO: Navigate to activity logs
                      },
                    ),
                    const SizedBox(height: 12),
                    _ActionTile(
                      icon: Icons.settings_outlined,
                      title: 'إعدادات النظام',
                      subtitle: 'إدارة إعدادات التطبيق والصلاحيات',
                      color: const Color(0xFF8C63B8),
                      onTap: () {
                        // TODO: Navigate to settings
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 25),
                child: Center(
                  child: Text(
                    'خيركم من تعلّم القرآن وعلّمه',
                    style: TextStyle(
                      color: Color(0xFF8A978F),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Statistics Card
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color background;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: const Color(0xFFEDF0EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 23),
              ),
              const Spacer(),
              Icon(
                Icons.trending_up_rounded,
                color: color.withOpacity(0.65),
                size: 19,
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263D33),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF34483D),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF8A978F),
            ),
          ),
        ],
      ),
    );
  }
}

// Quick Action Tile
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(19),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: const Color(0xFFEDF0EC)),
          ),
          child: Row(
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: color, size: 25),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF263D33),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8A978F),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Color(0xFF9AA69D),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
