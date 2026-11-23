import 'package:flutter/material.dart';

import 'l10n.dart';
import 'theme.dart';
import 'widgets.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _scrollController = ScrollController();
  final _whyKey = GlobalKey();
  final _driversKey = GlobalKey();
  final _downloadKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigate(String section) {
    switch (section) {
      case 'home':
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOutCubic);
        break;
      case 'terms':
        Navigator.of(context).pushNamed('/terms');
        break;
      case 'why':
        _scrollTo(_whyKey);
        break;
      case 'drivers':
        _scrollTo(_driversKey);
        break;
      case 'download':
        _scrollTo(_downloadKey);
        break;
    }
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 500), curve: Curves.easeOutCubic, alignment: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OjraColors.bg,
      body: Column(
        children: [
          SiteNavbar(onNavigate: _navigate),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildHero(),
                  _buildStats(),
                  _buildWhy(key: _whyKey),
                  _buildDrivers(key: _driversKey),
                  _buildHowItWorks(),
                  _buildDownload(key: _downloadKey),
                  _buildTermsBanner(),
                  const SiteFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- HERO
  Widget _buildHero() {
    final isDesktop = MediaQuery.of(context).size.width >= 980;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.6, -0.6),
          radius: 1.3,
          colors: [Color(0xFF2A0E1D), OjraColors.bg],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: isDesktop ? _heroRow() : _heroColumn(),
        ),
      ),
    );
  }

  Widget _heroRow() {
    return Row(
      children: [
        Expanded(flex: 6, child: _heroCopy()),
        const SizedBox(width: 48),
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: OjraColors.surfaceBorder),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 50, offset: const Offset(0, 24)),
              ],
            ),
            child: const CircuitPuzzle(),
          ),
        ),
      ],
    );
  }

  Widget _heroColumn() {
    return Column(
      children: [
        _heroCopy(),
        const SizedBox(height: 40),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: OjraColors.surfaceBorder),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 36, offset: const Offset(0, 18)),
              ],
            ),
            child: const CircuitPuzzle(),
          ),
        ),
      ],
    );
  }

  Widget _heroCopy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: OjraColors.primary.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: OjraColors.primary.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bolt_rounded, size: 16, color: OjraColors.amber),
              const SizedBox(width: 6),
              t(context, 'heroBadge', size: 13, weight: FontWeight.w700, color: OjraColors.primaryBright),
            ],
          ),
        ),
        const SizedBox(height: 22),
        GradientText(text: L10n.instance.t('heroTitle'), size: 48, weight: FontWeight.w900, height: 1.22),
        const SizedBox(height: 18),
        t(context, 'heroSubtitle', size: 17, weight: FontWeight.w500, color: OjraColors.textSecondary, height: 1.6),
        const SizedBox(height: 32),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            FilledButton.icon(
              onPressed: () => _navigate('download'),
              style: FilledButton.styleFrom(backgroundColor: OjraColors.amber, foregroundColor: Color(0xFF221000)),
              icon: const Icon(Icons.download_rounded, size: 20),
              label: t(context, 'heroCtaRider', size: 15, weight: FontWeight.w800, color: const Color(0xFF221000)),
            ),
            OutlinedButton.icon(
              onPressed: () => _navigate('drivers'),
              style: OutlinedButton.styleFrom(
                foregroundColor: OjraColors.textPrimary,
                side: const BorderSide(color: OjraColors.surfaceBorder),
              ),
              icon: const Icon(Icons.directions_car_rounded, size: 20, color: OjraColors.primaryBright),
              label: t(context, 'heroCtaDriver', size: 15, weight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------- STATS
  Widget _buildStats() {
    final stats = ['featurePrivacyTitle', 'featureFareTitle', 'featureCashTitle', 'feature247Title', 'featureLocalTitle'];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: OjraColors.bgElevated,
        border: Border.symmetric(horizontal: BorderSide(color: OjraColors.surfaceBorder)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 0,
            runSpacing: 14,
            children: [
              for (int i = 0; i < stats.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 18, color: OjraColors.amber),
                      const SizedBox(width: 8),
                      t(context, stats[i], size: 15, weight: FontWeight.w700, color: OjraColors.textSecondary),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- WHY
  Widget _buildWhy({required Key key}) {
    final features = <(IconData, Color, String, String)>[
      (Icons.phone_locked_rounded, OjraColors.primaryBright, 'featurePrivacyTitle', 'featurePrivacyDesc'),
      (Icons.receipt_long_rounded, OjraColors.primary, 'featureFareTitle', 'featureFareDesc'),
      (Icons.payments_rounded, OjraColors.amber, 'featureCashTitle', 'featureCashDesc'),
      (Icons.location_searching_rounded, OjraColors.primaryBright, 'featureTrackTitle', 'featureTrackDesc'),
      (Icons.access_time_filled_rounded, OjraColors.burgundy, 'feature247Title', 'feature247Desc'),
      (Icons.flag_rounded, OjraColors.primary, 'featureLocalTitle', 'featureLocalDesc'),
      (Icons.shield_rounded, OjraColors.amber, 'featureSafetyTitle', 'featureSafetyDesc'),
    ];

    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              const SectionHeader(titleKey: 'whyTitle', subtitleKey: 'whySubtitle'),
              const SizedBox(height: 44),
              _cardGrid([
                for (final f in features) _FeatureCard(icon: f.$1, color: f.$2, titleKey: f.$3, descKey: f.$4),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------ DRIVERS
  Widget _buildDrivers({required Key key}) {
    final points = <(IconData, String, String)>[
      (Icons.schedule_rounded, 'driverP1Title', 'driverP1Desc'),
      (Icons.trending_up_rounded, 'driverP2Title', 'driverP2Desc'),
      (Icons.bolt_rounded, 'driverP3Title', 'driverP3Desc'),
      (Icons.visibility_rounded, 'driverP4Title', 'driverP4Desc'),
      (Icons.headset_mic_rounded, 'driverP5Title', 'driverP5Desc'),
      (Icons.auto_awesome_rounded, 'driverP6Title', 'driverP6Desc'),
    ];

    return Container(
      key: key,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2A0E1D), OjraColors.bgElevated],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              const SectionHeader(titleKey: 'driverTitle', subtitleKey: 'driverSubtitle'),
              const SizedBox(height: 44),
              _cardGrid([
                for (final p in points) _DriverPoint(icon: p.$1, titleKey: p.$2, descKey: p.$3),
              ]),
              const SizedBox(height: 44),
              FilledButton.icon(
                onPressed: () => openUrl(driverStoreUrl),
                style: FilledButton.styleFrom(
                  backgroundColor: OjraColors.amber,
                  foregroundColor: const Color(0xFF221000),
                  minimumSize: const Size(260, 56),
                ),
                icon: const Icon(Icons.rocket_launch_rounded, size: 20),
                label: t(context, 'driverCta', size: 16, weight: FontWeight.w800, color: const Color(0xFF221000)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------- HOW IT WORKS
  Widget _buildHowItWorks() {
    final steps = <(int, IconData, String, String)>[
      (1, Icons.my_location_rounded, 'howS1Title', 'howS1Desc'),
      (2, Icons.person_pin_circle_rounded, 'howS2Title', 'howS2Desc'),
      (3, Icons.paid_rounded, 'howS3Title', 'howS3Desc'),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              const SectionHeader(titleKey: 'howTitle', subtitleKey: 'howSubtitle'),
              const SizedBox(height: 44),
              _cardGrid([
                for (final s in steps)
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: OjraColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: OjraColors.surfaceBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _stepNumber(s.$1),
                        const SizedBox(height: 20),
                        Icon(s.$2, size: 34, color: OjraColors.primaryBright),
                        const SizedBox(height: 14),
                        t(context, s.$3, size: 18, weight: FontWeight.w800, color: OjraColors.textPrimary),
                        const SizedBox(height: 8),
                        t(context, s.$4, size: 14, weight: FontWeight.w500, color: OjraColors.textSecondary, height: 1.5),
                      ],
                    ),
                  ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------- DOWNLOAD
  Widget _buildDownload({required Key key}) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              const SectionHeader(titleKey: 'downloadTitle', subtitleKey: 'downloadSubtitle'),
              const SizedBox(height: 44),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 980;
                  final cards = <Widget>[
                    AppCard(
                      assetPath: 'assets/images/rider_icon.png',
                      nameKey: 'riderAppName',
                      descKey: 'riderAppDesc',
                      storeUrl: riderStoreUrl,
                    ),
                    AppCard(
                      assetPath: 'assets/images/driver_icon.png',
                      nameKey: 'driverAppName',
                      descKey: 'driverAppDesc',
                      storeUrl: driverStoreUrl,
                      isDriver: true,
                    ),
                  ];
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: cards[0]),
                        const SizedBox(width: 24),
                        Expanded(child: cards[1]),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      cards[0],
                      const SizedBox(height: 24),
                      cards[1],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------- TERMS BANNER
  Widget _buildTermsBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [OjraColors.burgundy, OjraColors.primary]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: OjraColors.primary.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.description_rounded, color: Colors.white, size: 34),
                const SizedBox(width: 18),
                Expanded(
                  child: t(context, 'readTerms', size: 16, weight: FontWeight.w700, color: Colors.white),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pushNamed('/terms'),
                  style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: OjraColors.burgundy),
                  child: const Icon(Icons.arrow_forward_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------- helpers
  Widget _cardGrid(List<Widget> cards) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        int cols = w >= 1000 ? 3 : (w >= 640 ? 2 : 1);
        const gap = 20.0;
        final cardW = (w - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [for (final c in cards) SizedBox(width: cardW, child: c)],
        );
      },
    );
  }

  Widget _stepNumber(int n) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: OjraColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: OjraColors.primary.withValues(alpha: 0.4)),
      ),
      child: Text('$n', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: OjraColors.primaryBright)),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String titleKey;
  final String descKey;
  const _FeatureCard({required this.icon, required this.color, required this.titleKey, required this.descKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: OjraColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: OjraColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withValues(alpha: 0.35)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 18),
          t(context, titleKey, size: 17, weight: FontWeight.w800, color: OjraColors.textPrimary),
          const SizedBox(height: 8),
          t(context, descKey, size: 14, weight: FontWeight.w500, color: OjraColors.textSecondary, height: 1.55),
        ],
      ),
    );
  }
}

class _DriverPoint extends StatelessWidget {
  final IconData icon;
  final String titleKey;
  final String descKey;
  const _DriverPoint({required this.icon, required this.titleKey, required this.descKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: OjraColors.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: OjraColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: OjraColors.amber, size: 30),
          const SizedBox(height: 16),
          t(context, titleKey, size: 17, weight: FontWeight.w800, color: OjraColors.textPrimary),
          const SizedBox(height: 8),
          t(context, descKey, size: 14, weight: FontWeight.w500, color: OjraColors.textSecondary, height: 1.55),
        ],
      ),
    );
  }
}
