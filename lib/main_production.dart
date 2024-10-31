import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:passworthy/app/app.dart';
import 'package:passworthy/bootstrap.dart';
import 'package:passworthy/env/env.dart';
import 'package:remote_flags_config/remote_flags_config.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // * Initialize Sentry Flutter SDK
  await SentryFlutter.init(
    (options) {
      options
        ..dsn = Env.sentryDsn
        ..environment = 'development'
        // Improve stack traces in the dashboard
        ..considerInAppFramesByDefault = false
        ..addInAppInclude('passworthy')
        // Use the beforeSend callback to filter which events are sent
        ..beforeSend = (SentryEvent event, Hint hint) async {
          // Ignore events that are not from release builds
          if (!kReleaseMode) {
            return null;
          }
          // If there was no response, it means that a connection error occurred
          // Do not log this to Sentry
          final exception = event.throwable;
          if (exception is DioException && exception.response == null) {
            return null;
          }
          // For all other events, return the event as is
          return event;
        };
    },
  );

  // * Initialize Remote Flags Config
  final remoteFlagsConfig = await FlagsmithRemoteFlagsConfig.initialize(
    apiKey: Env.flagsmithApiKey,
  );

  unawaited(
    bootstrap(
      () async => const App(),
      overrides: [
        remoteFlagsConfigProvider.overrideWithValue(remoteFlagsConfig),
      ],
    ),
  );
}
