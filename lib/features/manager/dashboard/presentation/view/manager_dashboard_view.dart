import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class ManagerDashboardView extends StatefulWidget {
  const ManagerDashboardView({super.key});

  @override
  State<ManagerDashboardView> createState() => _ManagerDashboardViewState();
}

class _ManagerDashboardViewState extends State<ManagerDashboardView>
    with SingleTickerProviderStateMixin {
  static const _bg = Color(0xFFF5F7F3);
  static const _ink = Color(0xFF1F342B);
  static const _muted = Color(0xFF8A978F);
  static const _gold = Color(0xFFD9B66B);
  static const _goldLight = Color(0xFFF2DDA4);

  static const _statsHeight = 112.0;
  static const _overlap = 56.0;

  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..forward();

  /// Staggered reveal: item [i] starts a little after the previous one.
  Animation<double> _at(int i) {
    final start = (i * 0.09).clamp(0.0, 0.55);
    return CurvedAnimation(
      parent: _c,
      curve: Interval(start, start + 0.45, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: _bg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── Header + overlapping stats ───────────────────────────────────
          Stack(
            clipBehavior: Clip.none,
            children: [
              _Header(topInset: topInset, reveal: _at(0)),
              Positioned(
                left: 20,
                right: 20,
                bottom: -_overlap,
                height: _statsHeight,
                child: _Reveal(animation: _at(1), child: const _StatsCard()),
              ),
            ],
          ),
          const SizedBox(height: _overlap + 30),

          // ── Quick actions ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _Reveal(
              animation: _at(2),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _gold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'الإدارة السريعة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _Reveal(
                  animation: _at(3),
                  child: _ActionTile(
                    icon: Icons.person_add_alt_1_rounded,
                    title: 'إدارة المستخدمين',
                    subtitle: 'الطلاب والمعلمون',
                    onTap: () {
                      // TODO: Navigate to users management
                    },
                  ),
                ),
                const SizedBox(height: 12),
                _Reveal(
                  animation: _at(4),
                  child: _ActionTile(
                    icon: Icons.menu_book_rounded,
                    title: 'إدارة حلقات التحفيظ',
                    subtitle: 'تنظيم الحلقات ومتابعتها',
                    onTap: () {
                      // TODO: Navigate to circles management
                    },
                  ),
                ),
                const SizedBox(height: 12),
                _Reveal(
                  animation: _at(5),
                  child: _ActionTile(
                    icon: Icons.fact_check_outlined,
                    title: 'سجل النشاطات',
                    subtitle: 'الإضافة والتعديل والحذف',
                    onTap: () {
                      // TODO: Navigate to activity logs
                    },
                  ),
                ),
                const SizedBox(height: 12),
                _Reveal(
                  animation: _at(6),
                  child: _ActionTile(
                    icon: Icons.settings_outlined,
                    title: 'إعدادات النظام',
                    subtitle: 'التطبيق والصلاحيات',
                    onTap: () {
                      // TODO: Navigate to settings
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.topInset, required this.reveal});

  final double topInset;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    const radius = BorderRadius.vertical(bottom: Radius.circular(34));

    return Container(
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
            color: primary.withOpacity(0.28),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            const Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(painter: _PatternPainter()),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, topInset + 18, 22, 82),
              child: _Reveal(
                animation: reveal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'السلام عليكم',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: const Color(
                                    0xFFDDF0E9,
                                  ).withOpacity(0.85),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'لوحة الإدارة',
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _GlassButton(
                          icon: Icons.notifications_none_rounded,
                          onTap: () {
                            // TODO: Notifications
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Container(
                          width: 22,
                          height: 1.5,
                          color: _ManagerColors.gold,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'خيركم من تعلّم القرآن وعلّمه',
                          style: TextStyle(
                            fontSize: 13,
                            color: _ManagerColors.goldLight,
                          ),
                        ),
                      ],
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
}

class _ManagerColors {
  static const gold = Color(0xFFD9B66B);
  static const goldLight = Color(0xFFF2DDA4);
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.12),
      shape: CircleBorder(
        side: BorderSide(color: Colors.white.withOpacity(0.22)),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(icon, color: Colors.white, size: 23),
        ),
      ),
    );
  }
}

/// Faint octagram lattice plus one large gold octagram ornament.
class _PatternPainter extends CustomPainter {
  const _PatternPainter();

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
      ..color = Colors.white.withOpacity(0.05);

    const cell = 62.0;
    var row = 0;
    for (double y = 0; y < size.height + cell; y += cell / 2, row++) {
      final off = row.isEven ? 0.0 : cell / 2;
      for (double x = -cell + off; x < size.width + cell; x += cell) {
        canvas.drawPath(_octagram(Offset(x, y), 17, -math.pi / 2), lattice);
      }
    }

    // Large ornament, partly off the edge.
    final c = Offset(size.width * 0.10, size.height * 0.30);
    canvas.drawCircle(
      c,
      150,
      Paint()
        ..shader = RadialGradient(
          colors: [
            _ManagerColors.gold.withOpacity(0.22),
            _ManagerColors.gold.withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: c, radius: 150)),
    );
    final gold = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _ManagerColors.gold.withOpacity(0.38);
    canvas.drawPath(_octagram(c, 96, -math.pi / 2), gold);
    canvas.drawPath(
      _octagram(c, 62, -math.pi / 2 + math.pi / 8),
      gold..color = _ManagerColors.gold.withOpacity(0.24),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Stats
// ─────────────────────────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.14),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: const Row(
        children: [
          _Stat(icon: Icons.school_outlined, value: '0', label: 'الطلاب'),
          _VLine(),
          _Stat(
            icon: Icons.person_outline_rounded,
            value: '0',
            label: 'المعلمون',
          ),
          _VLine(),
          _Stat(icon: Icons.groups_2_outlined, value: '0', label: 'الحلقات'),
          _VLine(),
          _Stat(
            icon: Icons.manage_accounts_outlined,
            value: '0',
            label: 'المستخدمون',
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value, required this.label});

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.09),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 19, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F342B),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF8A978F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VLine extends StatelessWidget {
  const _VLine();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 52, color: const Color(0xFFEDF0EC));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Action tile
// ─────────────────────────────────────────────────────────────────────────────

class _ActionTile extends StatelessWidget {
  const _ActionTile({
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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F342B).withOpacity(0.06),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.lerp(primary, Colors.white, 0.10)!,
                        Color.lerp(primary, Colors.black, 0.30)!,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.30),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 25),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F342B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A978F),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.07),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 20,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Entrance helper
// ─────────────────────────────────────────────────────────────────────────────

class _Reveal extends StatelessWidget {
  const _Reveal({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.12),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
