import '../entities/product_category.dart';
import '../repositories/home_repository.dart';

/// Use case to fetch product categories for the filter chip row.
class GetCategoriesUseCase {
  final HomeRepository _repository;

  const GetCategoriesUseCase(this._repository);

  Future<List<ProductCategory>> call() async {
    return await _repository.getCategories();
  }
}
