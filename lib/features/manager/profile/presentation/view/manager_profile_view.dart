import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';
import 'package:quran_tahfez/core/service/prefs_helper.dart';

class ManagerProfileView extends StatelessWidget {
  const ManagerProfileView({super.key});

  static const Color _ink = Color(0xFF1F342B);
  static const Color _muted = Color(0xFF8A978F);
  static const Color _line = Color(0xFFEDF0EC);
  static const Color _gold = Color(0xFFD9B66B);
  static const Color _danger = Color(0xFFC04444);

  // استبدل هذه القيم ببيانات المدير المسجل دخوله
  final String managerName = 'مدير النظام';
  final String managerEmail = 'manager@example.com';
  final String managerRole = 'مدير المركز';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7F3),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            _ProfileHeader(
              name: managerName,
              email: managerEmail,
              role: managerRole,
            ),
            const SizedBox(height: 37 + 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('الحساب الشخصي'),
                  const SizedBox(height: 14),
                  _SettingsCard(
                    children: [
                      _SettingTile(
                        icon: Icons.person_outline_rounded,
                        title: 'المعلومات الشخصية',
                        subtitle: 'عرض وتعديل معلومات حسابك',
                        onTap: () => _showComingSoon(context),
                      ),
                      _SettingTile(
                        icon: Icons.email_outlined,
                        title: 'البريد الإلكتروني',
                        subtitle: managerEmail,
                        onTap: () => _showComingSoon(context),
                      ),
                      _SettingTile(
                        icon: Icons.lock_outline_rounded,
                        title: 'كلمة المرور',
                        subtitle: 'تغيير كلمة مرور الحساب',
                        onTap: () => _showComingSoon(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const _SectionTitle('إعدادات التطبيق'),
                  const SizedBox(height: 14),
                  _SettingsCard(
                    children: [
                      _SettingTile(
                        icon: Icons.notifications_none_rounded,
                        title: 'الإشعارات',
                        subtitle: 'إدارة التنبيهات والإشعارات',
                        onTap: () => _showComingSoon(context),
                      ),
                      _SettingTile(
                        icon: Icons.help_outline_rounded,
                        title: 'المساعدة والدعم',
                        subtitle: 'احصل على المساعدة عند الحاجة',
                        onTap: () => _showComingSoon(context),
                      ),
                      _SettingTile(
                        icon: Icons.info_outline_rounded,
                        title: 'حول التطبيق',
                        subtitle: 'معلومات عن تطبيق إدارة التحفيظ',
                        onTap: () => _showAboutDialog(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  _LogoutButton(onTap: () => _confirmLogout(context)),
                  const SizedBox(height: 30),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'إدارة تحفيظ القرآن الكريم',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'نسخة التطبيق 1.0.0',
                          style: TextStyle(
                            color: Color(0xFFA9B5AE),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ],
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
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            iconPadding: const EdgeInsets.only(top: 26),
            icon: Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                color: _danger.withValues(alpha: 0.09),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout_rounded, color: _danger, size: 30),
            ),
            title: const Text(
              'تسجيل الخروج',
              style: TextStyle(
                color: _ink,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            content: const Text(
              'هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟',
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted, height: 1.7, fontSize: 13.5),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(22, 8, 22, 22),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _muted,
                        side: const BorderSide(color: _line),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: _danger,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        PrefsHelper.clearUser();
                        Navigator.pop(dialogContext);
                        // TODO: navigate to the login screen here.
                        _showComingSoon(context);
                      },
                      child: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('هذه الميزة تحتاج إلى ربطها بالنظام'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: _ink,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

// ─────────────────────────────────────────────────────────────────────────────
// Header: centered avatar on an emerald gradient + floating role card
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.role,
  });

  final String name;
  final String email;
  final String role;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final topInset = MediaQuery.of(context).padding.top;
    const radius = BorderRadius.vertical(bottom: Radius.circular(34));

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.lerp(primary, Colors.white, 0.06)!,
                Color.lerp(primary, Colors.black, 0.58)!,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: primary.withValues(alpha: 0.26),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: Stack(
              children: [
                Positioned.fill(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: _PatternPainter(focusY: topInset + 118),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(22, topInset + 20, 22, 64),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Text(
                          'حسابي',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Container(
                          width: 96,
                          height: 96,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ManagerProfileView._gold.withValues(
                                alpha: 0.85,
                              ),
                              width: 1.6,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ManagerProfileView._gold.withValues(
                                  alpha: 0.25,
                                ),
                                blurRadius: 26,
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.14),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.22),
                              ),
                            ),
                            child: const Icon(
                              Icons.admin_panel_settings_rounded,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          email,
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFDDF0E9),
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: -37,
          height: 74,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: primary.withValues(alpha: 0.14),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.lerp(primary, Colors.white, 0.10)!,
                        Color.lerp(primary, Colors.black, 0.30)!,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.verified_user_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role,
                        style: const TextStyle(
                          color: ManagerProfileView._ink,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'صلاحيات إدارة النظام',
                        style: TextStyle(
                          color: ManagerProfileView._muted,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ManagerProfileView._gold.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'مدير',
                    style: TextStyle(
                      color: Color(0xFF8A6A2B),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
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
}

/// Octagram lattice plus a gold halo behind the avatar.
class _PatternPainter extends CustomPainter {
  const _PatternPainter({required this.focusY});

  final double focusY;

  static Path _octagram(Offset c, double r, double rotation) {
    const inner = 0.7654;
    final p = Path();
    for (var i = 0; i < 16; i++) {
      final rad = i.isEven ? r : r * inner;
      final a = rotation + i * math.pi / 8;
      final pt = Offset(c.dx + rad * math.cos(a), c.dy + rad * math.sin(a));
      if (i == 0) {
        p.moveTo(pt.dx, pt.dy);
      } else {
        p.lineTo(pt.dx, pt.dy);
      }
    }
    return p..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final lattice = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = Colors.white.withValues(alpha: 0.05);

    const cell = 62.0;
    var row = 0;
    for (double y = 0; y < size.height + cell; y += cell / 2, row++) {
      final off = row.isEven ? 0.0 : cell / 2;
      for (double x = -cell + off; x < size.width + cell; x += cell) {
        canvas.drawPath(_octagram(Offset(x, y), 17, -math.pi / 2), lattice);
      }
    }

    const gold = ManagerProfileView._gold;
    final c = Offset(size.width / 2, focusY);
    canvas.drawCircle(
      c,
      140,
      Paint()
        ..shader = RadialGradient(
          colors: [gold.withValues(alpha: 0.22), gold.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: c, radius: 140)),
    );
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = gold.withValues(alpha: 0.34);
    canvas.drawPath(_octagram(c, 92, -math.pi / 2), stroke);
    stroke.color = gold.withValues(alpha: 0.20);
    canvas.drawPath(_octagram(c, 66, -math.pi / 2 + math.pi / 8), stroke);
  }

  @override
  bool shouldRepaint(covariant _PatternPainter old) => old.focusY != focusY;
}

// ─────────────────────────────────────────────────────────────────────────────
// Sections
// ─────────────────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: ManagerProfileView._gold,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: ManagerProfileView._ink,
            fontSize: 17.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        items.add(
          const Divider(
            height: 1,
            indent: 78,
            endIndent: 18,
            color: ManagerProfileView._line,
          ),
        );
      }
      items.add(children[i]);
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ManagerProfileView._ink.withValues(alpha: 0.06),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: primary, size: 23),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: ManagerProfileView._ink,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ManagerProfileView._muted,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_left_rounded,
                color: Color(0xFF9AA69D),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const danger = ManagerProfileView._danger;

    return Material(
      color: danger.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: danger.withValues(alpha: 0.18)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout_rounded, color: danger, size: 22),
              SizedBox(width: 10),
              Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: danger,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
