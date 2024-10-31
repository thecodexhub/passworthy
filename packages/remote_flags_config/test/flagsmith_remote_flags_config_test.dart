import 'package:fake_async/fake_async.dart';
import 'package:flagsmith/flagsmith.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_memory_cache/in_memory_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_flags_config/remote_flags_config.dart';

class MockFlagsmithClient extends Mock implements FlagsmithClient {}

class MockInMemoryCacheClient extends Mock implements InMemoryCacheClient {}

void main() {
  group('FlagsmithRemoteFlagsConfig', () {
    late FlagsmithClient flagsmithClient;
    late InMemoryCacheClient cacheClient;
    late FlagsmithRemoteFlagsConfig flagsConfig;

    setUp(() async {
      flagsmithClient = MockFlagsmithClient();
      cacheClient = MockInMemoryCacheClient();
      when(() => flagsmithClient.initialize()).thenAnswer((_) async {});
      when(() => flagsmithClient.getFeatureFlags()).thenAnswer((_) async => []);

      when(() => flagsmithClient.isFeatureFlagEnabled(any(), reload: true))
          .thenAnswer((_) async => true);

      when(() => cacheClient.read<bool>(key: any(named: 'key')))
          .thenReturn(true);
      flagsConfig = await FlagsmithRemoteFlagsConfig.initialize(
        apiKey: 'abc',
        flagsmithClient: flagsmithClient,
        cacheClient: cacheClient,
      );
    });

    test('initializes correctly with flagsmithClient and cacheClient', () {
      expect(flagsConfig, isA<FlagsmithRemoteFlagsConfig>());
      verify(flagsmithClient.initialize).called(1);
      verify(flagsmithClient.getFeatureFlags).called(1);
    });

    test('should use default FlagsmithClient if not provided', () async {
      expect(
        () => FlagsmithRemoteFlagsConfig.initialize(apiKey: 'abc'),
        throwsException,
      );
    });

    group('killSwitchStream', () {
      test('emits false when the kill switch key is disabled', () async {
        when(() => flagsmithClient.isFeatureFlagEnabled(any(), reload: true))
            .thenAnswer((_) async => false);

        final actual = await flagsConfig.killSwitchStream().first;
        expect(actual, isFalse);
        verify(
          () => flagsmithClient.isFeatureFlagEnabled(
            FlagsmithRemoteFlagsConfig.killSwitchFlagsmithKey,
            reload: true,
          ),
        ).called(1);
      });

      test('emits true when the kill switch key is enabled', () async {
        final actual = await flagsConfig.killSwitchStream().first;
        expect(actual, isTrue);
        verify(
          () => flagsmithClient.isFeatureFlagEnabled(
            FlagsmithRemoteFlagsConfig.killSwitchFlagsmithKey,
            reload: true,
          ),
        ).called(1);
      });

      test('emits the reloaded value again in 30 seconds', () {
        fakeAsync((async) {
          final stream = flagsConfig.killSwitchStream();
          final streamListener = stream.listen(
            expectAsync1(
              (value) => expect(value, isTrue),
              count: 2,
            ),
          );

          async.elapse(const Duration(seconds: 59));
          streamListener.cancel();
        });
      });

      test('caches the result into in memory cache client', () async {
        await flagsConfig.killSwitchStream().first;
        verify(
          () => cacheClient.write(
            key: FlagsmithRemoteFlagsConfig.killSwitchCacheKey,
            value: true,
          ),
        ).called(1);
      });

      test('emits from cache when there is an error', () async {
        when(() => flagsmithClient.isFeatureFlagEnabled(any(), reload: true))
            .thenThrow(Exception('oops'));

        final actual = await flagsConfig.killSwitchStream().first;
        expect(actual, isTrue);

        verify(
          () => cacheClient.read<bool>(
            key: FlagsmithRemoteFlagsConfig.killSwitchCacheKey,
          ),
        ).called(1);
      });
    });

    group('getKillSwitch', () {
      test('returns cached result', () {
        expect(flagsConfig.getKillSwitch(), isTrue);
      });

      test('returns false when cached value does not exist', () {
        when(
          () => cacheClient.read<bool>(key: any(named: 'key')),
        ).thenReturn(null);
        expect(flagsConfig.getKillSwitch(), isFalse);
      });
    });
  });
}
