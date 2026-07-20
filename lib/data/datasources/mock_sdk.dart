import 'package:flags_test_starter/domain/entities/cta_experiment_entity.dart';

class MockSdk {
  CtaExperimentEntity variant = CtaExperimentEntity.control;

  bool shouldFail = false;

  bool shouldDelay = true;

  Future<CtaExperimentEntity> fetchHomeCTA() async {
    if (shouldDelay) {
      await Future<void>.delayed(
        const Duration(seconds: 2),
      );
    }

    if (shouldFail) {
      throw Exception('Error de red - simulación');
    }

    return variant;
  }
}
