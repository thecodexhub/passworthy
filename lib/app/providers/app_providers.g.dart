// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$killSwitchStreamHash() => r'3374eb50760c277919e82bbeacae8fb827fd5c9d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for stream of [bool] which will emit the value of kill switch key.
///
/// Copied from [killSwitchStream].
@ProviderFor(killSwitchStream)
const killSwitchStreamProvider = KillSwitchStreamFamily();

/// Provider for stream of [bool] which will emit the value of kill switch key.
///
/// Copied from [killSwitchStream].
class KillSwitchStreamFamily extends Family<AsyncValue<bool>> {
  /// Provider for stream of [bool] which will emit the value of kill switch key.
  ///
  /// Copied from [killSwitchStream].
  const KillSwitchStreamFamily();

  /// Provider for stream of [bool] which will emit the value of kill switch key.
  ///
  /// Copied from [killSwitchStream].
  KillSwitchStreamProvider call(
    PassworthyFlags? passworthyFlags,
  ) {
    return KillSwitchStreamProvider(
      passworthyFlags,
    );
  }

  @override
  KillSwitchStreamProvider getProviderOverride(
    covariant KillSwitchStreamProvider provider,
  ) {
    return call(
      provider.passworthyFlags,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'killSwitchStreamProvider';
}

/// Provider for stream of [bool] which will emit the value of kill switch key.
///
/// Copied from [killSwitchStream].
class KillSwitchStreamProvider extends AutoDisposeStreamProvider<bool> {
  /// Provider for stream of [bool] which will emit the value of kill switch key.
  ///
  /// Copied from [killSwitchStream].
  KillSwitchStreamProvider(
    PassworthyFlags? passworthyFlags,
  ) : this._internal(
          (ref) => killSwitchStream(
            ref as KillSwitchStreamRef,
            passworthyFlags,
          ),
          from: killSwitchStreamProvider,
          name: r'killSwitchStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$killSwitchStreamHash,
          dependencies: KillSwitchStreamFamily._dependencies,
          allTransitiveDependencies:
              KillSwitchStreamFamily._allTransitiveDependencies,
          passworthyFlags: passworthyFlags,
        );

  KillSwitchStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.passworthyFlags,
  }) : super.internal();

  final PassworthyFlags? passworthyFlags;

  @override
  Override overrideWith(
    Stream<bool> Function(KillSwitchStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: KillSwitchStreamProvider._internal(
        (ref) => create(ref as KillSwitchStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        passworthyFlags: passworthyFlags,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<bool> createElement() {
    return _KillSwitchStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is KillSwitchStreamProvider &&
        other.passworthyFlags == passworthyFlags;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, passworthyFlags.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin KillSwitchStreamRef on AutoDisposeStreamProviderRef<bool> {
  /// The parameter `passworthyFlags` of this provider.
  PassworthyFlags? get passworthyFlags;
}

class _KillSwitchStreamProviderElement
    extends AutoDisposeStreamProviderElement<bool> with KillSwitchStreamRef {
  _KillSwitchStreamProviderElement(super.provider);

  @override
  PassworthyFlags? get passworthyFlags =>
      (origin as KillSwitchStreamProvider).passworthyFlags;
}

String _$flagsHash() => r'c07141c2ee24ad09d7e46ae2d9ac5936d043ceb3';

/// Provider for the feature flagging.
///
/// Copied from [flags].
@ProviderFor(flags)
final flagsProvider = AutoDisposeFutureProvider<PassworthyFlags>.internal(
  flags,
  name: r'flagsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$flagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FlagsRef = AutoDisposeFutureProviderRef<PassworthyFlags>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
