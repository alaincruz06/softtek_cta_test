import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/core/value_state.dart';
import 'package:flutter_test/flutter_test.dart';

// Test de ejemplo: solo para que veas el patrón y comprobar que el esqueleto
// arranca. Puedes borrarlo y escribir los tuyos.
void main() {
  group('Result', () {
    test('Ok resuelve por la rama ok', () {
      const Result<int> r = Ok(42);
      final label = r.fold(ok: (v) => 'ok:$v', err: (e) => 'err');
      expect(label, 'ok:42');
    });

    test('Err resuelve por la rama err', () {
      const Result<int> r = Err('boom');
      final label = r.fold(ok: (v) => 'ok', err: (e) => 'err:$e');
      expect(label, 'err:boom');
    });
  });

  group('ValueState', () {
    test('se puede hacer switch sobre las fases', () {
      const ValueState<String> state = Success('hola');
      final rendered = switch (state) {
        Idle() => 'idle',
        Loading() => 'loading',
        Success(:final value) => value,
        Failure() => 'error',
      };
      expect(rendered, 'hola');
    });
  });
}
