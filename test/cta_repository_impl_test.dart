import 'package:flags_test_starter/core/result.dart';
import 'package:flags_test_starter/data/datasources/mock_sdk.dart';
import 'package:flags_test_starter/data/models/cta_config_model.dart';
import 'package:flags_test_starter/data/repositories/cta_repository_impl.dart';
import 'package:flags_test_starter/domain/repositories/cta_repository.dart';
import 'package:flags_test_starter/presentation/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockSdk sdk;
  late CtaRepository repository;

  setUp(() {
    sdk = MockSdk();
    repository = CtaRepositoryImpl(sdk);
  });

  test('Devuelve Result = OK', () async {
    sdk.useControl();

    final result = await repository.getHomeCta();

    expect(result, isA<Ok<CtaConfig>>());

    result.fold(
      ok: (value) {
        expect(
          value,
          CtaConfig(
            text: 'Ver más',
            color: parseColor('FF9E9E9E'),
          ),
        );
      },
      err: (_) => fail('Expected Ok'),
    );
  });

  test('Devuelve Result = Err', () async {
    sdk.shouldFail = true;

    final result = await repository.getHomeCta();

    expect(result, isA<Err>());
  });
}
