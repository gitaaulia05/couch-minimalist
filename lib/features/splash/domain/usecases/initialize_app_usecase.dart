import '../repositories/splash_repository.dart';

/// Use case that kicks off app initialization and emits simulated progress stream.
class InitializeAppUseCase {
  final SplashRepository _repository;

  const InitializeAppUseCase(this._repository);

  Stream<double> call() {
    return _repository.startInitialization();
  }
}
