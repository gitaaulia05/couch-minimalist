import 'dart:async';
import 'dart:math';
import '../models/splash_config_model.dart';

abstract class SplashLocalDataSource {
  Future<SplashConfigModel> getSplashConfig();
  Stream<double> streamInitializationProgress();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  final Random _random;

  SplashLocalDataSourceImpl({Random? random}) : _random = random ?? Random();

  @override
  Future<SplashConfigModel> getSplashConfig() async {
    // Simulating fast local preference/asset read
    await Future.delayed(const Duration(milliseconds: 50));
    return SplashConfigModel.defaultConfig();
  }

  @override
  Stream<double> streamInitializationProgress() async* {
    // Starting progress aligned with mockup (35%)
    int currentProgress = 35;
    yield currentProgress / 100.0;

    while (currentProgress < 100) {
      await Future.delayed(const Duration(milliseconds: 240));
      // Random increment between 5 and 15
      final int step = _random.nextInt(11) + 5;
      currentProgress = (currentProgress + step).clamp(0, 100);
      yield currentProgress / 100.0;
    }
  }
}
