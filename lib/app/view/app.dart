import 'package:flutter/material.dart';
import 'package:passworthy/app/env/env.dart';
import 'package:passworthy/l10n/l10n.dart';

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
    print(Env.placeholder);
    return const MaterialApp(
      title: 'Passworthy',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PlaceholderWidget(),
    );
  }
}

/// {@template placeholder_widget}
/// A placeholder widget with [Scaffold] and an [AppBar].
/// {@endtemplate}
class PlaceholderWidget extends StatelessWidget {
  /// {@macro placeholder_widget}
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAppBarTitle),
      ),
    );
  }
}
