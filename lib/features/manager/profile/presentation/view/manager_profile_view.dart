import 'package:flutter/material.dart';

class ManagerProfileView extends StatelessWidget {
  const ManagerProfileView({super.key});

  static const Color primary = Color(0xFF1E6553);
  static const Color mint = Color(0xFFDDF0E9);
  static const Color background = Color(0xFFF9F9F8);
  static const Color textColor = Color(0xFF2D3748);
  static const Color muted = Color(0xFF718096);

  // استبدل هذه القيم ببيانات المدير المسجل دخوله
  final String managerName = 'مدير النظام';
  final String managerEmail = 'manager@example.com';
  final String managerRole = 'مدير المركز';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeader(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSectionTitle('الحساب الشخصي'),
                    const SizedBox(height: 13),
                    _buildSettingsCard(
                      children: [
                        _buildSettingTile(
                          icon: Icons.person_outline_rounded,
                          title: 'المعلومات الشخصية',
                          subtitle: 'عرض وتعديل معلومات حسابك',
                          onTap: () => _showComingSoon(context),
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.email_outlined,
                          title: 'البريد الإلكتروني',
                          subtitle: managerEmail,
                          onTap: () => _showComingSoon(context),
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.lock_outline_rounded,
                          title: 'كلمة المرور',
                          subtitle: 'تغيير كلمة مرور الحساب',
                          onTap: () => _showComingSoon(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    _buildSectionTitle('إعدادات التطبيق'),
                    const SizedBox(height: 13),
                    _buildSettingsCard(
                      children: [
                        _buildSettingTile(
                          icon: Icons.notifications_none_rounded,
                          title: 'الإشعارات',
                          subtitle: 'إدارة التنبيهات والإشعارات',
                          onTap: () => _showComingSoon(context),
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.help_outline_rounded,
                          title: 'المساعدة والدعم',
                          subtitle: 'احصل على المساعدة عند الحاجة',
                          onTap: () => _showComingSoon(context),
                        ),
                        _buildDivider(),
                        _buildSettingTile(
                          icon: Icons.info_outline_rounded,
                          title: 'حول التطبيق',
                          subtitle: 'معلومات عن تطبيق إدارة التحفيظ',
                          onTap: () => _showAboutDialog(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    _buildLogoutButton(context),
                    const SizedBox(height: 25),
                    const Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.menu_book_rounded,
                            color: Color(0xFF9BAAA2),
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'إدارة تحفيظ القرآن الكريم',
                            style: TextStyle(
                              color: muted,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'نسخة التطبيق 1.0.0',
                            style: TextStyle(
                              color: Color(0xFF9BAAA2),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 75),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1E6553),
                Color(0xFF124638),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'حسابي',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'إدارة معلومات حسابك وإعداداتك',
                style: TextStyle(
                  color: Color(0xFFDDF0E9),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: const Icon(
                      Icons.admin_panel_settings_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          managerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          managerEmail,
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFDDF0E9),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -25,
          left: 22,
          right: 22,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: mint,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.verified_user_rounded,
                    color: primary,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        managerRole,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'صلاحيات إدارة النظام',
                        style: TextStyle(
                          color: muted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: mint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'مدير',
                    style: TextStyle(
                      color: primary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: textColor,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSettingsCard({
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFEDF0ED),
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.025),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: mint.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: primary,
                  size: 23,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF9BAAA2),
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 1,
        color: Color(0xFFEDF0ED),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        onPressed: () => _confirmLogout(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFC04444),
          backgroundColor: const Color(0xFFFFF7F6),
          side: const BorderSide(
            color: Color(0xFFF1DAD7),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        icon: const Icon(Icons.logout_rounded),
        label: const Text(
          'تسجيل الخروج',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            icon: const Icon(
              Icons.logout_rounded,
              color: Color(0xFFC04444),
              size: 35,
            ),
            title: const Text(
              'تسجيل الخروج',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: muted,
                height: 1.7,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(
                  'إلغاء',
                  style: TextStyle(color: muted),
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFC04444),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _showComingSoon(context);
                },
                child: const Text('تسجيل الخروج'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('هذه الميزة تحتاج إلى ربطها بالنظام'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'إدارة تحفيظ القرآن الكريم',
      applicationVersion: '1.0.0',
      applicationLegalese: 'نسأل الله أن يجعل القرآن ربيع قلوبنا',
    );
  }
}
