import 'dart:convert';

import 'package:j_donuts/core/result/failure.dart';
import 'package:j_donuts/features/home/data/datasources/seed_loader.dart';
import 'package:j_donuts/features/home/data/dto/catalog_dto.dart';

/// `GET /v1/catalog`. Throws a [Failure] on any problem; callers never see a
/// raw transport or parsing error.
abstract interface class RemoteCatalogDataSource {
  Future<CatalogPayloadDto> fetchCatalog();
}

/// Serves a bundled `/v1` response through the same envelope a real server
/// would use, and refuses to answer while offline so airplane mode behaves
/// exactly as it would against a network API. A Dio implementation of
/// [RemoteCatalogDataSource] replaces it without touching the repository.
class AssetRemoteCatalogDataSource implements RemoteCatalogDataSource {
  AssetRemoteCatalogDataSource({
    required this._loadAsset,
    required this._isOnline,
    this.latency = defaultLatency,
  });

  static const String endpoint = 'assets/remote/v1/catalog.json';
  static const Duration defaultLatency = Duration(milliseconds: 700);

  final AssetLoader _loadAsset;
  final Future<bool> Function() _isOnline;
  final Duration latency;

  @override
  Future<CatalogPayloadDto> fetchCatalog() async {
    if (!await _isOnline()) {
      throw const NetworkFailure(message: 'Device is offline');
    }
    if (latency > Duration.zero) await Future<void>.delayed(latency);

    final envelope = _decode(await _loadAsset(endpoint));
    final error = envelope.error;
    if (error != null) throw NetworkFailure(message: error.message);
    final data = envelope.data;
    if (data == null) {
      throw const UnexpectedFailure(message: 'Envelope has no data');
    }
    return data;
  }

  ApiEnvelope<CatalogPayloadDto> _decode(String body) {
    try {
      return ApiEnvelope.fromJson(
        jsonDecode(body) as Map<String, dynamic>,
        (json) => CatalogPayloadDto.fromJson(json! as Map<String, dynamic>),
      );
    } on FormatException catch (error) {
      throw UnexpectedFailure(message: 'Malformed response: $error');
      // Generated fromJson reports a wrong shape only as TypeError; at this
      // boundary it must become a typed failure, not a crash.
      // ignore: avoid_catching_errors
    } on TypeError catch (error) {
      throw UnexpectedFailure(message: 'Unexpected response shape: $error');
    }
  }
}
