import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/domain/entities/cta_experiment_entity.dart';
import 'package:flags_test_starter/domain/repositories/cta_repository.dart';

class GetHomeCta {
  GetHomeCta(this.repository);

  final CtaRepository repository;

  Future<Result<CtaExperimentEntity>> getHomeCtaCall() {
    return repository.getHomeCta();
  }
}
