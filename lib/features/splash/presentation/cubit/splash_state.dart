import '../../domain/entities/splash_config.dart';

enum SplashStatus { initial, loading, completed, failure }

class SplashState {
  final SplashStatus status;
  final double progress;
  final SplashConfig? config;
  final bool isAuraExpanded;
  final String? errorMessage;

  const SplashState({
    this.status = SplashStatus.initial,
    this.progress = 0.35,
    this.config,
    this.isAuraExpanded = false,
    this.errorMessage,
  });

  bool get isCompleted => status == SplashStatus.completed;

  SplashState copyWith({
    SplashStatus? status,
    double? progress,
    SplashConfig? config,
    bool? isAuraExpanded,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      config: config ?? this.config,
      isAuraExpanded: isAuraExpanded ?? this.isAuraExpanded,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          progress == other.progress &&
          config == other.config &&
          isAuraExpanded == other.isAuraExpanded &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^
      progress.hashCode ^
      config.hashCode ^
      isAuraExpanded.hashCode ^
      errorMessage.hashCode;
}
