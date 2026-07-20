/// Estado de UI inmutable para el patrón MVI.
///
/// Representa las fases por las que pasa un dato asíncrono en pantalla.
/// La UI hace `switch` sobre esto y decide qué pintar en cada fase.
///
/// (En el proyecto real hay más matices —por ejemplo un estado `empty`—,
///  pero para la prueba con esto sobra. Amplíalo si lo ves necesario.)
sealed class ValueState<T> {
  const ValueState();

  const factory ValueState.idle() = Idle<T>;
  const factory ValueState.loading() = Loading<T>;
  const factory ValueState.success(T value) = Success<T>;
  const factory ValueState.error(Object cause) = Failure<T>;
}

/// Aún no se ha pedido nada.
final class Idle<T> extends ValueState<T> {
  const Idle();
}

/// Cargando.
final class Loading<T> extends ValueState<T> {
  const Loading();
}

/// Hay dato.
final class Success<T> extends ValueState<T> {
  const Success(this.value);
  final T value;
}

/// Falló.
final class Failure<T> extends ValueState<T> {
  const Failure(this.cause);
  final Object cause;
}
