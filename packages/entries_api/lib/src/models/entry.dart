import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// {@template entry}
/// A single `entry` item.
///
/// Contains [platform], [identity], and [password], in addition to
/// an [id], [createdAt] timestamp, and [isFavorite] flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided,
/// one will be generated.
///
/// [Entry]s are immutable and can be copied using [copyWith].
/// {@endtemplate}
@immutable
class Entry extends Equatable {
  /// {@macro entry}
  Entry({
    required this.platform,
    required this.identity,
    required this.password,
    required this.createdAt,
    String? id,
    this.isFavorite = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must be either null or non-empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `entry`.
  ///
  /// Cannot be empty.
  final String id;

  /// The platform name for the `entry`. It could be Amazon,
  /// Netflix, Google account, anything.
  final String platform;

  /// The username, or phone number, or email address against which
  /// the password will be saved.
  final String identity;

  /// This is the password for the platform and the identity.
  ///
  /// It will be encrypted first before storing into local
  /// datastore, and decrypted before showing to the end user.
  final String password;

  /// The timestamp defining the creation time of this `entry`.
  final DateTime createdAt;

  /// Determines whether this `entry` is marked as favorite.
  ///
  /// Default is set to false.
  final bool isFavorite;

  @override
  List<Object?> get props =>
      [id, platform, identity, password, createdAt, isFavorite];

  /// Returns a copy of this `entry` with the provided values updated.
  ///
  /// {@macro entry}
  Entry copyWith({
    String? id,
    String? platform,
    String? identity,
    String? password,
    DateTime? createdAt,
    bool? isFavorite,
  }) {
    return Entry(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      identity: identity ?? this.identity,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}