import 'package:flutter_test/flutter_test.dart';
import 'package:passworthy/env/env.dart';

void main() {
  group('Env', () {
    test('has all the environment variable definitions', () {
      expect(Env.sentryDsn, isA<String>());
      expect(Env.flagsmithApiKey, isA<String>());
    });
  });
}
