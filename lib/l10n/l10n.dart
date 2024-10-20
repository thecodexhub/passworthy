import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension on [AppLocalizations].
extension AppLocalizationsX on BuildContext {
  /// Helper extension for [AppLocalizations].
  AppLocalizations get l10n => AppLocalizations.of(this);
}
