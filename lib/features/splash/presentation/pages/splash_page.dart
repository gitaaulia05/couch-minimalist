import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/datasources/splash_local_datasource.dart';
import '../../data/repositories/splash_repository_impl.dart';
import '../../domain/usecases/get_splash_config_usecase.dart';
import '../../domain/usecases/initialize_app_usecase.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';
import '../widgets/ambient_aura_background.dart';
import '../widgets/brand_identity_view.dart';
import '../widgets/editorial_tags_view.dart';
import '../widgets/fluid_progress_bar.dart';
import '../widgets/top_indicator_bar.dart';

/// The entry splash page orchestrating the layout, ambient background,
/// and reactive state transitions via SplashCubit.
class SplashPage extends StatelessWidget {
  final VoidCallback? onInitializationComplete;

  const SplashPage({
    super.key,
    this.onInitializationComplete,
  });

  /// Factory helper that instantiates SplashPage along with its Clean Architecture dependencies.
  static Widget create({VoidCallback? onInitializationComplete}) {
    final localDataSource = SplashLocalDataSourceImpl();
    final repository =
        SplashRepositoryImpl(localDataSource: localDataSource);
    final getConfigUseCase = GetSplashConfigUseCase(repository);
    final initAppUseCase = InitializeAppUseCase(repository);

    return BlocProvider(
      create: (_) => SplashCubit(
        getSplashConfigUseCase: getConfigUseCase,
        initializeAppUseCase: initAppUseCase,
      )..initialize(),
      child: SplashPage(
        onInitializationComplete: onInitializationComplete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.isCompleted,
      listener: (context, state) async {
        // Smooth pause before navigating forward
        await Future.delayed(const Duration(milliseconds: 350));
        if (context.mounted) {
          onInitializationComplete?.call();
        }
      },
      builder: (context, state) {
        final cubit = context.read<SplashCubit>();
        final config = state.config;

        return Scaffold(
          backgroundColor: AppColors.surface,
          body: Stack(
            children: [
              // 1. Organic Ambient Background Aura
              AmbientAuraBackground(
                isExpanded: state.isAuraExpanded,
              ),

              // 2. Main Content Canvas
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Indicator Bar
                      TopIndicatorBar(
                        originText: config?.origin ?? AppStrings.originIndicator,
                      ),

                      // Center Brand Identity & Editorial Tags
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BrandIdentityView(
                            appName: config?.appName ?? AppStrings.appName,
                            tagline: config?.tagline ?? AppStrings.brandTagline,
                            onTactileInteraction: (isPressed) {
                              cubit.setAuraExpanded(isPressed);
                            },
                          ),
                          const SizedBox(height: 24),
                          EditorialTagsView(
                            specs: config?.specifications ??
                                AppStrings.editorialSpecs,
                          ),
                        ],
                      ),

                      // Bottom Progress & Brand Meta
                      FluidProgressBar(
                        progress: state.progress,
                        brandMetaTitle: config?.brandMetaTitle ??
                            AppStrings.brandMetaTitle,
                        version: config?.version ?? AppStrings.appVersion,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
