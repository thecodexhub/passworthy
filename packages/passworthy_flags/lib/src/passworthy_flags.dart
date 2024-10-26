import 'package:flagsmith/flagsmith.dart';
import 'package:in_memory_cache/in_memory_cache.dart';
import 'package:meta/meta.dart';
import 'package:passworthy_flags/passworthy_flags.dart';

/// {@template passworthy_flags}
/// Feature flagging and remote config service for Passworthy.
/// {@endtemplate}
class PassworthyFlags {
  /// {@macro passworthy_flags}
  PassworthyFlags({
    required String flagsmithApiKey,
    FlagsmithClient? flagsmithClient,
    InMemoryCacheClient? cacheClient,
  })  : _flagsmithClient =
            flagsmithClient ?? FlagsmithClient(apiKey: flagsmithApiKey),
        _cacheClient = cacheClient ?? InMemoryCacheClient();

  final FlagsmithClient _flagsmithClient;
  final InMemoryCacheClient _cacheClient;

  /// Kill Switch cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const killSwitchCacheKey = '__kill_switch_flag_key__';

  /// Initializes the Flagsmith client.
  Future<void> init() => _flagsmithClient.initialize();

  /// Stream of [bool] which will emit the value of kill switch key when
  /// enabled or disabled in Flagsmith.
  ///
  /// Emits false if the kill switch stream is not found.
  Stream<bool> get isKillSwitchEnabledStream {
    final stream = _flagsmithClient.stream(FlagsmithKeys.killSwitchFlagKey);
    if (stream == null) return Stream.value(false);

    return stream.map((flag) {
      final killSwitchFlag = flag.enabled ?? false;
      _cacheClient.write(key: killSwitchCacheKey, value: killSwitchFlag);
      return killSwitchFlag;
    });
  }

  /// Returns the current cached kill switch value.
  /// Defaults to false if there is no cache for the kill switch flag.
  bool get isKillSwitchEnabled {
    return _cacheClient.read<bool>(key: killSwitchCacheKey) ?? false;
  }
}
