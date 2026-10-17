import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:quran_tahfez/core/constants/app_colors.dart';

// TODO: adjust this import to wherever your AppColors class lives.

/// Premium splash screen for «تحفيظ القرآن».
///
/// Everything is drawn with [CustomPainter]s (no image assets, no packages):
/// an emerald night with a faint octagram lattice, a gilded pointed arch that
/// draws itself, an open Mushaf on a walnut rehal, breathing golden light rays
/// and slow rising particles.
///
/// Call [onFinished] to navigate once the intro has played and held.
class SplashView extends StatefulWidget {
  const SplashView({
    super.key,
    this.onFinished,
    this.holdDuration = const Duration(milliseconds: 900),
  });

  /// Called after the intro animation completes plus [holdDuration].
  final VoidCallback? onFinished;

  /// Pause on the finished composition before [onFinished] fires.
  final Duration holdDuration;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  // One-shot choreography (arch → book → light → title → subtitle → loader).
  late final AnimationController _main = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 4200),
  );

  // Ambient loop (light breathing, particles, loader sweep). 12s so that
  // every integer-multiple cycle used by the painters loops seamlessly.
  late final AnimationController _ambient = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  );

  Animation<double> _iv(double a, double b, [Curve c = Curves.easeOutCubic]) =>
      CurvedAnimation(
        parent: _main,
        curve: Interval(a, b, curve: c),
      );

  late final Animation<double> _arch = _iv(0.00, 0.55, Curves.easeInOutCubic);
  late final Animation<double> _book = _iv(0.12, 0.55);
  late final Animation<double> _glow = _iv(0.30, 0.90, Curves.easeInOut);
  late final Animation<double> _title = _iv(0.50, 0.76);
  late final Animation<double> _divider = _iv(0.66, 0.88);
  late final Animation<double> _subtitle = _iv(0.72, 0.94);
  late final Animation<double> _loader = _iv(0.84, 1.00, Curves.easeIn);

  Timer? _timer;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (reduceMotion) {
      _main.value = 1;
      _scheduleFinish();
    } else {
      _ambient.repeat();
      _main.forward().whenComplete(_scheduleFinish);
    }
  }

  void _scheduleFinish() {
    if (!mounted) return;
    _timer = Timer(widget.holdDuration, () {
      if (mounted) widget.onFinished?.call();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _main.dispose();
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _Palette.deepest,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const RepaintBoundary(
              child: CustomPaint(painter: _BackgroundPainter()),
            ),
            IgnorePointer(
              child: CustomPaint(
                painter: _ParticlesPainter(reveal: _glow, ambient: _ambient),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, c) {
                  final heroW = math.min(
                    c.maxWidth * 0.90,
                    c.maxHeight * 0.44 / 1.12,
                  );
                  final titleSize = (c.maxWidth * 0.125).clamp(34.0, 54.0);
                  final subSize = (c.maxWidth * 0.042).clamp(14.0, 19.0);

                  return Column(
                    children: [
                      const Spacer(flex: 2),
                      _hero(heroW),
                      SizedBox(height: heroW * 0.02),
                      _titleText(titleSize),
                      const SizedBox(height: 10),
                      _dividerOrnament(),
                      const SizedBox(height: 12),
                      _subtitleText(subSize),
                      const Spacer(flex: 3),
                      FadeTransition(
                        opacity: _loader,
                        child: SizedBox(
                          width: 64,
                          height: 3,
                          child: CustomPaint(
                            painter: _LoaderPainter(ambient: _ambient),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hero(double w) {
    return SizedBox(
      width: w,
      height: w * 1.12,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _RaysPainter(reveal: _glow, ambient: _ambient),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _ArchPainter(draw: _arch, ambient: _ambient),
            ),
          ),
          Positioned.fill(
            child: FadeTransition(
              opacity: _book,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.035),
                  end: Offset.zero,
                ).animate(_book),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.88, end: 1).animate(_book),
                  child: const RepaintBoundary(
                    child: CustomPaint(painter: _BookPainter()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleText(double size) {
    return FadeTransition(
      opacity: _title,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.28),
          end: Offset.zero,
        ).animate(_title),
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_Palette.ivory, _Palette.goldLight, _Palette.gold],
            stops: [0.0, 0.55, 1.0],
          ).createShader(rect),
          child: Text(
            'تحفيظ القرآن',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
              fontSize: size,
              height: 1.3,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dividerOrnament() {
    return SizedBox(
      width: 190,
      height: 16,
      child: CustomPaint(painter: _DividerPainter(_divider)),
    );
  }

  Widget _subtitleText(double size) {
    return FadeTransition(
      opacity: _subtitle,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.4),
          end: Offset.zero,
        ).animate(_subtitle),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'رحلة إتقان وحفظ لكتاب الله',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontSize: size,
              height: 1.6,
              color: _Palette.mint.withOpacity(0.82),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Palette (derived from AppColors.primary; do not redefine the primary itself)
// ─────────────────────────────────────────────────────────────────────────────

class _Palette {
  _Palette._();

  static Color get primary => AppColors.primary;
  static Color get mid => Color.lerp(primary, Colors.black, 0.35)!;
  static Color get deep => Color.lerp(primary, Colors.black, 0.62)!;
  static Color get deepest => Color.lerp(primary, Colors.black, 0.82)!;

  static const mint = Color(0xFFDDF0E9);
  static const ivory = Color(0xFFFBF6E9);
  static const parchment = Color(0xFFE8DCBC);
  static const gold = Color(0xFFD9B66B);
  static const goldLight = Color(0xFFF2DDA4);
  static const walnutLight = Color(0xFF6A472A);
  static const walnutDark = Color(0xFF3A2414);
}

/// Eight-pointed star (octagram) outline, the classic rub el hizb motif.
Path _octagram(Offset c, double r, {double rotation = -math.pi / 2}) {
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

// ─────────────────────────────────────────────────────────────────────────────
// Background: emerald gradient + octagram lattice + vignette (static, cached)
// ─────────────────────────────────────────────────────────────────────────────

class _BackgroundPainter extends CustomPainter {
  const _BackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = ui.Gradient.linear(
          Offset.zero,
          Offset(0, h),
          [
            Color.lerp(_Palette.primary, Colors.black, 0.45)!,
            _Palette.deep,
            _Palette.deepest,
          ],
          [0, 0.55, 1],
        ),
    );

    // Lattice of octagrams on a brick-offset grid.
    final cell = w / 4.5;
    final star = cell * 0.30;
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = _Palette.gold.withOpacity(0.11);
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7
      ..color = _Palette.gold.withOpacity(0.05);
    final dot = Paint()..color = _Palette.gold.withOpacity(0.12);

    var row = 0;
    for (double y = -cell / 2; y < h + cell; y += cell * 0.5, row++) {
      final off = row.isEven ? 0.0 : cell * 0.5;
      for (double x = -cell + off; x < w + cell; x += cell) {
        final c = Offset(x, y);
        canvas.drawPath(_octagram(c, star), line);
        canvas.drawCircle(c, star * 1.45, ring);
        canvas.drawCircle(Offset(x + cell / 2, y), 1.3, dot);
      }
    }

    // Fog behind the hero so the pattern recedes where the light lives.
    final focus = Offset(w / 2, h * 0.40);
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = ui.Gradient.radial(
          focus,
          h * 0.58,
          [_Palette.deep.withOpacity(0.92), _Palette.deep.withOpacity(0)],
        ),
    );
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = ui.Gradient.radial(
          focus,
          h * 0.46,
          [_Palette.primary.withOpacity(0.50), _Palette.primary.withOpacity(0)],
        ),
    );

    // Edge vignette.
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(w / 2, h / 2),
          h * 0.82,
          [Colors.transparent, Colors.black.withOpacity(0.38)],
          [0.58, 1],
        ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Golden light: radial glow + a fan of softly pulsing rays
// ─────────────────────────────────────────────────────────────────────────────

class _RaysPainter extends CustomPainter {
  _RaysPainter({required this.reveal, required this.ambient})
    : super(repaint: Listenable.merge([reveal, ambient]));

  final Animation<double> reveal;
  final Animation<double> ambient;

  @override
  void paint(Canvas canvas, Size size) {
    final r = reveal.value;
    if (r <= 0) return;
    final t = ambient.value;
    final origin = Offset(size.width / 2, size.height * 0.52);
    final breath = 0.9 + 0.1 * math.sin(2 * math.pi * t * 2);

    final glowR = size.width * 0.95 * breath;
    canvas.drawCircle(
      origin,
      glowR,
      Paint()
        ..shader = ui.Gradient.radial(
          origin,
          glowR,
          [
            _Palette.gold.withOpacity(0.34 * r),
            _Palette.gold.withOpacity(0.10 * r),
            _Palette.gold.withOpacity(0),
          ],
          [0, 0.45, 1],
        ),
    );

    final len = size.width * 2.2;
    const count = 13;
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    for (var i = 0; i < count; i++) {
      final f = i / (count - 1);
      final angle =
          -math.pi / 2 +
          (f - 0.5) * math.pi * 0.92 +
          math.sin(2 * math.pi * t + i) * 0.015;
      final half = 0.028 + 0.018 * ((i * 7) % 5) / 4;
      final pulse =
          0.55 + 0.45 * math.sin(2 * math.pi * t * (1 + i % 2) + i * 1.3);
      final alpha = 0.20 * pulse * r * (1 - (f - 0.5).abs() * 1.1);

      canvas.save();
      canvas.rotate(angle + math.pi / 2);
      final path = Path()
        ..moveTo(0, 0)
        ..lineTo(-len * half, -len)
        ..lineTo(len * half, -len)
        ..close();
      canvas.drawPath(
        path,
        Paint()
          ..shader = ui.Gradient.linear(
            Offset.zero,
            Offset(0, -len * 0.9),
            [
              _Palette.goldLight.withOpacity(alpha),
              _Palette.goldLight.withOpacity(0),
            ],
          ),
      );
      canvas.restore();
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Pointed arch: draws itself, fades toward the base, crowned by an octagram
// ─────────────────────────────────────────────────────────────────────────────

class _ArchPainter extends CustomPainter {
  _ArchPainter({required this.draw, required this.ambient})
    : super(repaint: Listenable.merge([draw, ambient]));

  final Animation<double> draw;
  final Animation<double> ambient;

  Path _arch(double w, double inset, double topY, double baseY) {
    final cx = w / 2;
    final l = w * 0.07 + inset;
    final r = w - l;
    final spring = topY + (baseY - topY) * 0.42;
    final d = spring - topY;
    return Path()
      ..moveTo(l, baseY)
      ..lineTo(l, spring)
      ..cubicTo(l, spring - d * 0.55, cx - w * 0.10, topY + d * 0.30, cx, topY)
      ..cubicTo(cx + w * 0.10, topY + d * 0.30, r, spring - d * 0.55, r, spring)
      ..lineTo(r, baseY);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final p = draw.value;
    if (p <= 0) return;
    final w = size.width, h = size.height, s = w / 360;
    final t = ambient.value;
    final topY = h * 0.06, baseY = h * 0.90;

    final outer = _arch(w, 0, topY, baseY);
    final inner = _arch(w, w * 0.045, topY + w * 0.05, baseY);

    // Soft emerald fill inside the arch.
    canvas.drawPath(
      Path.from(inner)..close(),
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(0, topY),
          Offset(0, baseY),
          [
            _Palette.primary.withOpacity(0.38 * p),
            _Palette.primary.withOpacity(0),
          ],
        ),
    );

    Paint stroke(double width, double a) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..shader = ui.Gradient.linear(
        Offset(0, topY),
        Offset(0, baseY),
        [
          _Palette.goldLight.withOpacity(0.95 * a),
          _Palette.gold.withOpacity(0.06 * a),
        ],
      );

    void drawProgress(Path path, Paint paint) {
      for (final m in path.computeMetrics()) {
        canvas.drawPath(m.extractPath(0, m.length * p), paint);
      }
    }

    drawProgress(outer, stroke(2.2 * s, 1));
    drawProgress(inner, stroke(1.0 * s, 0.55));

    // Finial octagram at the apex.
    if (p > 0.6) {
      final q = ((p - 0.6) / 0.4).clamp(0.0, 1.0);
      final pulse = 0.65 + 0.35 * math.sin(2 * math.pi * t * 3);
      final c = Offset(w / 2, topY - w * 0.03);
      final r = w * 0.026;
      canvas.drawCircle(
        c,
        r * 2.6,
        Paint()
          ..shader = ui.Gradient.radial(
            c,
            r * 2.6,
            [
              _Palette.goldLight.withOpacity(0.45 * q * pulse),
              _Palette.goldLight.withOpacity(0),
            ],
          ),
      );
      canvas.drawPath(
        _octagram(c, r * q),
        Paint()
          ..shader = ui.Gradient.linear(
            c.translate(0, -r),
            c.translate(0, r),
            [_Palette.goldLight, _Palette.gold],
          ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Open Mushaf on a walnut rehal (static, cached by RepaintBoundary)
// ─────────────────────────────────────────────────────────────────────────────

class _BookPainter extends CustomPainter {
  const _BookPainter();

  static const _wordFracs = [0.22, 0.14, 0.30, 0.18, 0.12, 0.26, 0.16, 0.20];

  Path _page(double side, double cx, double bw, double top, double bottom) {
    final bh = bottom - top;
    final outer = cx + side * bw / 2;
    return Path()
      ..moveTo(cx, top + bh * 0.10)
      ..quadraticBezierTo(
        cx + side * bw * 0.26,
        top - bh * 0.04,
        outer,
        top + bh * 0.04,
      )
      ..lineTo(outer, bottom - bh * 0.06)
      ..quadraticBezierTo(
        cx + side * bw * 0.26,
        bottom + bh * 0.03,
        cx,
        bottom - bh * 0.04,
      )
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height, s = w / 360, cx = w / 2;
    final bw = w * 0.62;
    final top = h * 0.42, bottom = h * 0.76, bh = bottom - top;
    final bl = cx - bw / 2, br = cx + bw / 2;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // Ground shadow.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, h * 0.972),
        width: bw * 0.95,
        height: h * 0.03,
      ),
      Paint()
        ..color = Colors.black.withOpacity(0.45)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Rehal legs (X frame), drawn first so the board overlaps their tops.
    final yTop = bottom, yBot = h * 0.955;
    final a = bw * 0.20, b = bw * 0.30;
    final legs = [
      [Offset(cx - a, yTop), Offset(cx + b, yBot)],
      [Offset(cx + a, yTop), Offset(cx - b, yBot)],
    ];
    final legShader = ui.Gradient.linear(
      Offset(cx, yTop),
      Offset(cx, yBot),
      [_Palette.walnutLight, _Palette.walnutDark],
    );
    for (final l in legs) {
      canvas.drawLine(
        l[0],
        l[1],
        Paint()
          ..strokeWidth = w * 0.04
          ..strokeCap = StrokeCap.round
          ..shader = legShader,
      );
      canvas.drawLine(
        l[0],
        l[1],
        Paint()
          ..strokeWidth = 1.1 * s
          ..strokeCap = StrokeCap.round
          ..color = _Palette.gold.withOpacity(0.55),
      );
    }
    final pivot = Offset(cx, (yTop + yBot) / 2);
    canvas.drawCircle(
      pivot,
      5.5 * s,
      Paint()
        ..shader = ui.Gradient.linear(
          pivot.translate(0, -5.5 * s),
          pivot.translate(0, 5.5 * s),
          [_Palette.goldLight, _Palette.gold],
        ),
    );

    // Walnut back board with gold inlay.
    final board = RRect.fromLTRBR(
      bl - w * 0.035,
      top - h * 0.04,
      br + w * 0.035,
      bottom + h * 0.035,
      Radius.circular(16 * s),
    );
    canvas.drawRRect(board.shift(Offset(0, 6 * s)), shadowPaint);
    canvas.drawRRect(
      board,
      Paint()
        ..shader = ui.Gradient.linear(
          board.outerRect.topLeft,
          board.outerRect.bottomRight,
          [_Palette.walnutLight, _Palette.walnutDark],
        ),
    );
    canvas.drawRRect(
      board.deflate(5 * s),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2 * s
        ..color = _Palette.gold.withOpacity(0.55),
    );

    // Emerald leather cover.
    final cover = RRect.fromLTRBR(
      bl - w * 0.018,
      top - h * 0.022,
      br + w * 0.018,
      bottom + h * 0.02,
      Radius.circular(9 * s),
    );
    canvas.drawRRect(
      cover,
      Paint()
        ..shader = ui.Gradient.linear(
          cover.outerRect.topCenter,
          cover.outerRect.bottomCenter,
          [_Palette.primary, _Palette.mid],
        ),
    );
    canvas.drawRRect(
      cover,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4 * s
        ..color = _Palette.gold.withOpacity(0.9),
    );

    final left = _page(-1, cx, bw, top, bottom);
    final right = _page(1, cx, bw, top, bottom);

    // Page-stack thickness.
    for (var k = 3; k >= 1; k--) {
      final c = Color.lerp(_Palette.parchment, const Color(0xFFB9A978), k / 3)!;
      for (final pg in [left, right]) {
        canvas.drawPath(pg.shift(Offset(0, k * 2.0 * s)), Paint()..color = c);
      }
    }

    // Pages with pseudo-calligraphic text blocks.
    final framePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1 * s
      ..color = _Palette.gold.withOpacity(0.75);
    final frame2Paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7 * s
      ..color = _Palette.gold.withOpacity(0.40);
    final textPaint = Paint()
      ..strokeWidth = 1.7 * s
      ..strokeCap = StrokeCap.round
      ..color = _Palette.primary.withOpacity(0.62);
    final markerFill = Paint()..color = _Palette.gold.withOpacity(0.35);
    final markerRing = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0 * s
      ..color = _Palette.gold;

    for (final side in const [-1.0, 1.0]) {
      final page = side < 0 ? left : right;
      canvas.drawPath(
        page,
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(cx + side * bw / 2, 0),
            Offset(cx, 0),
            [_Palette.ivory, _Palette.parchment],
          ),
      );

      canvas.save();
      canvas.clipPath(page);

      final x1 = cx + side * bw * 0.07, x2 = cx + side * bw * 0.455;
      final fl = math.min(x1, x2), fr = math.max(x1, x2);
      final ft = top + bh * 0.20, fb = bottom - bh * 0.16;
      final frame = RRect.fromLTRBR(fl, ft, fr, fb, Radius.circular(3 * s));
      canvas.drawRRect(frame, framePaint);
      canvas.drawRRect(frame.deflate(3 * s), frame2Paint);

      const lines = 8;
      final pad = 8 * s;
      final innerL = fl + pad, innerR = fr - pad;
      final innerW = innerR - innerL;
      for (var i = 0; i < lines; i++) {
        final y = ft + pad + (fb - ft - 2 * pad) * i / (lines - 1);
        final stopX = i == lines - 1 ? innerR - innerW * 0.6 : innerL;
        var x = innerR;
        var wi = i * 2;
        while (x > stopX + 4 * s) {
          final frac = _wordFracs[wi % _wordFracs.length];
          wi++;
          if ((i * 3 + wi) % 11 == 0 && x - stopX > 14 * s) {
            final c = Offset(x - 4 * s, y);
            canvas.drawCircle(c, 3.4 * s, markerFill);
            canvas.drawCircle(c, 3.4 * s, markerRing);
            x -= 11 * s;
            continue;
          }
          final end = math.max(x - innerW * frac, stopX);
          canvas.drawLine(Offset(x, y), Offset(end, y), textPaint);
          x = end - 6 * s;
        }
      }
      canvas.restore();

      canvas.drawPath(
        page,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8 * s
          ..color = _Palette.gold.withOpacity(0.4),
      );
    }

    // Warm light spilling across the pages.
    canvas.save();
    canvas.clipPath(Path.combine(PathOperation.union, left, right));
    final hc = Offset(cx, top + bh * 0.35);
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = ui.Gradient.radial(
          hc,
          bw * 0.55,
          [
            _Palette.goldLight.withOpacity(0.30),
            _Palette.goldLight.withOpacity(0),
          ],
        ),
    );
    canvas.restore();

    // Spine shadow.
    final spine = Rect.fromLTRB(
      cx - bw * 0.04,
      top + bh * 0.06,
      cx + bw * 0.04,
      bottom - bh * 0.02,
    );
    canvas.drawRect(
      spine,
      Paint()
        ..shader = ui.Gradient.linear(
          spine.centerLeft,
          spine.centerRight,
          [
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(0.28),
            Colors.black.withOpacity(0),
          ],
          [0, 0.5, 1],
        ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Floating golden motes (loop seamlessly with the 12s ambient controller)
// ─────────────────────────────────────────────────────────────────────────────

class _Mote {
  const _Mote(this.x, this.phase, this.cycles, this.radius, this.sway);
  final double x, phase, radius, sway;
  final int cycles;
}

class _ParticlesPainter extends CustomPainter {
  _ParticlesPainter({required this.reveal, required this.ambient})
    : super(repaint: Listenable.merge([reveal, ambient]));

  final Animation<double> reveal;
  final Animation<double> ambient;

  static final math.Random _rnd = math.Random(11);
  static final List<_Mote> _motes = List.generate(
    26,
    (_) => _Mote(
      _rnd.nextDouble(),
      _rnd.nextDouble(),
      1 + _rnd.nextInt(3),
      0.8 + _rnd.nextDouble() * 1.8,
      6 + _rnd.nextDouble() * 14,
    ),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final r = reveal.value;
    if (r <= 0) return;
    final t = ambient.value;
    final glow = Paint();
    final core = Paint();

    for (final m in _motes) {
      final life = (t * m.cycles + m.phase) % 1.0;
      final y = size.height * (0.95 - life * 0.85);
      final x =
          m.x * size.width +
          math.sin(life * 2 * math.pi + m.phase * 6.28) * m.sway;
      final alpha = math.sin(math.pi * life) * 0.65 * r;
      final c = Offset(x, y);
      glow.color = _Palette.goldLight.withOpacity(alpha * 0.18);
      core.color = _Palette.goldLight.withOpacity(alpha);
      canvas.drawCircle(c, m.radius * 3, glow);
      canvas.drawCircle(c, m.radius, core);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Ornamental divider between title and subtitle
// ─────────────────────────────────────────────────────────────────────────────

class _DividerPainter extends CustomPainter {
  _DividerPainter(this.progress) : super(repaint: progress);

  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final p = progress.value;
    if (p <= 0) return;
    final c = Offset(size.width / 2, size.height / 2);
    final len = (size.width / 2 - 16) * p;

    if (len > 1) {
      for (final dir in const [-1.0, 1.0]) {
        final from = Offset(c.dx + dir * 14, c.dy);
        final to = Offset(c.dx + dir * (14 + len), c.dy);
        canvas.drawLine(
          from,
          to,
          Paint()
            ..strokeWidth = 1.1
            ..strokeCap = StrokeCap.round
            ..shader = ui.Gradient.linear(
              from,
              to,
              [
                _Palette.goldLight.withOpacity(0.9),
                _Palette.gold.withOpacity(0),
              ],
            ),
        );
      }
    }
    canvas.drawPath(
      _octagram(c, 6.5 * p),
      Paint()..color = _Palette.goldLight.withOpacity(p),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Minimal gold loader: a short light sweeping along a hairline track
// ─────────────────────────────────────────────────────────────────────────────

class _LoaderPainter extends CustomPainter {
  _LoaderPainter({required this.ambient}) : super(repaint: ambient);

  final Animation<double> ambient;

  @override
  void paint(Canvas canvas, Size size) {
    final track = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(size.height),
    );
    canvas.drawRRect(track, Paint()..color = _Palette.mint.withOpacity(0.12));

    final u = (ambient.value * 6) % 1.0; // 6 sweeps per 12s loop
    const seg = 24.0;
    final x = (size.width + seg) * u - seg;
    canvas.save();
    canvas.clipRRect(track);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, 0, seg, size.height),
        Radius.circular(size.height),
      ),
      Paint()
        ..shader = ui.Gradient.linear(
          Offset(x, 0),
          Offset(x + seg, 0),
          [
            _Palette.gold.withOpacity(0),
            _Palette.goldLight,
            _Palette.gold.withOpacity(0),
          ],
          [0, 0.5, 1],
        ),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
