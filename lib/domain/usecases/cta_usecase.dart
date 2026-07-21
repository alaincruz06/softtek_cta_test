import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/data/models/cta_config_model.dart';
import 'package:flags_test_starter/domain/repositories/cta_repository.dart';

class GetHomeCta {
  GetHomeCta(this.repository);

  final CtaRepository repository;

  Future<Result<CtaConfig>> getHomeCtaCall() {
    return repository.getHomeCta();
  }
}
