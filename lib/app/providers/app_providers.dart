import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_flags_config/remote_flags_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

/// Provider for stream of [bool] which will emit the value of kill switch key.
@riverpod
Stream<bool> killSwitchStream(Ref ref) {
  final remoteFlagsConfig = ref.read(remoteFlagsConfigProvider);
  return remoteFlagsConfig.killSwitchStream();
}

/// Stream of [User] which will emit the current user when the authentication
/// state changes. Emits [User.empty] when the user is not authenticated.
@riverpod
Stream<User> userSubscription(Ref ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return authRepository.user;
}

/// Provider for the feature flagging.
/// Async initialization will be done with the flags provider.
/// https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@riverpod
RemoteFlagsConfig remoteFlagsConfig(Ref ref) => throw UnimplementedError();

/// Provider for the authentication repository
@riverpod
AuthenticationRepository authRepository(Ref ref) => throw UnimplementedError();
