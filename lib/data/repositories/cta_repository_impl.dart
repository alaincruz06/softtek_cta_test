import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/data/datasources/mock_sdk.dart';
import 'package:flags_test_starter/data/models/cta_config_model.dart';
import 'package:flags_test_starter/domain/repositories/cta_repository.dart';
import 'package:flutter/material.dart' show Color;

class CtaRepositoryImpl implements CtaRepository {
  CtaRepositoryImpl(this.sdk);

  final MockSdk sdk;

  @override
  Future<Result<CtaConfig>> getHomeCta() async {
    try {
      final json = await sdk.fetchHomeCta();

      return Ok(
        CtaConfig(
          text: json['text'] as String,
          color: _parseColor(json['color'] as String),
        ),
      );
    } on Exception catch (e) {
      return Err(e);
    }
  }

  Color _parseColor(String hexColor) {
    var hex = hexColor.replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return Color(int.parse(hex, radix: 16));
  }
}
