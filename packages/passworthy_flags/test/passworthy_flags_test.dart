import 'package:flagsmith/flagsmith.dart';
import 'package:in_memory_cache/in_memory_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:passworthy_flags/passworthy_flags.dart';
import 'package:test/test.dart';

class MockInMemoryCacheClient extends Mock implements InMemoryCacheClient {}

class MockFlag extends Mock implements Flag {}

class MockFlagsmithClient extends Mock implements FlagsmithClient {}

void main() {
  group('PassworthyFlags', () {
    const apiKey = '__api_key__';

    late InMemoryCacheClient cacheClient;
    late FlagsmithClient flagsmithClient;
    late Flag flag;
    late PassworthyFlags passworthyFlags;

    PassworthyFlags createSubject({
      String? flagsmithApiKey,
      FlagsmithClient? flagsmithClient,
      InMemoryCacheClient? cacheClient,
    }) {
      return PassworthyFlags(
        flagsmithApiKey: flagsmithApiKey ?? apiKey,
        flagsmithClient: flagsmithClient,
        cacheClient: cacheClient,
      );
    }

    setUp(() {
      cacheClient = MockInMemoryCacheClient();
      flag = MockFlag();
      flagsmithClient = MockFlagsmithClient();

      when(() => flagsmithClient.initialize()).thenAnswer((_) async {});

      when(() => flag.enabled).thenReturn(true);
      when(() => flagsmithClient.stream(any())).thenAnswer(
        (_) => Stream.value(flag),
      );

      passworthyFlags = createSubject(
        flagsmithApiKey: apiKey,
        cacheClient: cacheClient,
        flagsmithClient: flagsmithClient,
      );
    });

    test('constructor works perfectly', () {
      expect(createSubject, returnsNormally);
    });

    test(
      'creates [FlagsmithClient], and [InMemoryCacheClient] instances '
      'internally when not injected',
      () {
        expect(PassworthyFlags.new, isNot(throwsException));
      },
    );

    group('init', () {
      test('initializes the flagsmith client', () async {
        await passworthyFlags.init();
        verify(() => flagsmithClient.initialize()).called(1);
      });
    });

    group('isKillSwitchEnabledStream', () {
      test('emits false when the flagsmith client stream returns null', () {
        when(() => flagsmithClient.stream(any())).thenAnswer((_) => null);
        expect(passworthyFlags.isKillSwitchEnabledStream, emits(false));

        verify(
          () => flagsmithClient.stream(FlagsmithKeys.killSwitchFlagKey),
        ).called(1);
      });

      test('emits correct result from the flagsmith client stream', () {
        expect(passworthyFlags.isKillSwitchEnabledStream, emits(true));
        verify(
          () => flagsmithClient.stream(FlagsmithKeys.killSwitchFlagKey),
        ).called(1);
      });

      test('caches the result into in memory cache client', () async {
        await passworthyFlags.isKillSwitchEnabledStream.first;
        verify(
          () => cacheClient.write(
            key: PassworthyFlags.killSwitchCacheKey,
            value: true,
          ),
        ).called(1);
      });
    });

    group('isKillSwitchEnabled', () {
      test('returns cached result', () {
        when(
          () => cacheClient.read<bool>(key: any(named: 'key')),
        ).thenReturn(true);
        expect(passworthyFlags.isKillSwitchEnabled, isTrue);
      });

      test('returns false when cached value does not exist', () {
        when(
          () => cacheClient.read<bool>(key: any(named: 'key')),
        ).thenReturn(null);
        expect(passworthyFlags.isKillSwitchEnabled, isFalse);
      });
    });
  });
}
