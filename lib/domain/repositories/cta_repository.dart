import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/data/models/cta_config_model.dart';

abstract class CtaRepository {
  Future<Result<CtaConfig>> getHomeCta();
}
