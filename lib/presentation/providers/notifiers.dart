import 'dart:async';

import 'package:flags_test_starter/core/ui_state_notifier.dart';
import 'package:flags_test_starter/core/value_state.dart';
import 'package:flags_test_starter/domain/entities/cta_experiment_entity.dart';
import 'package:flags_test_starter/domain/usecases/cta_usecase.dart';
import 'package:flags_test_starter/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ctaNotifierProvider =
    NotifierProvider<CtaNotifier, ValueState<CtaExperimentEntity>>(
  CtaNotifier.new,
);

class CtaNotifier extends UiStateNotifier<CtaExperimentEntity> {
  GetHomeCta get _getHomeCta => ref.read(getHomeCtaProvider);

  @override
  ValueState<CtaExperimentEntity> build() {
    state = const Loading();
    unawaited(load());

    return state;
  }

  Future<void> load() async {
    final result = await _getHomeCta.getHomeCtaCall();

    result.fold(
      ok: setSuccess,
      err: (_) => setSuccess(CtaExperimentEntity.control),
    );
  }
}
