import 'package:flutter/widgets.dart';
import 'package:takip/core/services/error_service.dart';
import 'package:takip/l10n/app_localizations.dart';

class LocalizationHelper {
  static AppLocalizations get l10n {
    final context = ErrorService().navigatorKey.currentContext;
    if (context == null) {
      throw Exception('LocalizationHelper: context is null');
    }
    return AppLocalizations.of(context)!;
  }

  static Locale get currentLocale {
    final context = ErrorService().navigatorKey.currentContext;
    if (context == null) {
      throw Exception('LocalizationHelper: context is null');
    }
    return Localizations.localeOf(context);
  }

  static String get currentLanguageCode => currentLocale.languageCode;
}
