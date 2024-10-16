import 'package:flutter/material.dart';

/// {@template app}
/// Entry point of the application. This is the first widget that
/// in the widget tree.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

/// {@template app_view}
/// View for the app. Wraps the [MaterialApp] widget.
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passworthy',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Passworthy'),
        ),
      ),
    );
  }
}
