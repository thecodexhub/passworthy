/// Error codes to identify authentication related exceptions.
/// https://supabase.com/docs/guides/auth/debugging/error-codes#auth-error-codes-table
enum AuthenticationErrorCode {
  /// Exception raised because of configuration error,
  /// e.g. - email_provider_disabled, signup_disabled etc
  configurationError,

  /// Email sending is not allowed for this address as your project is
  /// using the default SMTP service.
  emailAddressNotAuthorized,

  /// Email address already exists in the system.
  emailAlreadyExists,

  /// Signing in is not allowed for this user as the email address
  /// is not confirmed.
  emailNotConfirmed,

  /// Processing the request took too long. Retry the request.
  requestTimeout,

  /// User with this information (email address, phone number) cannot
  /// be created again as it already exists.
  userAlreadyExists,

  /// User to which the API request relates has a banned_until property
  /// which is still active. No further API requests should be attempted
  /// until this field is cleared.
  userBanned,

  /// User to which the API request relates no longer exists.
  userNotFound,

  /// Provided parameters are not in the expected format.
  validationFailed,

  /// User is signing up or changing their password without meeting the
  /// password strength criteria.
  weakPassword,

  /// All other exceptions and errors, that were not expected to happen.
  unexpected,
}
