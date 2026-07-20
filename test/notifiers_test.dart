import 'package:flags_test_starter/core/value_state.dart';
import 'package:flags_test_starter/domain/entities/cta_experiment_entity.dart';
import 'package:flags_test_starter/presentation/providers/notifiers.dart';
import 'package:flags_test_starter/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  test('Carga inicial - debe ser ValueState = Loading', () {
    final state = container.read(ctaNotifierProvider);

    expect(state, isA<Loading>());
  });

  test('Carga Variante A - ValueState = Success', () async {
    final sdk = container.read(sdkProvider)
      ..variant = CtaExperimentEntity.variantA;

    final notifier = container.read(ctaNotifierProvider.notifier);

    await notifier.load();

    final state = container.read(ctaNotifierProvider);

    expect(state, isA<Success>());

    expect(
      (state as Success).value,
      CtaExperimentEntity.variantA,
    );
  });

  test('Carga Variante B - ValueState = Success', () async {
    final sdk = container.read(sdkProvider)
      ..variant = CtaExperimentEntity.variantB;

    final notifier = container.read(ctaNotifierProvider.notifier);

    await notifier.load();

    final state = container.read(ctaNotifierProvider);

    expect(
      (state as Success).value,
      CtaExperimentEntity.variantB,
    );
  });

  test('Hay Error - ValueState = Failure (debe saltar a Variante Control)',
      () async {
    final sdk = container.read(sdkProvider)..shouldFail = true;

    final notifier = container.read(ctaNotifierProvider.notifier);

    await notifier.load();

    final state = container.read(ctaNotifierProvider);

    expect(state, isA<Success>());

    expect(
      (state as Success).value,
      CtaExperimentEntity.control,
    );
  });
}
