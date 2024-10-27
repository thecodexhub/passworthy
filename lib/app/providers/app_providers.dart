import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passworthy/env/env.dart';
import 'package:passworthy_flags/passworthy_flags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

/// Provider for stream of [bool] which will emit the value of kill switch key.
@riverpod
Stream<bool> killSwitchStream(Ref ref, PassworthyFlags? passworthyFlags) {
  if (passworthyFlags == null) return Stream.value(false);
  return passworthyFlags.isKillSwitchEnabledStream();
}

/// Provider for the feature flagging.
@riverpod
Future<PassworthyFlags> flags(Ref ref) async {
  final passworthyFlags = PassworthyFlags(flagsmithApiKey: Env.flagsmthApiKey);
  await passworthyFlags.init();
  return passworthyFlags;
}
