import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('domain layers contain no Flutter imports', () {
    final offenders = <String>[];
    final features = Directory('lib/features');

    for (final entity in features.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (!entity.path.contains(
        '${Platform.pathSeparator}domain${Platform.pathSeparator}',
      )) {
        continue;
      }
      final source = entity.readAsStringSync();
      if (source.contains("import 'package:flutter/") ||
          source.contains("import 'dart:ui'")) {
        offenders.add(entity.path);
      }
    }

    expect(offenders, isEmpty, reason: 'Domain must not import Flutter');
  });
}
