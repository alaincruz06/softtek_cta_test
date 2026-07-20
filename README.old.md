# Esqueleto — prueba técnica de feature flags

Proyecto de partida para la prueba. Trae resuelta la fontanería para que no pierdas tiempo en
ella. **Lee el enunciado** (`prueba-tecnica-senior-flutter-ENUNCIADO.md`) para saber qué construir.

## Arrancar

```bash
flutter pub get
flutter run      # abre la app (pantalla vacía con un TODO)
flutter test     # corre los tests
```

Probado con Flutter 3.22+ / Dart 3.4+.

## Qué hay ya hecho

- `lib/core/result.dart` — `Result<T>` (`Ok` / `Err`).
- `lib/core/value_state.dart` — `ValueState<T>` (idle / loading / success / error) para MVI.
- `lib/core/ui_state_notifier.dart` — base mínima de notifier MVI sobre Riverpod.
- `lib/main.dart` — app con Riverpod y una pantalla vacía. El `TODO` marca dónde empezar.
- `test/starter_smoke_test.dart` — test de ejemplo (patrón). Bórralo si quieres.

## Qué te toca a ti

Construir el servicio de flags (contrato + implementación fake), la pantalla con el CTA del
experimento `home_cta` y sus estados, el panel de debug y algún test. **Organiza las carpetas como
veas** — cómo lo estructures es parte de lo que evaluamos. Y no te olvides del `DESIGN.md`: es lo
primero que miramos.

Estas piezas de `core/` son un punto de partida, no una jaula: úsalas, cámbialas o sustitúyelas si
tu diseño lo pide (y cuéntanoslo en el `DESIGN.md`).
