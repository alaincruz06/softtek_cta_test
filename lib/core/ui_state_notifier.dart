import 'package:flags_test_starter/core/value_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Base mínima de notifier MVI (API `Notifier` de Riverpod 3.x).
///
/// Un notifier expone un `ValueState<T>` inmutable y transiciona entre fases.
/// La UI observa el estado con `ref.watch`; nunca muta el estado directamente.
///
/// Cada subclase implementa `build()` devolviendo el estado inicial (normalmente
/// `Idle` o lanzando la carga). Se registra con un `NotifierProvider`.
///
/// Es deliberadamente pequeña: úsala como está, adáptala o ignórala si prefieres
/// tu propio enfoque. Lo importante es el flujo unidireccional, no esta clase.
abstract class UiStateNotifier<T> extends Notifier<ValueState<T>> {
  void setLoading() => state = Loading<T>();
  void setSuccess(T value) => state = Success<T>(value);
  void setError(Object cause) => state = Failure<T>(cause);
}
