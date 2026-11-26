import '../entities/splash_config.dart';

/// Abstract contract for the Splash repository following Clean Architecture.
abstract class SplashRepository {
  /// Retrieves initial application & brand configuration.
  Future<SplashConfig> getSplashConfig();

  /// Starts the warm-up and initialization stream, emitting progress values between 0.0 and 1.0.
  Stream<double> startInitialization();
}
