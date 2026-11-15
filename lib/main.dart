import 'package:flutter/material.dart';

import 'landing_page.dart';
import 'l10n.dart';
import 'terms_page.dart';
import 'theme.dart';

void main() {
  runApp(const OjraWebsite());
}

class OjraWebsite extends StatelessWidget {
  const OjraWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: L10n.instance,
      builder: (context, _) {
        final locale = L10n.instance.locale;
        final isRtl = L10n.instance.isRtl;
        return MaterialApp(
          // Key forces a full rebuild of the widget tree when the language
          // changes, so every localized string updates immediately.
          key: ValueKey(locale),
          debugShowCheckedModeBanner: false,
          title: 'Ojra',
          theme: buildAppTheme(),
          initialRoute: '/',
          routes: {
            '/': (_) => const LandingPage(),
            '/terms': (_) => const TermsPage(),
          },
          builder: (context, child) {
            return Directionality(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: child!,
            );
          },
        );
      },
    );
  }
}
