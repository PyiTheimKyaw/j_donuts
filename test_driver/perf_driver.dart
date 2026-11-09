import 'package:integration_test/integration_test_driver.dart';

/// Writes each `watchPerformance` report to `build/<key>.json`: frame count,
/// average / 90th / 99th percentile / worst build and raster times, and how
/// many frames missed the 16 ms budget.
Future<void> main() => integrationDriver(
  responseDataCallback: (data) async {
    if (data == null) return;
    for (final MapEntry(:key, :value) in data.entries) {
      await writeResponseData(
        value as Map<String, dynamic>,
        testOutputFilename: key,
      );
    }
  },
);
