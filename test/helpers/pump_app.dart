import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:passworthy/app/app.dart';
import 'package:passworthy/l10n/l10n.dart';
import 'package:remote_flags_config/remote_flags_config.dart';

class MockRemoteFlagsConfig extends Mock implements RemoteFlagsConfig {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {RemoteFlagsConfig? remoteFlagsConfig}) {
    return pumpWidget(
      ProviderScope(
        overrides: [
          remoteFlagsConfigProvider.overrideWith(
            (_) => remoteFlagsConfig ?? MockRemoteFlagsConfig(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
