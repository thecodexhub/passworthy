import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:passworthy/app/app.dart';
import 'package:passworthy/l10n/l10n.dart';
import 'package:passworthy_flags/passworthy_flags.dart';

class MockPassworthyFlags extends Mock implements PassworthyFlags {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {PassworthyFlags? passworthyFlags}) {
    return pumpWidget(
      ProviderScope(
        overrides: [
          flagsProvider.overrideWith(
            (_) => passworthyFlags ?? MockPassworthyFlags(),
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
