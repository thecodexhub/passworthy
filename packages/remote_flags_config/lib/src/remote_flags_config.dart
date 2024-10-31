/// {@template remote_flags_config}
/// The interface for an API that provides access to the flags and
/// remote configs.
/// {@endtemplate}
abstract class RemoteFlagsConfig {
  /// {@macro remote_flags_config}
  const RemoteFlagsConfig();
  
  /// Provides a [Stream] of bool value that suggests whether the
  /// kill switch is enabled.
  Stream<bool> killSwitchStream();

  /// Fetches the value of kill switch, whether or not the kill switch
  /// is enabled.
  bool getKillSwitch();
}
