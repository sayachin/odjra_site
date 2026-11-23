import 'package:flutter/widgets.dart';

import 'terms_text.dart';

/// Lightweight localization controller. Arabic is the default locale.
class L10n extends ChangeNotifier {
  L10n._();
  static final L10n instance = L10n._();

  static const locales = <String>['ar', 'fr', 'en', 'tzm'];

  String _locale = 'ar';
  String get locale => _locale;
  bool get isRtl => _locale == 'ar';
  bool get isTifinagh => _locale == 'tzm';

  void setLocale(String value) {
    if (value == _locale || !locales.contains(value)) return;
    _locale = value;
    notifyListeners();
  }

  String t(String key) {
    final entry = _strings[key];
    if (entry == null) return key;
    return entry[_locale] ?? entry['en'] ?? key;
  }

  /// Full terms text for the current locale (falls back to Arabic for Tifinagh).
  String get terms => termsByLocale[_locale] ?? termsByLocale['ar']!;

  /// Display name of a locale, written in that language itself.
  static String localeName(String code) {
    switch (code) {
      case 'ar':
        return 'العربية';
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      case 'tzm':
        return 'ⵜⴰⵎⴰⵣⵉⵖⵜ';
      default:
        return code;
    }
  }
}

final Map<String, Map<String, String>> _strings = {
  // Brand
  'brandName': {
    'ar': 'أجرة',
    'fr': 'Ojra',
    'en': 'Ojra',
    'tzm': 'ⵓⴷⵊⵔⴰ',
  },
  'tagline': {
    'ar': 'مشوارك… بلمسة واحدة',
    'fr': 'Votre trajet, en un geste',
    'en': 'Your ride, one tap away',
    'tzm': 'ⴰⴱⵔⵉⴷ ⵏⵏⴽ ⵙ ⵢⴰⵜ ⵜⵉⵏⵏⵉⵜ',
  },
  'heroBadge': {
    'ar': 'خدمة التنقّل الجزائرية',
    'fr': 'Le covoiturage algérien',
    'en': "Algeria's rideshare",
    'tzm': 'ⵜⴰⵙⵏⵓⴱⴳⵜ ⵏ ⴷⵣⴰⵢⵔ',
  },
  'heroTitle': {
    'ar': 'تنقّل بكل ثقة\nفي الجزائر',
    'fr': 'Roulez en toute confiance\nen Algérie',
    'en': 'Move with confidence\nacross Algeria',
    'tzm': 'ⵉⵏⵉⴳ ⵙ ⵓⴼⵔⴰⵀ\nⴷⵉ ⴷⵣⴰⵢⵔ',
  },
  'heroSubtitle': {
    'ar': 'تطبيق واحد يوصلك أينما كنت. أسعار ثابتة، دفع نقدي، وتتبّع مباشر لرحلتك.',
    'fr': "Une seule app pour vous déplacer partout. Tarifs fixes, paiement en espèces et suivi en direct.",
    'en': 'One app to get you anywhere. Fixed fares, cash payment, and live ride tracking.',
    'tzm': 'ⵢⴰⵏ ⵓⵙⵏⴼⴰⵔ ⴰⴷ ⴽ ⵢⴰⵡⵉ ⵖ ⴽⵓⵍⵍⵓ ⴰⴷⵖⴰⵔ.',
  },
  'heroCtaRider': {
    'ar': 'حمّل التطبيق',
    'fr': "Télécharger l'app passager",
    'en': 'Get the rider app',
    'tzm': 'ⵙⴷⵔⵙ ⴰⵙⵏⴼⴰⵔ ⵏ ⵓⵔⴰⴽⴰⴱ',
  },
  'heroCtaDriver': {
    'ar': 'كن سائقاًً',
    'fr': 'Devenir chauffeur partenaire',
    'en': 'Become a driver partner',
    'tzm': 'ⴰⵡⴹ ⴰⵎⵙⴻⴱⵔⵉⴷ',
  },

  // Navigation
  'navHome': {'ar': 'الرئيسية', 'fr': 'Accueil', 'en': 'Home', 'tzm': 'ⴰⵙⵏⵓⴱⴳ'},
  'navWhy': {'ar': 'لماذا أجره؟', 'fr': 'Pourquoi Ojra', 'en': 'Why Ojra', 'tzm': 'ⵎⴰⵅⴼ ⵓⴷⵊⵔⴰ'},
  'navDrivers': {'ar': 'السائقون', 'fr': 'Chauffeurs', 'en': 'Drivers', 'tzm': 'ⵉⵏⵙⴻⴱⵔⵉⴷⵏ'},
  'navDownload': {'ar': 'التطبيقات', 'fr': 'Applications', 'en': 'Apps', 'tzm': 'ⵉⵙⵏⴼⴰⵔⵏ'},
  'navTerms': {'ar': 'الشروط والأحكام', 'fr': 'Conditions', 'en': 'Terms', 'tzm': 'ⵜⵉⴼⴰⴷⵉⵡⵉⵏ'},

  // Why riders trust us
  'whyTitle': {
    'ar': 'لماذا يثق بنا الزبائن؟',
    'fr': 'Pourquoi les passagers nous font confiance',
    'en': 'Why riders trust us',
    'tzm': 'ⵎⴰⵅⴼ ⴰ ⵖ ⵜⵜⴰⵎⴰⵏⵏ ⵉⵎⵙⵏⵉⴳ',
  },
  'whySubtitle': {
    'ar': 'صمّمنا أجرة ليكون بسيطاً وموثوقاً ومحلياً.',
    'fr': 'Ojra est pensé simple, fiable et local.',
    'en': 'Ojra is built to be simple, reliable and local.',
    'tzm': 'ⵓⴷⵊⵔⴰ ⵢⴻⵙⵏⴼⴰⵍ ⴰⴷ ⵢⵉⵍⵉ ⴼⵙⵓⵙ, ⵢⵓⵎⵏ ⴷ ⴰⴷⵖⴰⵔⴰⵏ.',
  },
  'featurePrivacyTitle': {
    'ar': 'مكالمات خاصة بدون مشاركة الرقم',
    'fr': 'Appels privés, sans partage de numéro',
    'en': 'Private calls, no number sharing',
    'tzm': 'ⵜⵉⵖⵔⵉⵡⵏ ⵜⵉⴷⵓⵙⵏⵉⵏ, ⵡⴰⵔ ⴰⴱⴹⵓ ⵏ ⵓⵟⵟⵓⵏ',
  },
  'featurePrivacyDesc': {
    'ar': 'يتحدث الركاب والسائقون عبر مكالمات آمنة داخل التطبيق. أرقام الهواتف لا تتم مشاركتها أبداً.',
    'fr': 'Passagers et chauffeurs se parlent par appels sécurisés dans l’application. Les numéros ne sont jamais partagés.',
    'en': 'Riders and drivers talk through secure in-app VoIP calls. Phone numbers are never shared.',
    'tzm': 'ⵉⵎⵓⴷⴰⵔ ⴷ ⵉⵎⵙⴻⴱⵔⵉⴷⴻⵏ ⵙⴰⵡⴰⵍⴻⵏ ⵙ ⵜⵉⵖⵔⵉⵡⵏ ⵉⴷⵓⵙⵏⵉⵏ ⴳ ⵓⵙⴻⵏⴼⴰⵔ. ⵓⵟⵟⵓⵏⴻⵏ ⵏ ⵜⴼⴰⵙⵏⵉⵡⵉⵏ ⵓⵔ ⵜⵜⴱⴹⴰⵏ ⴰⵔⴰ.',
  },
  'featureFareTitle': {'ar': 'سعر ثابت ومعلن', 'fr': 'Tarif fixe et transparent', 'en': 'Fixed, upfront fares', 'tzm': 'ⴰⵜⵉⴳ ⵢⵓⵎⵏ'},
  'featureFareDesc': {
    'ar': 'اعرف ثمن مشوارك قبل أن تطلب الرحلة. لا مفاجآت.',
    'fr': 'Connaissez le prix avant de commander. Aucune surprise.',
    'en': 'Know your price before you request. No surprises.',
    'tzm': 'ⵣⵔ ⴰⵜⵉⴳ ⵏ ⵓⴱⵔⵉⴷ ⵏⵏⴽ ⵓⵔ ⵜⴰ ⵜⵜⵔⴰ.',
  },
  'featureCashTitle': {'ar': 'الدفع نقداً', 'fr': 'Paiement en espèces', 'en': 'Pay in cash', 'tzm': 'ⵅⵍⵍⵚ ⵙ ⵉⴷⵔⵉⵎⵏ'},
  'featureCashDesc': {
    'ar': 'لا حاجة لبطاقة بنكية. ادفع كما تفضّل.',
    'fr': 'Pas besoin de carte. Payez comme vous voulez.',
    'en': 'No card needed. Pay the way you like.',
    'tzm': 'ⵓⵔ ⵜⵃⵡⴰⵊ ⴽⴰⵕⴰ. ⵅⵍⵍⵚ ⴰⴽⴽⵏ ⵉ ⵜⵅⵙ.',
  },
  'featureTrackTitle': {'ar': 'تتبّع مباشر', 'fr': 'Suivi en direct', 'en': 'Live tracking', 'tzm': 'ⴰⵣⵣⵔⴰⵢ ⵏ ⵓⵙⵡⵉⵔ'},
  'featureTrackDesc': {
    'ar': 'تابع سائقك على الخريطة لحظة بلحظة.',
    'fr': 'Suivez votre chauffeur sur la carte en temps réel.',
    'en': 'Follow your driver on the map in real time.',
    'tzm': 'ⵣⵔ ⴰⵎⵙⴻⴱⵔⵉⴷ ⵏⵏⴽ ⵖ ⵜⴽⴰⵕⴹⴰ.',
  },
  'feature247Title': {'ar': 'متاح 24/7', 'fr': 'Disponible 24h/24', 'en': 'Available 24/7', 'tzm': 'ⵢⴻⵍⵍⴰ 24/7'},
  'feature247Desc': {
    'ar': 'رحلة متاحة في أي وقت، نهاراً وليلاً.',
    'fr': 'Un trajet à toute heure, de jour comme de nuit.',
    'en': 'A ride any time, day or night.',
    'tzm': 'ⴰⴱⵔⵉⴷ ⴷⵉ ⴽⵓ ⴰⴽⵓⴷ, ⴰⵣⴰⵍ ⵏⵖ ⵉⴹ.',
  },
  'featureLocalTitle': {'ar': 'شركة جزائرية', 'fr': 'Une entreprise algérienne', 'en': 'A local Algerian company', 'tzm': 'ⵜⴰⵎⵙⵙⵏⵜ ⵜⴰⴷⵣⴰⵢⵔⵉⵜ'},
  'featureLocalDesc': {
    'ar': 'فريق محلي يفهم مدنكم وطرقكم.',
    'fr': 'Une équipe locale qui connaît vos villes et vos routes.',
    'en': 'A local team that knows your cities and roads.',
    'tzm': 'ⵜⴰⵔⴰⴱⴱⵓⵜ ⵜⴰⴷⵖⴰⵔⴰⵏⵜ ⵜⵙⵙⵏ ⵜⵉⵖⵔⵎⵉⵏ ⵏⵏⵓⵏ.',
  },
  'featureSafetyTitle': {'ar': 'أمانك أولاً', 'fr': "Votre sécurité d'abord", 'en': 'Safety first', 'tzm': 'ⵜⴰⵀⴻⵍⵍⵉ ⵜⴰⵎⵣⵡⴰⵔⵓⵜ'},
  'featureSafetyDesc': {
    'ar': 'قواعد سلوك واضحة وفريق دعم متاح.',
    'fr': 'Des règles claires et un support disponible.',
    'en': 'Clear conduct rules and a support team on hand.',
    'tzm': 'ⵉⵍⵓⴳⴰⵏ ⵉⴼⵙⵙⴻⵏ ⴷ ⵜⴰⵔⴰⴱⴱⵓⵜ ⵏ ⵓⵎⵙⵉⵡⴷ.',
  },

  // Driver partners
  'driverTitle': {
    'ar': 'قُد سيارتك… وكن رئيس نفسك',
    'fr': 'Conduisez. Soyez votre propre patron.',
    'en': 'Drive. Be your own boss.',
    'tzm': 'ⵙⵓⵀⵓ ⴰⴽⴰⵔⵔⵓⵙ. ⴰⵡⴹ ⴰⵎⵙⵙⴰⵄⴰⴷ ⵏ ⵢⵉⵎⴰⵏ ⵏⵏⴽ.',
  },
  'driverSubtitle': {
    'ar': 'انضم إلى شركاء مستقلّين يكسبون دخلهم بشروطهم الخاصة.',
    'fr': 'Rejoignez des partenaires indépendants qui gagnent selon leurs propres conditions.',
    'en': 'Join independent partners earning on their own terms.',
    'tzm': 'ⴷⵓⴽⴽⵍ ⴷ ⵉⵎⴷⴷⵓⴽⴽⴰⵍ ⵉⵍⴻⵍⵍⵉⵢⵏ ⵢⴻⵜⵜⵅⴷⴷⵎⵏ ⵙ ⵢⵉⵎⴰⵏ ⵏⵏⵙⵏ.',
  },
  'driverP1Title': {'ar': 'جدولك، شروطك', 'fr': 'Votre emploi du temps, vos règles', 'en': 'Your schedule, your rules', 'tzm': 'ⴰⴽⵓⴷ ⵏⵏⴽ, ⵉⵍⵓⴳⴰⵏ ⵏⵏⴽ'},
  'driverP1Desc': {
    'ar': 'اعمل متى شئت، بلا نوبات إجبارية ولا مدير يراقبك.',
    'fr': 'Conduisez quand vous voulez, sans horaires imposés ni manager.',
    'en': 'Drive whenever you want — no forced shifts, no boss.',
    'tzm': 'ⵅⴷⴷⵎ ⵎⵉ ⵜⵅⵙ, ⴱⵍⴰ ⵉⵡⴹⴰⵏ ⵏⵖ ⴰⵏⴼⴰⵍ.',
  },
  'driverP2Title': {'ar': 'دخل واضح', 'fr': 'Des revenus clairs', 'en': 'Clear earnings', 'tzm': 'ⵜⵉⵡⵓⵔⵉⵡⵉⵏ ⵉⴼⵙⵙⴻⵏ'},
  'driverP2Desc': {
    'ar': 'اعرف ما تكسبه في كل مشوار، مع دفعات منتظمة.',
    'fr': 'Sachez ce que vous gagnez à chaque course, avec des paiements réguliers.',
    'en': 'Know what you earn per ride, with regular payouts.',
    'tzm': 'ⵣⵔ ⵎⴰ ⵜⴽⵙⵙⴱ ⴷⵉ ⴽⵓ ⴰⴱⵔⵉⴷ.',
  },
  'driverP3Title': {'ar': 'مكافآت ساعات الذروة', 'fr': 'Bonus heures de pointe', 'en': 'Peak-hour bonuses', 'tzm': 'ⵜⵉⵣⵎⴰⵎⵉⵏ ⵏ ⵓⵇⵇⴰⵏ'},
  'driverP3Desc': {
    'ar': 'اربح أكثر في الأوقات الأكثر طلباً.',
    'fr': 'Gagnez plus aux heures les plus demandées.',
    'en': 'Earn more during the busiest hours.',
    'tzm': 'ⴽⵙⴱ ⵓⴳⴳⴰⵔ ⵖ ⵉⵣⵎⴰⵣ ⵏ ⵓⵙⵓⵜⵔ.',
  },
  'driverP4Title': {'ar': 'لا رسوم خفية', 'fr': 'Aucun frais caché', 'en': 'No hidden fees', 'tzm': 'ⵓⵍⴰ ⵜⵉⵣⵎⴰⵎⵉⵏ ⵜⵓⴼⴼⵉⵔⵉⵏ'},
  'driverP4Desc': {
    'ar': 'كل شيء واضح من اليوم الأول.',
    'fr': 'Tout est clair dès le premier jour.',
    'en': 'Everything is transparent from day one.',
    'tzm': 'ⴽⵓⵍⵍⵓ ⵉⴼⵙⵙⴻⵏ ⵙⴳ ⵡⴰⵙⵙ ⴰⵎⵣⵡⴰⵔⵓ.',
  },
  'driverP5Title': {'ar': 'دعم بلغتك', 'fr': 'Un support dans votre langue', 'en': 'Support in your language', 'tzm': 'ⵜⴰⵍⵍⴰⵍⵜ ⵙ ⵜⵓⵜⵍⴰⵢⵜ ⵏⵏⴽ'},
  'driverP5Desc': {
    'ar': 'فريقنا يردّ بالعربية والفرنسية والإنجليزية.',
    'fr': 'Notre équipe répond en arabe, français et anglais.',
    'en': 'Our team answers in Arabic, French and English.',
    'tzm': 'ⵜⴰⵔⴰⴱⴱⵓⵜ ⵏⵏⵖ ⵜⵎⵙⵉⵡⴰⴷ ⵙ ⵜⴰⵄⵕⴰⴱⵜ, ⵜⴰⴼⵕⴰⵏⵚⵉⵚⵜ ⴷ ⵜⴳⵍⵉⵣⵜ.',
  },
  'driverP6Title': {'ar': 'انمو معنا', 'fr': 'Grandissez avec nous', 'en': 'Grow with us', 'tzm': 'ⵉⵎⵖⵓⵔ ⴷ ⵏⴻⴽⴽⵏⵉ'},
  'driverP6Desc': {
    'ar': 'كلما قدت أكثر، حصلت على امتيازات ومكافآت أكبر.',
    'fr': 'Plus vous roulez, plus vous profitez d’avantages et de récompenses.',
    'en': 'The more you drive, the more perks and rewards you unlock.',
    'tzm': 'ⵎⴰ ⵜⵙⵓⵀⵓⵍ ⵓⴳⴳⴰⵔ, ⵜⴽⵙⴱ ⵓⴳⴳⴰⵔ.',
  },
  'driverCta': {'ar': 'ابدأ الآن كشريك', 'fr': 'Commencer comme partenaire', 'en': 'Start as a partner', 'tzm': 'ⴱⴷⵓ ⵜⵓⵔⴰ ⴰⵎⴷⴷⴰⴽⴽⵍ'},

  // How it works
  'howTitle': {'ar': 'كيف يعمل؟', 'fr': 'Comment ça marche', 'en': 'How it works', 'tzm': 'ⴰⵎⴽ ⵉⵜⵜⵅⴷⴷⴰⵎ'},
  'howSubtitle': {
    'ar': 'ثلاث خطوات بسيطة تفصلك عن وجهتك.',
    'fr': 'Trois étapes simples vers votre destination.',
    'en': 'Three simple steps to your destination.',
    'tzm': 'ⴽⵕⴰⴹ ⵉⵙⵡⵉⵔⵏ ⵉⴼⵙⵙⴻⵏ ⵖⴰⵔ ⵓⵙⴰⵡⴹ ⵏⵏⴽ.',
  },
  'howS1Title': {'ar': 'اطلب مشوارك', 'fr': 'Commandez', 'en': 'Request your ride', 'tzm': 'ⵙⵙⵓⵜⵔ ⴰⴱⵔⵉⴷ'},
  'howS1Desc': {'ar': 'حدّد موقعك ووجهتك.', 'fr': 'Indiquez votre départ et votre arrivée.', 'en': 'Set your pickup and destination.', 'tzm': 'ⴼⴽ ⴰⴷⵖⴰⵔ ⵏⵏⴽ ⴷ ⵓⵙⴰⵡⴹ.'},
  'howS2Title': {'ar': 'تتبّع السائق', 'fr': 'Suivez votre chauffeur', 'en': 'Track your driver', 'tzm': 'ⵣⵔ ⴰⵎⵙⴻⴱⵔⵉⴷ'},
  'howS2Desc': {'ar': 'شاهد وصول سائقك مباشرة.', 'fr': "Regardez votre chauffeur arriver en direct.", 'en': 'Watch your driver arrive live.', 'tzm': 'ⵥⵔ ⴰⵎⵙⴻⴱⵔⵉⴷ ⵉⵜⵜⴰⵙ ⵙ ⵓⵙⵡⵉⵔ.'},
  'howS3Title': {'ar': 'ادفع نقداً', 'fr': 'Payez en espèces', 'en': 'Pay in cash', 'tzm': 'ⵅⵍⵍⵚ ⵙ ⵉⴷⵔⵉⵎⵏ'},
  'howS3Desc': {'ar': 'ادفع عند الوصول بكل سهولة.', 'fr': "Payez à l'arrivée en toute simplicité.", 'en': 'Pay on arrival, the easy way.', 'tzm': 'ⵅⵍⵍⵚ ⵎⵉ ⵜⴰⵡⴹⴷ.'},

  // Download
  'downloadTitle': {'ar': 'حمّل التطبيقات', 'fr': 'Téléchargez les applications', 'en': 'Download the apps', 'tzm': 'ⵙⴷⵔⵙ ⵉⵙⵏⴼⴰⵔⵏ'},
  'downloadSubtitle': {
    'ar': 'اختر نسختك: راكب أو سائق.',
    'fr': 'Choisissez votre version : passager ou chauffeur.',
    'en': 'Pick your version: rider or driver.',
    'tzm': 'ⵙⵜⵉ ⵍⵇⵉⵙⵎ ⵏⵏⴽ: ⴰⵔⴰⴽⴰⴱ ⵏⵖ ⴰⵎⵙⴻⴱⵔⵉⴷ.',
  },
  'riderAppName': {'ar': 'أجرة — زبون', 'fr': 'Ojra — Passager', 'en': 'Ojra — Rider', 'tzm': 'ⵓⴷⵊⵔⴰ — ⴰⵔⴰⴽⴰⴱ'},
  'riderAppDesc': {
    'ar': 'للمستخدمين الذين يريدون التنقّل بسهولة.',
    'fr': 'Pour les passagers qui veulent se déplacer facilement.',
    'en': 'For riders who want to get around easily.',
    'tzm': 'ⵉ ⵉⵎⵙⵏⵉⴳ ⵢⴻⴱⵖⴰⵏ ⴰⴷ ⵉⵏⵉⴳ ⵙ ⵜⵉⴼⵔⴰⵜ.',
  },
  'driverAppName': {'ar': 'أجرة — سائق', 'fr': 'Ojra — Chauffeur', 'en': 'Ojra — Driver', 'tzm': 'ⵓⴷⵊⵔⴰ — ⴰⵎⵙⴻⴱⵔⵉⴷ'},
  'driverAppDesc': {
    'ar': 'للسائقين المستقلّين الذين يريدون دخلاً مرناً.',
    'fr': 'Pour les chauffeurs indépendants qui veulent un revenu flexible.',
    'en': 'For independent drivers who want flexible income.',
    'tzm': 'ⵉ ⵉⵎⵙⴻⴱⵔⵉⴷⵏ ⵢⴻⴱⵖⴰⵏ ⵜⵉⵡⵓⵔⵉⵡⵉⵏ ⵉⵍⴻⵍⵍⵉⵢⵏ.',
  },
  'installNow': {'ar': 'تثبيت الآن', 'fr': 'Installer maintenant', 'en': 'Install now', 'tzm': 'ⵙⴱⴷⴷ ⵜⵓⵔⴰ'},
  'scanHint': {
    'ar': 'امسح رمز QR للتثبيت',
    'fr': 'Scannez le QR code pour installer',
    'en': 'Scan the QR code to install',
    'tzm': 'ⵙⴽⴰⵏ ⴰⵙⴰⵔⴰⴳ ⵇⵔ',
  },
  'phoneHint': {
    'ar': 'افتح هذه الصفحة من هاتفك للتثبيت مباشرة.',
    'fr': 'Ouvrez cette page depuis votre téléphone pour installer directement.',
    'en': 'Open this page from your phone to install directly.',
    'tzm': 'ⵍⴷⵉ ⵜⴰⵙⵏⴰ ⴰⴷ ⵙⴳ ⵜⵉⵍⵉⴼⵓⵏ ⵏⵏⴽ.',
  },
  'getOnGooglePlay': {'ar': 'احصل عليه من Google Play', 'fr': 'Disponible sur Google Play', 'en': 'Get it on Google Play', 'tzm': 'ⴰⵡⵉ ⵜ ⵙⴳ Google Play'},

  // Terms
  'termsTitle': {'ar': 'الشروط والأحكام', 'fr': 'Conditions générales', 'en': 'Terms and Conditions', 'tzm': 'ⵜⵉⴼⴰⴷⵉⵡⵉⵏ'},
  'termsUpdated': {'ar': 'آخر تحديث: 11/07/2024', 'fr': 'Dernière mise à jour : 11/07/2024', 'en': 'Last updated: 11/07/2024', 'tzm': 'ⴰⵣⵔⴰⴽ: 11/07/2024'},
  'readTerms': {'ar': 'اقرأ الشروط والأحكام', 'fr': 'Lire les conditions générales', 'en': 'Read the terms and conditions', 'tzm': 'ⵖⵔ ⵜⵉⴼⴰⴷⵉⵡⵉⵏ'},
  'backHome': {'ar': 'العودة للرئيسية', 'fr': "Retour à l'accueil", 'en': 'Back to home', 'tzm': 'ⵖⵓⵔ ⴰⵙⵏⵓⴱⴳ'},
  'tzmTermsNotice': {
    'ar': '',
    'fr': '',
    'en': '',
    'tzm': 'ⵓⵔ ⵏⵙⵉ ⵜⵉⴼⴰⴷⵉⵡⵉⵏ ⵙ ⵜⵎⴰⵣⵉⵖⵜ ⵖⵉⵍⴰ. ⵉⵣⵎⵔ ⴰⴷ ⵜⵏ ⵜⵖⵔⴷ ⵙ ⵜⴰⵄⵕⴰⴱⵜ, ⵜⴰⴼⵕⴰⵏⵚⵉⵚⵜ ⵏⵖ ⵜⴰⴳⵍⵉⵣⵜ ⴷⴰⵡⴰ.',
  },

  // Footer
  'footerTagline': {
    'ar': 'أجرة — نقل بسيط وموثوق في الجزائر.',
    'fr': 'Ojra — un transport simple et fiable en Algérie.',
    'en': 'Ojra — simple, reliable transport in Algeria.',
    'tzm': 'ⵓⴷⵊⵔⴰ — ⴰⵙⵏⵓⴱⴳ ⵉⴼⵙⵙⴻⵏ ⴷ ⵢⵓⵎⵏ ⴷⵉ ⴷⵣⴰⵢⵔ.',
  },
  'footerRights': {
    'ar': '© 2026 أجرة. جميع الحقوق محفوظة.',
    'fr': '© 2026 Ojra. Tous droits réservés.',
    'en': '© 2026 Ojra. All rights reserved.',
    'tzm': '© 2026 ⵓⴷⵊⵔⴰ. ⴰⴽⴽ ⵉⵣⵔⴼⴰⵏ ⵉⵏⵏⴰⵍⵏ.',
  },
  'footerMade': {
    'ar': 'صُنع بفخر في الجزائر 🇩🇿',
    'fr': 'Fièrement conçu en Algérie 🇩🇿',
    'en': 'Proudly built in Algeria 🇩🇿',
    'tzm': 'ⵉⵜⵜⵓⵙⵏⴼⵍ ⵙ ⵓⵣⵔⴼ ⴷⵉ ⴷⵣⴰⵢⵔ 🇩🇿',
  },
  'footerContact': {'ar': 'تواصل معنا', 'fr': 'Contact', 'en': 'Contact', 'tzm': 'ⴰⵎⵙⵉⵡⴷ'},
};
