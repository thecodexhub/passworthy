import 'package:flutter_test/flutter_test.dart';
import 'package:remote_flags_config/remote_flags_config.dart';

class TestRemoteFlagsConfig extends RemoteFlagsConfig {
  const TestRemoteFlagsConfig(): super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('RemoteFlagsConfig', () {
    test('can be constructed', () {
      expect(TestRemoteFlagsConfig.new, returnsNormally);
    });
  });
}
