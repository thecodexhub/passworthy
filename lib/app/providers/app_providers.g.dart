// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$killSwitchStreamHash() => r'33eadba227c2d6def9a6354678ef25360d84ae95';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
