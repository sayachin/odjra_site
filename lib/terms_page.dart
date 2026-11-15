import 'package:flutter/material.dart';

import 'l10n.dart';
import 'theme.dart';
import 'widgets.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.instance;
    final showNotice = l10n.isTifinagh;
    final termsText = l10n.terms;

    return Scaffold(
      backgroundColor: OjraColors.bg,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      t(context, 'termsTitle', size: 34, weight: FontWeight.w800, color: OjraColors.textPrimary),
                      const SizedBox(height: 8),
                      t(context, 'termsUpdated', size: 14, weight: FontWeight.w500, color: OjraColors.textMuted),
                      const SizedBox(height: 28),
                      if (showNotice) ...[
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: OjraColors.amber.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: OjraColors.amber.withValues(alpha: 0.4)),
                          ),
                          child: t(context, 'tzmTermsNotice', size: 15, weight: FontWeight.w600, height: 1.6, color: OjraColors.amberSoft),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: OjraColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: OjraColors.surfaceBorder),
                        ),
                        child: Text(
                          termsText,
                          textDirection: l10n.isRtl ? TextDirection.rtl : TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.8,
                            color: OjraColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SiteFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: OjraColors.bg,
        border: Border(bottom: BorderSide(color: OjraColors.surfaceBorder)),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded, color: OjraColors.textPrimary),
                ),
                const SizedBox(width: 4),
                const OjraLogo(),
                const Spacer(),
                const LanguageSwitcher(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
