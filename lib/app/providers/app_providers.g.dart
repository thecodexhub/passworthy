// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$killSwitchStreamHash() => r'3a61c213122971eeef183aa6815018fcfe39b39d';

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
String _$flagsHash() => r'b05abb6d6742d1f23aa81e3da0bf0571281faec3';

/// Provider for the feature flagging.
///
/// Copied from [flags].
@ProviderFor(flags)
final flagsProvider = AutoDisposeProvider<PassworthyFlags>.internal(
  flags,
  name: r'flagsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$flagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FlagsRef = AutoDisposeProviderRef<PassworthyFlags>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
