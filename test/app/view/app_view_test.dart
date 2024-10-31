import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:passworthy/app/app.dart';
import 'package:remote_flags_config/remote_flags_config.dart';

import '../../helpers/pump_app.dart';

class MockRemoteFlagsConfig extends Mock implements RemoteFlagsConfig {}

void main() {
  group('App', () {
    late RemoteFlagsConfig remoteFlagsConfig;

    setUp(() {
      remoteFlagsConfig = MockRemoteFlagsConfig();
      when(() => remoteFlagsConfig.killSwitchStream()).thenAnswer(
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
        await tester.pumpApp(const App(), remoteFlagsConfig: remoteFlagsConfig);
        await tester.pumpAndSettle();
        expect(find.text('false'), findsOne);
      },
    );
  });
}
