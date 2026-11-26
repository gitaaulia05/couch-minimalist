import '../entities/splash_config.dart';
import '../repositories/splash_repository.dart';

/// Use case to fetch the splash screen configuration and brand specs.
class GetSplashConfigUseCase {
  final SplashRepository _repository;

  const GetSplashConfigUseCase(this._repository);

  Future<SplashConfig> call() async {
    return await _repository.getSplashConfig();
  }
}
