import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:in_memory_cache/in_memory_cache.dart';
import 'package:supabase/supabase.dart' as supabase;

/// {@template sign_up_with_email_and_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.errorCode = AuthenticationErrorCode.unexpected,
  ]);

  /// Create an [AuthenticationErrorCode] from the Supabase
  /// [supabase.AuthException] error code.
  /// https://supabase.com/docs/guides/auth/debugging/error-codes#auth-error-codes-table
  factory SignUpWithEmailAndPasswordFailure.fromCode(String? code) {
    switch (code) {
      case 'email_provider_disabled':
      case 'signup_disabled':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.configurationError,
        );
      case 'email_address_not_authorized':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.emailAddressNotAuthorized,
        );
      case 'email_exists':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.emailAlreadyExists,
        );
      case 'request_timeout':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.requestTimeout,
        );
      case 'user_already_exists':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.userAlreadyExists,
        );
      case 'user_banned':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.userBanned,
        );
      case 'validation_failed':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.validationFailed,
        );
      case 'weak_password':
        return const SignUpWithEmailAndPasswordFailure(
          AuthenticationErrorCode.weakPassword,
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated [AuthenticationErrorCode].
  final AuthenticationErrorCode errorCode;
}

/// {@template sign_in_with_email_and_password_failure}
/// Thrown during the sign in process if a failure occurs.
/// {@endtemplate}
class SignInWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_in_with_email_and_password_failure}
  const SignInWithEmailAndPasswordFailure([
    this.errorCode = AuthenticationErrorCode.unexpected,
  ]);

  /// Create an [AuthenticationErrorCode] from the Supabase
  /// [supabase.AuthException] error code.
  /// https://supabase.com/docs/guides/auth/debugging/error-codes#auth-error-codes-table
  factory SignInWithEmailAndPasswordFailure.fromCode(String? code) {
    switch (code) {
      case 'email_address_not_authorized':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.emailAddressNotAuthorized,
        );
      case 'email_exists':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.emailAlreadyExists,
        );
      case 'email_not_confirmed':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.emailNotConfirmed,
        );
      case 'request_timeout':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.requestTimeout,
        );
      case 'user_banned':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.userBanned,
        );
      case 'user_not_found':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.userNotFound,
        );
      case 'validation_failed':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.validationFailed,
        );
      case 'weak_password':
        return const SignInWithEmailAndPasswordFailure(
          AuthenticationErrorCode.weakPassword,
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }

  /// The associated [AuthenticationErrorCode].
  final AuthenticationErrorCode errorCode;
}

/// {@template sign_out_failure}
/// Thrown during the sign out process if a failure occurs.
/// {@endtemplate}
class SignOutFailure implements Exception {
  /// {@macro sign_out_failure}
  const SignOutFailure();
}

/// {@template authentication_reository}
/// Repository that manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    required supabase.SupabaseClient supabaseClient,
    InMemoryCacheClient? cacheClient,
  })  : _supabaseClient = supabaseClient,
        _cacheClient = cacheClient ?? InMemoryCacheClient();

  final supabase.SupabaseClient _supabaseClient;
  final InMemoryCacheClient _cacheClient;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] when the user is not authenticated. The
  /// unauthenticated state is checked on the basis of session and user id.
  Stream<User> get user {
    return _supabaseClient.auth.onAuthStateChange.map((event) {
      final session = event.session;
      final user = (session == null || session.user.id.isEmpty)
          ? User.empty
          : session.user.toUser;
      _cacheClient.write<User>(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cacheClient.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided [email], [password] and
  /// [name].
  ///
  /// The [name] will be set in the user metadata.
  ///
  /// [onUnexpectedException] is called when there is an exception
  /// occured not due to [supabase.AuthException].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    void Function(Object exception)? onUnexpectedException,
  }) async {
    try {
      await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
    } on supabase.AuthException catch (authException) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(authException.code);
    } catch (exception) {
      onUnexpectedException?.call(exception);
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Logs in an existing user using [email] and [password].
  ///
  /// [onUnexpectedException] is called when there is an exception
  /// occured not due to [supabase.AuthException].
  ///
  /// Throws a [SignInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signIn({
    required String email,
    required String password,
    void Function(Object exception)? onUnexpectedException,
  }) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on supabase.AuthException catch (authException) {
      throw SignInWithEmailAndPasswordFailure.fromCode(authException.code);
    } catch (exception) {
      onUnexpectedException?.call(exception);
      throw const SignInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [SignOutFailure] if an exception occurs.
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (_) {
      throw const SignOutFailure();
    }
  }
}

extension on supabase.User {
  /// Maps a [supabase.User] to a [User].
  User get toUser {
    return User(
      id: id,
      name: userMetadata?['name']?.toString() ?? 'User',
      email: email,
      createdAt: createdAt,
    );
  }
}
