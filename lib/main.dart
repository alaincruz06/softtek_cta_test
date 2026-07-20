import 'package:flags_test_starter/core/value_state.dart';
import 'package:flags_test_starter/domain/entities/cta_experiment_entity.dart';
import 'package:flags_test_starter/presentation/providers/notifiers.dart';
import 'package:flags_test_starter/presentation/widgets/cta_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: StarterApp()));
}

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba técnica — feature flags',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}

/// Pantalla de partida. Aquí es donde construyes la prueba.
///
/// El objetivo (ver el enunciado, sección 2): un botón (CTA) cuyo texto y
/// estilo dependan del experimento `home_cta`, resuelto de forma asíncrona a
/// través de tu servicio de flags, con sus estados loading / éxito / error
/// y un panel de debug para forzar variante y simular loading/error.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ctaNotifierProvider);
    final notifier = ref.read(ctaNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            switch (state) {
              Loading() => const SizedBox(
                  width: 220,
                  height: 48,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              Success(:final value) => buildButton(value),
              Failure() => buildButton(
                  CtaExperimentEntity.control,
                ),
              Idle() => const SizedBox(),
            },
            const SizedBox(height: 50),
            const Text(
              'Panel de prueba',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: notifier.setLoading,
              child: const Text('Cargando...'),
            ),
            ElevatedButton(
              onPressed: () {
                notifier.setSuccess(
                  CtaExperimentEntity.control,
                );
              },
              child: const Text('Control'),
            ),
            ElevatedButton(
              onPressed: () {
                notifier.setSuccess(
                  CtaExperimentEntity.variantA,
                );
              },
              child: const Text('Variant A'),
            ),
            ElevatedButton(
              onPressed: () {
                notifier.setSuccess(
                  CtaExperimentEntity.variantB,
                );
              },
              child: const Text('Variant B'),
            ),
            ElevatedButton(
              onPressed: () {
                notifier.setError('Error de prueba');
              },
              child: const Text('Error'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildButton(CtaExperimentEntity variant) {
  switch (variant) {
    case CtaExperimentEntity.control:
      return const CtaButtonWidget(
        text: 'Ver más',
        color: Colors.grey,
      );

    case CtaExperimentEntity.variantA:
      return const CtaButtonWidget(
        text: 'Pruébalo gratis',
        color: Colors.blue,
      );

    case CtaExperimentEntity.variantB:
      return const CtaButtonWidget(
        text: 'Empieza ahora',
        color: Colors.green,
      );
  }
}
