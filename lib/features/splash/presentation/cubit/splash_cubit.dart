import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_splash_config_usecase.dart';
import '../../domain/usecases/initialize_app_usecase.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetSplashConfigUseCase getSplashConfigUseCase;
  final InitializeAppUseCase initializeAppUseCase;

  StreamSubscription<double>? _progressSubscription;

  SplashCubit({
    required this.getSplashConfigUseCase,
    required this.initializeAppUseCase,
  }) : super(const SplashState());

  /// Initializes splash screen data and begins progress countdown/warmup.
  Future<void> initialize() async {
    try {
      emit(state.copyWith(status: SplashStatus.loading));
      final config = await getSplashConfigUseCase();
      emit(state.copyWith(config: config));

      _progressSubscription?.cancel();
      _progressSubscription = initializeAppUseCase().listen(
        (progress) {
          if (isClosed) return;
          if (progress >= 1.0) {
            emit(state.copyWith(
              progress: 1.0,
              status: SplashStatus.completed,
            ));
          } else {
            emit(state.copyWith(
              progress: progress,
              status: SplashStatus.loading,
            ));
          }
        },
        onError: (err) {
          if (isClosed) return;
          emit(state.copyWith(
            status: SplashStatus.failure,
            errorMessage: err.toString(),
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: SplashStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Interactive tactile feedback: toggles central aura scaling when user interacts with logo.
  void setAuraExpanded(bool expanded) {
    if (state.isAuraExpanded == expanded) return;
    emit(state.copyWith(isAuraExpanded: expanded));
  }

  @override
  Future<void> close() {
    _progressSubscription?.cancel();
    return super.close();
  }
}
