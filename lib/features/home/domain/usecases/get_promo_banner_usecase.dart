import '../entities/promo_banner.dart';
import '../repositories/home_repository.dart';

/// Use case to fetch the featured promo banner.
class GetPromoBannerUseCase {
  final HomeRepository _repository;

  const GetPromoBannerUseCase(this._repository);

  Future<PromoBanner> call() async {
    return await _repository.getPromoBanner();
  }
}
