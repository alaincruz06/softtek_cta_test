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
- `lib/data/datasources/models/` — Modelo que se lee del SDK externo (el objeto `cta_config_model` no varía, por eso no mapeo en domain)
- `lib/data/repositories/` — Implementación de repositorios de la capa `domain`
<!--  -->
- `lib/domain/` — Capa de abstracción media entre SDK externos y la app
- `lib/domain/repositories/` — Clases abstractas que permiten cambiar providers sin necesidad de modificar la lógica de negocio
- `lib/domain/usecases/` — Clase intermedia entre la UI y los repositorios para no llamar directamente al repositorio desde los notifiers/providers
<!--  -->
- `lib/presentation/` — Capa de UI/UX padre (widgets, screens, theme, routing, etc)
- `lib/presentation/providers/` — Providers/Notifiers de Riverpod para manejar los estados
- `lib/presentation/utils/` — Clases útiles con métodos o clases para acceder en la capa `presentation`
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
│   ├── models/
│   │     cta_config_model.dart    
│   │  
│   └── repositories/
│         cta_repository_impl.dart
│
├── domain/
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
│   ├── utils/
│   │     functions.dart
│   │
│   └── widgets/
│         cta_button_widget.dart
│
└── main.dart

## Arquitectura/Definición

Se decide esta segunda arquitectura por su semejanza a la resolución de la tarea y similitud con posibles escenarios de variantes como Remote Config en Firebase, en caso de modificar el SDK externo se modifica solamente la llamada en `lib/data/datasources/mock_sdk` y no debería cambiar la lógica de negocio en las clases internas (domain/presentation). 
 Se crean los métodos auxiliares en `mock_sdk.dart` para simular las llamadas a diferentes variables en el SDK sin necesidad de pasar por parámetros las variantes

El comportamiento de los botones (texto y colores) están cableados en la capa de presentation mapeando desde el Map retornado en el SDK (que se lee en `lib/data/datasources/models/cta_config_model.dart`) y no se decide mapear este objeto (en la capa `domain`) por su simplicidad y poco cambio, se pasa la info al `lib/domain/usecases/` y de ahí se modifican los botones.


## Tests

Hay 2 ficheros de tests (uno para validar la conexión entre la llamada al SDK y su mapeo con la `sealed class Result` : `cta_repository_impl_test`, y otro para validar los resultados devueltos usando el provider `ctaNotifierProvider` - que a su vez llama al usecase `GetHomeCta` - : `notifiers_test`)