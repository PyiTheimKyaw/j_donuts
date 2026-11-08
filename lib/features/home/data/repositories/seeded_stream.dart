import 'dart:async';

import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';

/// Waits for the first-launch seed, then streams [source]. Non-[Failure]
/// errors become [StorageFailure] so the UI only ever handles typed failures.
Stream<T> seededStream<T>(SeedLoader seed, Stream<T> Function() source) =>
    Stream.fromFuture(seed.ensureSeeded())
        .asyncExpand((_) => source())
        .transform(
          StreamTransformer<T, T>.fromHandlers(
            handleError: (error, stackTrace, sink) => sink.addError(
              error is Failure ? error : StorageFailure(message: '$error'),
              stackTrace,
            ),
          ),
        );
