# Explicación y pasos de :—> prueba técnica de feature flags

Fichero de explicación de la prueba. 

## Arranque

```bash
fvm releases            # ver releases de Flutter para instalar una versión compatible
fvm install 3.44.1      # instalar Dart SDK v.3.12.1
fvm use 3.44.1          # usar la versión
```

<!-- Conflicto con Flutter 3.27.1:
The current Dart SDK version is 3.6.0.

Because no versions of very_good_analysis match >10.3.0 <11.0.0 and very_good_analysis 10.3.0 requires SDK version ^3.12.0, very_good_analysis
  ^10.3.0 is forbidden. -->

## Arquitectura/Carpetas + Ficheros 

- `lib/core/` — Ficheros existentes
<!--  -->
- `lib/data/` — Capa de acceso a datos (SDK externo, mock, etc) + modelos
- `lib/data/datasources/` — Llamadas a servicios externos (o SharedPrefs) - se puede separar en `datasources/local` y `datasources/remote`
- `lib/data/repositories/` — Implementación de repositorios de la capa `domain`
<!--  -->
- `lib/domain/` — Capa de abstracción media entre SDK externos y la app
- `lib/domain/repositories/` — Clases abstractas que permiten cambiar providers sin necesidad de modificar la lógica de negocio
- `lib/domain/entities/` — Entidades (modelos) que manejan la lógica que se necesita mostrar/usar sin depender del sdk externo
- `lib/domain/usecases/` — Clase intermedia entre la UI y los repositorios para no llamar directamente al repositorio desde los notifiers/providers
<!--  -->
- `lib/presentation/` — Capa de UI/UX padre (widgets, screens, theme, routing, etc)
- `lib/presentation/providers/` — Providers/Notifiers de Riverpod para manejar los estados
- `lib/presentation/widgets/` — Widgets reutilizables como componentes de diseño.

## Arquitectura/Diagrama

lib/
│
├── core/
│   ├── result.dart
│   ├── ui_state_notifier.dart
│   └── value_state.dart
│
├── data/
│   ├── datasources/
│   │     mock_sdk.dart     
│   │
│   └── repositories/
│         cta_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │     cta_experiment_entity.dart
│   │
│   ├── repositories/
│   │     cta_repository.dart
│   │
│   └── usecases/
│         cta_usecase.dart
│
├── presentation/
│   ├── providers/
│   │     notifiers.dart
│   │     providers.dart
│   │
│   └── widgets/
│         cta_button_widget.dart
│
└── main.dart

## Arquitectura/Definición

Se decide esta arquitectura por su simplicidad y escalabilidad, en caso de modificar el SDK externo se modifica solamente la llamada en `lib/data/datasources/mock_sdk` y no debería cambiar la lógica de negocio en las clases internas (domain/presentation). 
 Se pudiera reemplazar por otra arquitectura de monorepo consumiendo de un paquete/librería dentro del mismo repo (u otro repo interno de la empresa) al que se haría la misma referencia como mock_sdk y se modificaría solo en el paquete externo la llamada al SDK.

El comportamiento de los botones (texto y colores) están cableados en la capa de presentation de momento para sencillez pero se puede mapear desde un JSON o un Map retornado desde el SDK y se escribiría en una carpeta `lib/data/datasources/models` que lee directamente del SDK y este objeto se mapearía luego en `lib/domain/entities/`, se pasa la info al `lib/domain/usecases/` y de ahí se modifican los botones.


## Tests

Hay 2 ficheros de tests (uno para validar la conexión entre la llamada al SDK y su mapeo con la `sealed class Result` : `cta_repository_impl_test`, y otro para validar los resultados devueltos usando el provider `ctaNotifierProvider` - que a su vez llama al usecase `GetHomeCta` - : `notifiers_test`)