/// Environment variables for the Passworthy app.
class Env {
  /// Sentry DSN value
  static String get sentryDsn => const String.fromEnvironment('SENTRY_DSN');
}
