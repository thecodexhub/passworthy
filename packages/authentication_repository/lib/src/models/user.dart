import 'package:equatable/equatable.dart';

/// {@template user}
/// User model definition, can be used to differentiate between
/// authenticated and unauthenticated user.
/// 
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.name = 'User',
    this.email,
    this.createdAt,
  });

  /// Represents an unauthenticated user.
  static const empty = User(id: '');

  /// The current user's id (unique identifier).
  final String id;

  /// The current user's name.
  /// 
  /// Chosen as preferred name during the sign up process.
  final String name;

  /// The current user's email address.
  final String? email;

  /// Date time stamp of when the user was created.
  final String? createdAt;

  /// Returns whether the current user is not authenticated.
  bool get isUnauthenticated => this == User.empty;

  /// Returns whether the current user is authenticated.
  bool get isAuthenticated => !isUnauthenticated;
  
  @override
  List<Object?> get props => [id, name, email, createdAt];
}
