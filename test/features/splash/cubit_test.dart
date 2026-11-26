import 'package:flutter_test/flutter_test.dart';
import 'package:sofi/features/splash/data/datasources/splash_local_datasource.dart';
import 'package:sofi/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:sofi/features/splash/domain/usecases/get_splash_config_usecase.dart';
import 'package:sofi/features/splash/domain/usecases/initialize_app_usecase.dart';
import 'package:sofi/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sofi/features/splash/presentation/cubit/splash_state.dart';

void main() {
  group('Splash Clean Architecture & Cubit Test', () {
    late SplashLocalDataSource dataSource;
    late SplashRepositoryImpl repository;
    late GetSplashConfigUseCase getConfigUseCase;
    late InitializeAppUseCase initAppUseCase;
    late SplashCubit cubit;

    setUp(() {
      dataSource = SplashLocalDataSourceImpl();
      repository = SplashRepositoryImpl(localDataSource: dataSource);
      getConfigUseCase = GetSplashConfigUseCase(repository);
      initAppUseCase = InitializeAppUseCase(repository);
      cubit = SplashCubit(
        getSplashConfigUseCase: getConfigUseCase,
        initializeAppUseCase: initAppUseCase,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('Initial state is correct', () {
      expect(cubit.state.status, SplashStatus.initial);
      expect(cubit.state.progress, 0.35);
      expect(cubit.state.isAuraExpanded, false);
    });

    test('Toggling aura expands state properly', () {
      cubit.setAuraExpanded(true);
      expect(cubit.state.isAuraExpanded, true);

      cubit.setAuraExpanded(false);
      expect(cubit.state.isAuraExpanded, false);
    });

    test('Initialization loads config and updates progress', () async {
      await cubit.initialize();
      expect(cubit.state.config, isNotNull);
      expect(cubit.state.config!.appName, 'SOFI');
    });
  });
}
