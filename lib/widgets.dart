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

bool _reduceMotion(BuildContext context) {
  return MediaQuery.maybeDisableAnimationsOf(context) ?? false;
}

/// Animated hero stage: satellite night map, animated route, and Ojra-branded
/// overlay cards. Ported from New Age Factories hero, recolored to Ojra palette.
class CircuitPuzzle extends StatefulWidget {
  const CircuitPuzzle({super.key});

  @override
  State<CircuitPuzzle> createState() => _CircuitPuzzleState();
}

class _CircuitPuzzleState extends State<CircuitPuzzle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _routeController;
  double _rotateX = 0;
  double _rotateY = 0;
  Duration _tiltDuration = const Duration(milliseconds: 240);

  @override
  void initState() {
    super.initState();
    _routeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _routeController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event) {
    final box = context.findRenderObject();
    if (box is! RenderBox) return;
    final nx = (event.localPosition.dx / box.size.width - 0.5).clamp(-0.5, 0.5);
    final ny = (event.localPosition.dy / box.size.height - 0.5).clamp(-0.5, 0.5);
    setState(() {
      _rotateX = -ny * 0.035;
      _rotateY = nx * 0.045;
      _tiltDuration = const Duration(milliseconds: 120);
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _tiltDuration = const Duration(milliseconds: 450);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final scale = (width / 540).clamp(0.72, 1.0);
        final height = (width * 1.02).clamp(360.0, 540.0);
        final wide = width >= 420;
        return MouseRegion(
          onHover: _onHover,
          onExit: _onExit,
          child: AnimatedContainer(
            duration: _tiltDuration,
            curve: Curves.easeOutCubic,
            height: height,
            transformAlignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0011)
              ..rotateX(_rotateX)
              ..rotateY(_rotateY),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 10,
                  right: -24,
                  child: IgnorePointer(
                    child: Container(
                      width: 260 * scale,
                      height: 260 * scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            OjraColors.primary.withValues(alpha: 0.22),
                            OjraColors.amber.withValues(alpha: 0.08),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      border: Border.all(color: OjraColors.surfaceBorder),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2A101D), Color(0xFF140910)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 80,
                          spreadRadius: -20,
                          offset: const Offset(0, 35),
                        ),
                        BoxShadow(
                          color: OjraColors.primary.withValues(alpha: 0.10),
                          blurRadius: 70,
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/hero_earth.jpg',
                            fit: BoxFit.cover,
                            semanticLabel: 'Satellite view of illuminated cities at night',
                          ),
                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0x22120810),
                                  Color(0x99120810),
                                  Color(0xF2120810),
                                ],
                                stops: [0, 0.55, 1],
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  OjraColors.primaryBright.withValues(alpha: 0.14),
                                  Colors.transparent,
                                  OjraColors.burgundy.withValues(alpha: 0.20),
                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(
                                painter: _RoutePainter(progress: _routeController),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 18,
                            left: 18,
                            child: _GlassPill(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: OjraColors.amber,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: OjraColors.amber.withValues(alpha: 0.7),
                                          blurRadius: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    'LIVE NETWORK',
                                    style: TextStyle(
                                      fontSize: 7.8,
                                      fontWeight: FontWeight.w700,
                                      color: OjraColors.textPrimary.withValues(alpha: 0.9),
                                      letterSpacing: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 21,
                            right: 20,
                            child: Text(
                              'OJRA / LIVE',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: OjraColors.textMuted,
                                letterSpacing: 1.6,
                              ),
                            ),
                          ),
                          if (wide)
                            Positioned(
                              left: -20,
                              top: height * 0.30,
                              child: const _FloatingDispatchCard(),
                            ),
                          Positioned(
                            right: 20,
                            top: height * 0.26,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: OjraColors.bg.withValues(alpha: 0.72),
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: OjraColors.surfaceBorder),
                              ),
                              child: Text(
                                'RIDER · DRIVER · LIVE',
                                style: TextStyle(
                                  fontSize: 7.2,
                                  fontWeight: FontWeight.w700,
                                  color: OjraColors.primaryBright,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            right: 18,
                            bottom: 18,
                            child: _HeroInfoCard(wide: wide),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -14,
                  left: wide ? -6 : 24,
                  child: Transform.rotate(
                    angle: 0.78539816339,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: OjraColors.amber,
                        boxShadow: [
                          BoxShadow(
                            color: OjraColors.amber.withValues(alpha: 0.65),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GlassPill extends StatelessWidget {
  const _GlassPill({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: OjraColors.bg.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Colors.white.withValues(alpha: 0.11)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FloatingDispatchCard extends StatefulWidget {
  const _FloatingDispatchCard();

  @override
  State<_FloatingDispatchCard> createState() => _FloatingDispatchCardState();
}

class _FloatingDispatchCardState extends State<_FloatingDispatchCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offset = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    final card = Container(
      width: 202,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: OjraColors.bgElevated.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 38,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt_rounded, size: 12, color: OjraColors.amber),
              const SizedBox(width: 5),
              const Text(
                'LIVE DISPATCH',
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w700,
                  color: OjraColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              const Text(
                'NOW',
                style: TextStyle(
                  fontSize: 6.5,
                  fontWeight: FontWeight.w700,
                  color: OjraColors.amber,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Nearby drivers matched in seconds.',
            style: TextStyle(
              fontSize: 10.5,
              color: OjraColors.textPrimary,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.72,
                    minHeight: 3,
                    backgroundColor: Colors.white.withValues(alpha: 0.06),
                    valueColor: const AlwaysStoppedAnimation(OjraColors.primaryBright),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '72%',
                style: TextStyle(
                  fontSize: 6.5,
                  fontWeight: FontWeight.w700,
                  color: OjraColors.textMuted,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    if (_reduceMotion(context)) return card;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(offset: Offset(0, offset.value), child: child);
      },
      child: card,
    );
  }
}

class _HeroInfoCard extends StatelessWidget {
  const _HeroInfoCard({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: OjraColors.bgElevated.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.11)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
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
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: OjraColors.brandGradient,
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: OjraColors.primary.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                'assets/images/rider_icon.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'OJRA',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: OjraColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: OjraColors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'RIDER · DRIVER',
                      style: TextStyle(
                        fontSize: 6.5,
                        fontWeight: FontWeight.w700,
                        color: OjraColors.textMuted,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  wide ? 'Safe, fast rides across Algeria' : 'Safe, fast rides',
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: OjraColors.textSecondary,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: OjraColors.primary.withValues(alpha: 0.18),
              border: Border.all(color: OjraColors.surfaceBorder),
            ),
            child: const Icon(
              Icons.directions_car_rounded,
              size: 14,
              color: OjraColors.primaryBright,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  _RoutePainter({required this.progress}) : super(repaint: progress);

  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.02, size.height * 0.66)
      ..cubicTo(
        size.width * 0.23, size.height * 0.50,
        size.width * 0.35, size.height * 0.62,
        size.width * 0.51, size.height * 0.47,
      )
      ..cubicTo(
        size.width * 0.68, size.height * 0.32,
        size.width * 0.76, size.height * 0.45,
        size.width * 0.98, size.height * 0.20,
      );

    final shader = LinearGradient(
      colors: [
        OjraColors.primaryBright.withValues(alpha: 0.0),
        OjraColors.primaryBright.withValues(alpha: 0.50),
        OjraColors.amber.withValues(alpha: 0.45),
        Colors.transparent,
      ],
      stops: const [0, 0.18, 0.75, 1],
    ).createShader(Offset.zero & size);

    canvas.drawPath(
      path,
      Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9),
    );
    canvas.drawPath(
      path,
      Paint()
        ..shader = shader
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    final metric = path.computeMetrics().first;
    for (final t in [0.15, 0.31, 0.48, 0.64, 0.8]) {
      final tangent = metric.getTangentForOffset(metric.length * t);
      if (tangent == null) continue;
      canvas.drawCircle(
        tangent.position, 2,
        Paint()..color = Colors.white.withValues(alpha: 0.65),
      );
      canvas.drawCircle(
        tangent.position, 5.5,
        Paint()..color = OjraColors.primaryBright.withValues(alpha: 0.10),
      );
    }

    final head = metric.getTangentForOffset(metric.length * (0.1 + progress.value * 0.8));
    if (head != null) {
      canvas.drawCircle(head.position, 11, Paint()..color = OjraColors.amber.withValues(alpha: 0.14));
      canvas.drawCircle(head.position, 4.5, Paint()..color = OjraColors.primaryBright.withValues(alpha: 0.25));
      canvas.drawCircle(head.position, 1.8, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => false;
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
