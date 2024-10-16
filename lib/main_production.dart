import 'dart:async';

import 'package:passworthy/app/app.dart';
import 'package:passworthy/bootstrap.dart';

void main() async {
  unawaited(
    bootstrap(() async => const App()),
  );
}
