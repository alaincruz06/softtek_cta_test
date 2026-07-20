import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/domain/entities/cta_experiment_entity.dart';

abstract class CtaRepository {
  Future<Result<CtaExperimentEntity>> getHomeCta();
}
