// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$killSwitchStreamHash() => r'00c8e3f8d4df3f756f730a477d09cc077eaa365b';

/// Provider for stream of [bool] which will emit the value of kill switch key.
///
/// Copied from [killSwitchStream].
@ProviderFor(killSwitchStream)
final killSwitchStreamProvider = AutoDisposeStreamProvider<bool>.internal(
  killSwitchStream,
  name: r'killSwitchStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$killSwitchStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KillSwitchStreamRef = AutoDisposeStreamProviderRef<bool>;
String _$userSubscriptionHash() => r'c432878d00c73ee649c20117749c3a3a33fde998';

/// Stream of [User] which will emit the current user when the authentication
/// state changes. Emits [User.empty] when the user is not authenticated.
///
/// Copied from [userSubscription].
@ProviderFor(userSubscription)
final userSubscriptionProvider = AutoDisposeStreamProvider<User>.internal(
  userSubscription,
  name: r'userSubscriptionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userSubscriptionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserSubscriptionRef = AutoDisposeStreamProviderRef<User>;
String _$remoteFlagsConfigHash() => r'21bd5acedd9f132b49ef9e551054a1788eee4c02';

/// Provider for the feature flagging.
/// Async initialization will be done with the flags provider.
/// https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
///
/// Copied from [remoteFlagsConfig].
@ProviderFor(remoteFlagsConfig)
final remoteFlagsConfigProvider =
    AutoDisposeProvider<RemoteFlagsConfig>.internal(
  remoteFlagsConfig,
  name: r'remoteFlagsConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteFlagsConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteFlagsConfigRef = AutoDisposeProviderRef<RemoteFlagsConfig>;
String _$authRepositoryHash() => r'f5cce100b8726555e24e577bfb35f62d221e900a';

/// Provider for the authentication repository
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider =
    AutoDisposeProvider<AuthenticationRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthenticationRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
