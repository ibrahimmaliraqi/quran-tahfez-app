import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

class TeachersHeader extends StatelessWidget {
  final int count;

  const TeachersHeader({super.key, required this.count});

  static const _gold = Color(0xFFD9B66B);
  static const _goldLight = Color(0xFFF2DDA4);

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final topInset = MediaQuery.of(context).padding.top;
    const radius = BorderRadius.vertical(bottom: Radius.circular(34));

    return Container(
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
            const Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(painter: _PatternPainter()),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, topInset + 24, 22, 30),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'إدارة المعلمين',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(width: 22, height: 1.5, color: _gold),
                            const SizedBox(width: 10),
                            const Text(
                              'عرض وإدارة الكادر التعليمي',
                              style: TextStyle(color: _goldLight, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 66,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.22),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'معلم',
                          style: TextStyle(
                            color: Color(0xFFDDF0E9),
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      ..color = Colors.white.withValues(alpha: 0.05);

    const cell = 62.0;
    var row = 0;
    for (double y = 0; y < size.height + cell; y += cell / 2, row++) {
      final off = row.isEven ? 0.0 : cell / 2;
      for (double x = -cell + off; x < size.width + cell; x += cell) {
        canvas.drawPath(_octagram(Offset(x, y), 17, -math.pi / 2), lattice);
      }
    }

    const gold = Color(0xFFD9B66B);
    final c = Offset(size.width * 0.08, size.height * 0.45);
    canvas.drawCircle(
      c,
      130,
      Paint()
        ..shader = RadialGradient(
          colors: [gold.withValues(alpha: 0.22), gold.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: c, radius: 130)),
    );
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = gold.withValues(alpha: 0.36);
    canvas.drawPath(_octagram(c, 84, -math.pi / 2), stroke);
    stroke.color = gold.withValues(alpha: 0.22);
    canvas.drawPath(_octagram(c, 54, -math.pi / 2 + math.pi / 8), stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
