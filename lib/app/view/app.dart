import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passworthy/app/app.dart';
import 'package:passworthy/l10n/l10n.dart';

/// {@template app}
/// Entry point of the application. This is the first widget that
/// in the widget tree.
/// {@endtemplate}
class App extends ConsumerWidget {
  /// {@macro app}
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eager Initialize required providers
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
class PlaceholderWidget extends ConsumerWidget {
  /// {@macro placeholder_widget}
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final res = ref.watch(killSwitchStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAppBarTitle),
      ),
      body: switch (res) {
        AsyncData(:final value) => Text(value.toString()),
        _ => const Text('nothing'),
      },
    );
  }
}
