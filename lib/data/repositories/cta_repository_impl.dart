import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/data/datasources/mock_sdk.dart';
import 'package:flags_test_starter/domain/entities/cta_experiment_entity.dart';
import 'package:flags_test_starter/domain/repositories/cta_repository.dart';

class CtaRepositoryImpl implements CtaRepository {
  CtaRepositoryImpl(this.sdk);

  final MockSdk sdk;

  @override
  Future<Result<CtaExperimentEntity>> getHomeCta() async {
    try {
      final value = await sdk.fetchHomeCTA();

      return Ok(value);
    } on Exception catch (e) {
      return Err(e);
    }
  }
}
