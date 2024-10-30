import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passworthy_flags/passworthy_flags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

/// Provider for stream of [bool] which will emit the value of kill switch key.
@riverpod
Stream<bool> killSwitchStream(Ref ref) {
  final passworthyFlags = ref.watch(flagsProvider);
  return passworthyFlags.isKillSwitchEnabledStream();
}

/// Provider for the feature flagging.
/// Async initialization will be done with the flags provider.
/// https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@riverpod
PassworthyFlags flags(Ref ref) => throw UnimplementedError();
