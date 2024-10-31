import 'dart:async';

import 'package:flagsmith/flagsmith.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:in_memory_cache/in_memory_cache.dart';
import 'package:remote_flags_config/remote_flags_config.dart';

/// Implementation of the [RemoteFlagsConfig] that uses Flagsmith.
class FlagsmithRemoteFlagsConfig extends RemoteFlagsConfig {
  FlagsmithRemoteFlagsConfig._(this._flagsmithClient, this._cacheClient);

  /// Initializes the [FlagsmithConfig] with the `flagsmithApiKey`, and
  /// reloads the feature flags, so that values,
  static Future<FlagsmithRemoteFlagsConfig> initialize({
    required String apiKey,
    FlagsmithClient? flagsmithClient,
    InMemoryCacheClient? cacheClient,
  }) async {
    final flagsmith = flagsmithClient ?? FlagsmithClient(apiKey: apiKey);
    final cache = cacheClient ?? InMemoryCacheClient();

    await flagsmith.initialize();
    await flagsmith.getFeatureFlags();

    return FlagsmithRemoteFlagsConfig._(flagsmith, cache);
  }

  final FlagsmithClient _flagsmithClient;
  final InMemoryCacheClient _cacheClient;

  /// Kill Switch flagsmith key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const killSwitchFlagsmithKey = 'kill_switch';

  /// Kill Switch cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const killSwitchCacheKey = '__kill_switch_flag_key__';

  @override
  Stream<bool> killSwitchStream() async* {
    while (true) {
      try {
        final enabled = await _flagsmithClient.isFeatureFlagEnabled(
          killSwitchFlagsmithKey,
          reload: true,
        );
        _cacheClient.write(key: killSwitchCacheKey, value: enabled);
        yield enabled;
      } catch (_) {
        final enabled = _cacheClient.read<bool>(key: killSwitchCacheKey);
        yield enabled ?? false;
      }
      await Future.delayed(
        const Duration(seconds: 30),
        () {},
      );
    }
  }

  @override
  bool getKillSwitch() {
    final enabled = _cacheClient.read<bool>(key: killSwitchCacheKey);
    return enabled ?? false;
  }
}
