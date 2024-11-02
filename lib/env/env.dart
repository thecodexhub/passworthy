/// Environment variables for the Passworthy app.
class Env {
  /// Sentry DSN value
  static String get sentryDsn => const String.fromEnvironment('SENTRY_DSN');

  /// Flagsmith API Key Value
  static String get flagsmithApiKey =>
      const String.fromEnvironment('FLAGSMITH_API_KEY');

  /// Supabase URL value
  static String get supabaseUrl => const String.fromEnvironment('SUPABASE_URL');

  /// Supabase Anon Key value
  static String get supabaseAnonKey =>
      const String.fromEnvironment('SUPABASE_ANON_KEY');
}
