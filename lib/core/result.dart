/// Tipo result/either sellado usado en todo el ecosistema.
///
/// Las capas de datos y los casos de uso devuelven `Result<T>` en lugar de
/// lanzar excepciones hacia arriba. La UI decide qué hacer con `Ok` / `Err`.
///
/// Puedes usarlo tal cual o ampliarlo si lo necesitas.
sealed class Result<T> {
  const Result();

  /// Azúcar para no tener que hacer siempre un `switch`.
  R fold<R>({
    required R Function(T value) ok,
    required R Function(Object error) err,
  }) {
    final self = this;
    return switch (self) {
      Ok<T>() => ok(self.value),
      Err<T>() => err(self.error),
    };
  }
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.error);
  final Object error;
}
