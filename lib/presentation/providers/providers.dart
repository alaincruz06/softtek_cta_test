import 'package:flags_test_starter/data/datasources/mock_sdk.dart';
import 'package:flags_test_starter/data/repositories/cta_repository_impl.dart';
import 'package:flags_test_starter/domain/repositories/cta_repository.dart';
import 'package:flags_test_starter/domain/usecases/cta_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<MockSdk> sdkProvider = Provider(
  (_) => MockSdk(),
);

final repositoryProvider = Provider<CtaRepository>(
  (ref) => CtaRepositoryImpl(
    ref.read(sdkProvider),
  ),
);

final Provider<GetHomeCta> getHomeCtaProvider = Provider(
  (ref) => GetHomeCta(
    ref.read(repositoryProvider),
  ),
);
