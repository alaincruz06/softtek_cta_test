import 'package:flags_test_starter/core/value_state.dart';
import 'package:flags_test_starter/data/models/cta_config_model.dart';
import 'package:flags_test_starter/presentation/providers/notifiers.dart';
import 'package:flags_test_starter/presentation/providers/providers.dart';
import 'package:flags_test_starter/presentation/utils/functions.dart';
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
    final sdk = container.read(sdkProvider)..useVariantA();

    final notifier = container.read(ctaNotifierProvider.notifier);

    await notifier.load();

    final state = container.read(ctaNotifierProvider);

    expect(state, isA<Success>());

    expect(
      (state as Success).value,
      CtaConfig(
        text: 'Pruébalo gratis',
        color: parseColor('FF2196F3'),
      ),
    );
  });

  test('Carga Variante B - ValueState = Success', () async {
    final sdk = container.read(sdkProvider)..useVariantB();

    final notifier = container.read(ctaNotifierProvider.notifier);

    await notifier.load();

    final state = container.read(ctaNotifierProvider);

    expect(
      (state as Success).value,
      CtaConfig(
        text: 'Empieza ahora',
        color: parseColor('FF4CAF50'),
      ),
    );
  });

  test('Hay Error - ValueState = Failure (debe saltar a Variante Control)',
      () async {
    final sdk = container.read(sdkProvider)
      ..shouldFail = true
      ..useControl();

    final notifier = container.read(ctaNotifierProvider.notifier);

    await notifier.load();

    final state = container.read(ctaNotifierProvider);

    expect(state, isA<Success>());

    expect(
      (state as Success).value,
      CtaConfig(
        text: 'Ver más',
        color: parseColor('FF9E9E9E'),
      ),
    );
  });
}
