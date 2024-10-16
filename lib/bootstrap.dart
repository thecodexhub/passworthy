import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The type definition for the builder widget.
typedef BootstrapBuilder = FutureOr<Widget> Function();

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap(BootstrapBuilder builder) async {
  // Log all uncaught build phase errors from the framework
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Log all uncaught asynchronous errors that aren't handled
  // by the Flutter framework.
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };

  runApp(await builder());
}
