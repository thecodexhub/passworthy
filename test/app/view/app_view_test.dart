import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:passworthy/app/app.dart';
import 'package:passworthy_flags/passworthy_flags.dart';

import '../../helpers/pump_app.dart';

class MockPassworthyFlags extends Mock implements PassworthyFlags {}

void main() {
  group('App', () {
    late PassworthyFlags passworthyFlags;

    setUp(() {
      passworthyFlags = MockPassworthyFlags();
      when(() => passworthyFlags.isKillSwitchEnabledStream()).thenAnswer(
        (_) => Stream.value(false),
      );
    });

    testWidgets('renders the PlaceholderWidget', (tester) async {
      await tester.pumpApp(const App());
      expect(find.byType(PlaceholderWidget), findsOneWidget);
    });

    testWidgets(
      'renders [nothing] text when the flags provider is loading',
      (tester) async {
        await tester.pumpApp(const App());
        expect(find.text('nothing'), findsOne);
      },
    );

    testWidgets(
      'renders true/false text when the flags provider is loaded',
      (tester) async {
        await tester.pumpApp(const App(), passworthyFlags: passworthyFlags);
        await tester.pumpAndSettle();
        expect(find.text('false'), findsOne);
      },
    );
  });
}
