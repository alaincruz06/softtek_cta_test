class MockSdk {
  bool shouldFail = false;
  bool get shouldDelay => true;

  set shouldDelay(bool enabled) {
    shouldDelay = enabled;
  }

  Map<String, dynamic> _homeCta = _controlPayload;

  static const Map<String, dynamic> _controlPayload = {
    'text': 'Ver más',
    'color': '#9E9E9E',
  };

  static const Map<String, dynamic> _variantAPayload = {
    'text': 'Pruébalo gratis',
    'color': '#2196F3',
  };

  static const Map<String, dynamic> _variantBPayload = {
    'text': 'Empieza ahora',
    'color': '#4CAF50',
  };

  Future<Map<String, dynamic>> fetchHomeCta() async {
    if (shouldFail) {
      throw Exception('No se pudo cargar la info del SDK');
    } else if (shouldDelay) {
      await Future<void>.delayed(const Duration(seconds: 2)).then(
        (_) => Map<String, dynamic>.from(_homeCta),
      );
    }

    return Map<String, dynamic>.from(_homeCta);
  }

  void useControl() {
    shouldFail = false;
    _homeCta = _controlPayload;
  }

  void useVariantA() {
    shouldFail = false;
    _homeCta = _variantAPayload;
  }

  void useVariantB() {
    shouldFail = false;
    _homeCta = _variantBPayload;
  }

  void simulateError() {
    shouldFail = true;
  }
}
