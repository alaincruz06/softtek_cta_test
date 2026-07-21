import 'dart:async';

import 'package:flags_test_starter/core/ui_state_notifier.dart';
import 'package:flags_test_starter/core/value_state.dart';
import 'package:flags_test_starter/data/datasources/mock_sdk.dart';
import 'package:flags_test_starter/data/models/cta_config_model.dart';
import 'package:flags_test_starter/domain/usecases/cta_usecase.dart';
import 'package:flags_test_starter/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ctaNotifierProvider =
    NotifierProvider<CtaNotifier, ValueState<CtaConfig>>(
  CtaNotifier.new,
);

class CtaNotifier extends UiStateNotifier<CtaConfig> {
  GetHomeCta get _getHomeCta => ref.read(getHomeCtaProvider);
  MockSdk get _sdk => ref.read(sdkProvider);

  @override
  ValueState<CtaConfig> build() {
    state = const Loading();
    unawaited(load());

    return state;
  }

  Future<void> load() async {
    state = const Loading();
    final result = await _getHomeCta.getHomeCtaCall();

    if (!ref.mounted) return;

    result.fold(
      ok: setSuccess,
      err: (_) => setSuccess(
        const CtaConfig(
          text: 'Ver más',
          color: Colors.grey,
        ),
      ),
    );
  }

  Future<void> useControl() async {
    _sdk.useControl();
    await load();
  }

  Future<void> useVariantA() async {
    _sdk.useVariantA();
    await load();
  }

  Future<void> useVariantB() async {
    _sdk.useVariantB();
    await load();
  }

  Future<void> simulateError() async {
    _sdk.simulateError();
    await load();
  }
}
