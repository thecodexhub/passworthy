import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// The type definition for the builder widget.
typedef BootstrapBuilder = FutureOr<Widget> Function();

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap(BootstrapBuilder builder) async {
  // Capture in Sentry and log all uncaught build phase errors
  // from the framework
  FlutterError.onError = (details) {
    if (!kReleaseMode) Sentry.captureException(details.exceptionAsString());
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Capture in Sentry and log all uncaught asynchronous errors that
  // aren't handled by the Flutter framework.
  PlatformDispatcher.instance.onError = (error, stack) {
    if (!kReleaseMode) Sentry.captureException(error.toString());
    log(error.toString(), stackTrace: stack);
    return true;
  };

  runApp(await builder());
}
