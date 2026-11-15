import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n.dart';
import 'theme.dart';

const riderStoreUrl = 'https://play.google.com/store/apps/details?id=com.ojra.rider';
const driverStoreUrl = 'https://play.google.com/store/apps/details?id=com.ojra.driver';
const supportEmail = 'ojra@ojra-dz.com';

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// Localized text helper that switches to the Tifinagh font for Amazigh.
Text t(
  BuildContext context,
  String key, {
  double? size,
  FontWeight? weight = FontWeight.w500,
  Color? color,
  TextAlign? align,
  double? height,
}) {
  final isTifinagh = L10n.instance.isTifinagh;
  return Text(
    L10n.instance.t(key),
    textAlign: align,
    style: isTifinagh
        ? GoogleFonts.notoSansTifinagh(fontSize: size, fontWeight: weight, color: color, height: height)
        : TextStyle(fontSize: size, fontWeight: weight, color: color, height: height),
  );
}

/// Text painted with the neon brand gradient.
class GradientText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final double height;
  const GradientText({super.key, required this.text, this.size = 32, this.weight = FontWeight.w800, this.height = 1.2});

  @override
  Widget build(BuildContext context) {
    final isTifinagh = L10n.instance.isTifinagh;
    return ShaderMask(
      shaderCallback: (bounds) => OjraColors.neonGradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: (isTifinagh ? GoogleFonts.notoSansTifinagh() : const TextStyle()).copyWith(
          fontSize: size,
          fontWeight: weight,
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }
}

class OjraLogo extends StatelessWidget {
  final bool dark;
  const OjraLogo({super.key, this.dark = true});

  @override
  Widget build(BuildContext context) {
    final color = dark ? Colors.white : OjraColors.textPrimary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          child: ClipOval(
            child: Image.asset(
              'assets/images/rider_icon_for_navbar.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'OJRA',
          style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.6),
        ),
      ],
    );
  }
}

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: L10n.instance.t('footerContact'),
      onSelected: L10n.instance.setLocale,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: OjraColors.surface,
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: OjraColors.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: OjraColors.surfaceBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language_rounded, size: 18, color: OjraColors.textSecondary),
            const SizedBox(width: 6),
            Text(
              L10n.localeName(L10n.instance.locale),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: OjraColors.textPrimary),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more_rounded, size: 16, color: OjraColors.textMuted),
          ],
        ),
      ),
      itemBuilder: (context) => [
        for (final code in L10n.locales)
          PopupMenuItem<String>(
            value: code,
            child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: code == L10n.instance.locale ? OjraColors.primary : OjraColors.surfaceBorder,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    code == 'tzm' ? 'ⵜ' : code.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: code == L10n.instance.locale ? Colors.white : OjraColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  L10n.localeName(code),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: code == L10n.instance.locale ? FontWeight.w800 : FontWeight.w500,
                    color: OjraColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class SiteNavbar extends StatelessWidget {
  final void Function(String section) onNavigate;
  const SiteNavbar({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;
    final items = <(String, String)>[
      ('navHome', 'home'),
      ('navWhy', 'why'),
      ('navDrivers', 'drivers'),
      ('navDownload', 'download'),
      ('navTerms', 'terms'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: OjraColors.bg.withValues(alpha: 0.85),
        border: const Border(bottom: BorderSide(color: OjraColors.surfaceBorder)),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Row(
              children: [
                const OjraLogo(),
                const Spacer(),
                if (!isMobile) ...[
                  ...items.map(
                    (e) => TextButton(
                      onPressed: () => onNavigate(e.$2),
                      child: Text(
                        L10n.instance.t(e.$1),
                        style: const TextStyle(color: OjraColors.textSecondary, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const LanguageSwitcher(),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: () => onNavigate('download'),
                    style: FilledButton.styleFrom(minimumSize: const Size(0, 46), padding: const EdgeInsets.symmetric(horizontal: 18)),
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: Text(L10n.instance.t('navDownload'), style: const TextStyle(fontSize: 13)),
                  ),
                ] else ...[
                  const LanguageSwitcher(),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    onSelected: onNavigate,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    color: OjraColors.surface,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: OjraColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: OjraColors.surfaceBorder)),
                      child: const Icon(Icons.menu_rounded, color: OjraColors.textPrimary),
                    ),
                    itemBuilder: (context) => [
                      for (final e in items)
                        PopupMenuItem<String>(
                          value: e.$2,
                          child: Text(L10n.instance.t(e.$1), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: OjraColors.textPrimary)),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0D060A),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const OjraLogo(),
                const SizedBox(height: 16),
                Text(L10n.instance.t('footerTagline'), textAlign: TextAlign.center, style: const TextStyle(color: OjraColors.textSecondary, fontSize: 15)),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TextButton.icon(
                      onPressed: () => openUrl('mailto:$supportEmail'),
                      style: TextButton.styleFrom(foregroundColor: OjraColors.primaryBright),
                      icon: const Icon(Icons.email_rounded, size: 18),
                      label: Text(supportEmail, style: const TextStyle(fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed('/terms'),
                      style: TextButton.styleFrom(foregroundColor: OjraColors.primaryBright),
                      child: Text(L10n.instance.t('navTerms'), style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(color: OjraColors.surfaceBorder),
                const SizedBox(height: 16),
                Text(L10n.instance.t('footerMade'), style: const TextStyle(color: OjraColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 6),
                Text(L10n.instance.t('footerRights'), style: const TextStyle(color: OjraColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String titleKey;
  final String subtitleKey;
  const SectionHeader({super.key, required this.titleKey, required this.subtitleKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        t(context, titleKey, size: 32, weight: FontWeight.w800, color: OjraColors.textPrimary, align: TextAlign.center),
        const SizedBox(height: 12),
        t(context, subtitleKey, size: 16, weight: FontWeight.w500, color: OjraColors.textSecondary, align: TextAlign.center),
      ],
    );
  }
}

/// Animated "electron in a circuit puzzle": a glowing particle travels a
/// closed circuit loop, leaving an exact comet trail. One controller, one
/// isolated repaint layer — very lightweight.
class CircuitPuzzle extends StatefulWidget {
  const CircuitPuzzle({super.key});

  @override
  State<CircuitPuzzle> createState() => _CircuitPuzzleState();
}

class _CircuitPuzzleState extends State<CircuitPuzzle> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 11),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => CustomPaint(
            painter: _CircuitPainter(t: _controller.value),
          ),
        ),
      ),
    );
  }
}

class _CircuitPainter extends CustomPainter {
  final double t;
  _CircuitPainter({required this.t});

  // Closed orthogonal circuit loop (corners, normalized 0..1). Every
  // segment is strictly horizontal or vertical, like a PCB trace.
  static const _loop = [
    Offset(0.14, 0.74),
    Offset(0.14, 0.50),
    Offset(0.26, 0.50),
    Offset(0.26, 0.34),
    Offset(0.42, 0.34),
    Offset(0.42, 0.20),
    Offset(0.58, 0.20),
    Offset(0.58, 0.34),
    Offset(0.70, 0.34),
    Offset(0.70, 0.50),
    Offset(0.86, 0.50),
    Offset(0.86, 0.66),
    Offset(0.70, 0.66),
    Offset(0.70, 0.76),
    Offset(0.56, 0.76),
    Offset(0.56, 0.68),
    Offset(0.46, 0.68),
    Offset(0.46, 0.76),
    Offset(0.34, 0.76),
    Offset(0.34, 0.90),
    Offset(0.20, 0.90),
    Offset(0.20, 0.76),
    Offset(0.14, 0.76),
  ];

  // Decorative "puzzle" traces.
  static const _decor = [
    [Offset(0.08, 0.16), Offset(0.30, 0.16), Offset(0.30, 0.06)],
    [Offset(0.72, 0.10), Offset(0.72, 0.26), Offset(0.92, 0.26)],
    [Offset(0.06, 0.80), Offset(0.20, 0.80), Offset(0.20, 0.92)],
    [Offset(0.88, 0.72), Offset(0.88, 0.84), Offset(0.96, 0.84)],
  ];

  Path _scaledLoop(Size s) {
    final pts = _loop.map((p) => Offset(p.dx * s.width, p.dy * s.height)).toList();
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx, pts[i].dy);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(30));
    canvas.clipRRect(rrect);

    // Background
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF22101B), Color(0xFF160A11)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // Dot grid (puzzle board)
    final dotPaint = Paint()..color = OjraColors.trace.withValues(alpha: 0.6);
    for (int i = 1; i < 8; i++) {
      for (int j = 1; j < 8; j++) {
        canvas.drawCircle(Offset(size.width * i / 8, size.height * j / 8), 1.6, dotPaint);
      }
    }

    // Decorative traces
    final tracePaint = Paint()
      ..color = OjraColors.trace
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (final seg in _decor) {
      final p = Path()..moveTo(seg[0].dx * size.width, seg[0].dy * size.height);
      for (int i = 1; i < seg.length; i++) {
        p.lineTo(seg[i].dx * size.width, seg[i].dy * size.height);
      }
      canvas.drawPath(p, tracePaint);
      for (final v in seg) {
        canvas.drawCircle(Offset(v.dx * size.width, v.dy * size.height), 3.4, Paint()..color = OjraColors.trace);
      }
    }

    // Main circuit loop
    final loop = _scaledLoop(size);
    final metric = loop.computeMetrics().first;

    // Dim full loop
    canvas.drawPath(
      loop,
      Paint()
        ..color = OjraColors.burgundy.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    // Waypoint pads
    for (final p in _loop) {
      canvas.drawCircle(Offset(p.dx * size.width, p.dy * size.height), 3.2, Paint()..color = OjraColors.traceBright);
    }

    final distance = metric.length * t;
    final tangent = metric.getTangentForOffset(distance);

    // Electron
    if (tangent != null) {
      final pos = tangent.position;
      canvas.drawCircle(pos, 16, Paint()..color = OjraColors.amber.withValues(alpha: 0.22));
      canvas.drawCircle(pos, 9, Paint()..color = OjraColors.amber.withValues(alpha: 0.4));
      canvas.drawCircle(pos, 5.5, Paint()..color = OjraColors.amber);
      canvas.drawCircle(pos, 2.2, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant _CircuitPainter oldDelegate) => oldDelegate.t != t;
}

/// App download card with icon + QR code (desktop) or install button (mobile).
class AppCard extends StatelessWidget {
  final String assetPath;
  final String nameKey;
  final String descKey;
  final String storeUrl;
  final bool isDriver;
  const AppCard({super.key, required this.assetPath, required this.nameKey, required this.descKey, required this.storeUrl, this.isDriver = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 720;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: OjraColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: OjraColors.surfaceBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 30, offset: const Offset(0, 14)),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(color: OjraColors.primary.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 8)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(assetPath, width: 96, height: 96, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          t(context, nameKey, size: 20, weight: FontWeight.w800, color: OjraColors.textPrimary, align: TextAlign.center),
          const SizedBox(height: 8),
          t(context, descKey, size: 14, weight: FontWeight.w500, color: OjraColors.textSecondary, align: TextAlign.center),
          const SizedBox(height: 24),
          if (!isMobile) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: QrImageView(
                data: storeUrl,
                version: QrVersions.auto,
                size: 168,
                backgroundColor: Colors.white,
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF1F1A1D)),
                dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF1F1A1D)),
              ),
            ),
            const SizedBox(height: 14),
            t(context, 'scanHint', size: 13, weight: FontWeight.w700, color: OjraColors.primaryBright, align: TextAlign.center),
          ] else ...[
            t(context, 'phoneHint', size: 13, weight: FontWeight.w500, color: OjraColors.textSecondary, align: TextAlign.center),
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => openUrl(storeUrl),
              style: FilledButton.styleFrom(
                backgroundColor: isDriver ? OjraColors.burgundy : OjraColors.primary,
              ),
              icon: const Icon(Icons.shopping_bag_rounded, size: 18),
              label: Text(L10n.instance.t('getOnGooglePlay'), style: const TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
