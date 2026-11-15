import 'package:flutter_test/flutter_test.dart';
import 'package:ojra_website/l10n.dart';

void main() {
  test('L10n defaults to Arabic (RTL)', () {
    expect(L10n.instance.locale, 'ar');
    expect(L10n.instance.isRtl, isTrue);
  });

  test('L10n falls back to English for missing translations', () {
    expect(L10n.instance.t('brandName'), 'أودجرا');
  });

  test('L10n exposes the four supported locales', () {
    expect(L10n.locales, containsAll(['ar', 'fr', 'en', 'tzm']));
  });
}
