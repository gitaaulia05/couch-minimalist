import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sofi/core/constants/app_strings.dart';
import 'package:sofi/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:sofi/features/splash/presentation/cubit/splash_state.dart';
import 'package:sofi/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Test mock/stub for SplashCubit
class TestSplashCubit extends Cubit<SplashState> implements SplashCubit {
  TestSplashCubit()
      : super(const SplashState(
          status: SplashStatus.loading,
          progress: 0.35,
        ));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  void setAuraExpanded(bool expanded) {
    emit(state.copyWith(isAuraExpanded: expanded));
  }
}

void main() {
  testWidgets('SOFI Splash Screen renders brand elements smoke test',
      (WidgetTester tester) async {
    final testCubit = TestSplashCubit();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SplashCubit>.value(
          value: testCubit,
          child: const SplashPage(),
        ),
      ),
    );

    // Verify Brand Name and Tagline are rendered
    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.brandTagline), findsOneWidget);

    // Verify Origin and Specs are present
    expect(find.text(AppStrings.originIndicator.toUpperCase()), findsOneWidget);
    expect(find.text(AppStrings.specNordic.toUpperCase()), findsOneWidget);
    expect(find.text(AppStrings.specWood.toUpperCase()), findsOneWidget);
    expect(find.text(AppStrings.specLinen.toUpperCase()), findsOneWidget);

    // Verify Meta Title & Version
    expect(find.text(AppStrings.brandMetaTitle), findsOneWidget);
    expect(find.text(AppStrings.appVersion), findsOneWidget);

    // Pump a single frame
    await tester.pump();
  });
}
